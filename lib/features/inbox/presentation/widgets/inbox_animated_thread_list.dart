import 'dart:math' as math;

import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef InboxAnimatedListFrameBuilder = Widget Function(
  BuildContext context,
  Widget list,
  bool isVisuallyEmpty,
);

/// Diffs [threads] and animates insert / remove / pin-reorder like a chat list.
class InboxAnimatedThreadList extends StatefulWidget {
  final List<InboxThread> threads;

  /// Built for each visible row (including rows mid exit animation).
  final Widget Function(
    BuildContext context,
    InboxThread thread,
    int index,
    int visibleCount,
  ) itemBuilder;

  /// Optional separator between non-exiting rows.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// Wraps the animated column (e.g. card chrome). [isVisuallyEmpty] is true
  /// when there are no rows left to paint — including after exit animations.
  final InboxAnimatedListFrameBuilder? frameBuilder;

  /// Archive from chats → slide toward trailing; unarchive → toward leading.
  final bool removeSlideTowardEnd;

  final Duration removeDuration;
  final Duration insertDuration;
  final Duration reorderDuration;

  /// Approximate row height used when pin reorders the list.
  final double? itemExtent;

  /// When true, builds a [SliverList] so a parent [CustomScrollView] can
  /// virtualize long thread lists. Insert/remove animations still apply to
  /// rows that are on-screen.
  final bool asSliver;

  const InboxAnimatedThreadList({
    super.key,
    required this.threads,
    required this.itemBuilder,
    this.separatorBuilder,
    this.frameBuilder,
    this.removeSlideTowardEnd = true,
    this.removeDuration = const Duration(milliseconds: 320),
    this.insertDuration = const Duration(milliseconds: 340),
    this.reorderDuration = const Duration(milliseconds: 380),
    this.itemExtent,
    this.asSliver = false,
  });

  @override
  State<InboxAnimatedThreadList> createState() =>
      _InboxAnimatedThreadListState();
}

class _RowEntry {
  _RowEntry({
    required this.thread,
    this.exiting = false,
    this.entering = false,
  });

  InboxThread thread;
  bool exiting;
  bool entering;
}

class _InboxAnimatedThreadListState extends State<InboxAnimatedThreadList> {
  late List<_RowEntry> _rows;

  @override
  void initState() {
    super.initState();
    _rows = [for (final t in widget.threads) _RowEntry(thread: t)];
  }

  @override
  void didUpdateWidget(covariant InboxAnimatedThreadList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _reconcile(widget.threads);
  }

  void _reconcile(List<InboxThread> next) {
    final nextById = <String, InboxThread>{for (final t in next) t.id: t};
    final liveIds = <String>{
      for (final r in _rows)
        if (!r.exiting) r.thread.id,
    };
    final nextIds = nextById.keys.toSet();
    final removedIds = liveIds.difference(nextIds);

    final prevIndex = <String, int>{};
    var si = 0;
    for (final row in _rows) {
      if (row.exiting) continue;
      prevIndex[row.thread.id] = si;
      si++;
    }

    for (final row in _rows) {
      if (row.exiting) continue;
      if (removedIds.contains(row.thread.id)) {
        row.exiting = true;
        row.entering = false;
        continue;
      }
      final updated = nextById[row.thread.id];
      if (updated != null) row.thread = updated;
    }

    final liveById = <String, _RowEntry>{
      for (final r in _rows)
        if (!r.exiting) r.thread.id: r,
    };
    final exitingRows = [for (final r in _rows) if (r.exiting) r];

    final rebuilt = <_RowEntry>[];
    for (final t in next) {
      final existing = liveById.remove(t.id);
      if (existing != null) {
        existing.thread = t;
        existing.entering = false;
        rebuilt.add(existing);
      } else {
        rebuilt.add(_RowEntry(thread: t, entering: true));
      }
    }

    for (final e in exitingRows) {
      final old = prevIndex[e.thread.id] ?? rebuilt.length;
      rebuilt.insert(old.clamp(0, rebuilt.length), e);
    }

    setState(() => _rows = rebuilt);
  }

  void _onExitComplete(String id) {
    if (!mounted) return;
    setState(() {
      _rows = [
        for (final r in _rows)
          if (!(r.exiting && r.thread.id == id)) r,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final extent = widget.itemExtent ?? 76.h;
    final visibleCount = _rows.where((r) => !r.exiting).length;
    final empty = _rows.isEmpty;

    Widget rowAt(int rowIndex) {
      final row = _rows[rowIndex];
      var visibleIndex = 0;
      for (var i = 0; i < rowIndex; i++) {
        if (!_rows[i].exiting) visibleIndex++;
      }
      final tile = (row.entering || row.exiting)
          ? _AnimatedInboxRow(
              index: row.exiting
                  ? visibleIndex.clamp(0, math.max(visibleCount, 0))
                  : visibleIndex,
              itemExtent: extent,
              exiting: row.exiting,
              entering: row.entering,
              removeSlideTowardEnd: widget.removeSlideTowardEnd,
              removeDuration: widget.removeDuration,
              insertDuration: widget.insertDuration,
              reorderDuration: widget.reorderDuration,
              onExitComplete: () => _onExitComplete(row.thread.id),
              onEnterComplete: () {
                row.entering = false;
              },
              child: widget.itemBuilder(
                context,
                row.thread,
                visibleIndex,
                visibleCount == 0 ? 1 : visibleCount,
              ),
            )
          : _ReorderableInboxRow(
              index: visibleIndex,
              itemExtent: extent,
              reorderDuration: widget.reorderDuration,
              child: widget.itemBuilder(
                context,
                row.thread,
                visibleIndex,
                visibleCount == 0 ? 1 : visibleCount,
              ),
            );

      Widget tileBody = RepaintBoundary(child: tile);

      // Separators live inside the row so SliverList childCount stays simple.
      if (widget.asSliver &&
          widget.separatorBuilder != null &&
          !row.exiting &&
          visibleIndex > 0) {
        tileBody = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.separatorBuilder!(context, visibleIndex - 1),
            tileBody,
          ],
        );
      }

      return KeyedSubtree(
        key: ValueKey(row.thread.id),
        child: tileBody,
      );
    }

    if (widget.asSliver) {
      if (empty) {
        final placeholder = widget.frameBuilder != null
            ? widget.frameBuilder!(
                context,
                const SizedBox.shrink(),
                true,
              )
            : const SizedBox.shrink();
        return SliverToBoxAdapter(child: placeholder);
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => rowAt(index),
          childCount: _rows.length,
          addAutomaticKeepAlives: false,
          findChildIndexCallback: (Key key) {
            if (key is! ValueKey<String>) return null;
            final id = key.value;
            for (var i = 0; i < _rows.length; i++) {
              if (_rows[i].thread.id == id) return i;
            }
            return null;
          },
        ),
      );
    }

    final children = <Widget>[];
    var visibleIndex = 0;

    for (var i = 0; i < _rows.length; i++) {
      final row = _rows[i];
      if (!row.exiting &&
          widget.separatorBuilder != null &&
          visibleIndex > 0) {
        children.add(widget.separatorBuilder!(context, visibleIndex - 1));
      }
      children.add(rowAt(i));
      if (!row.exiting) visibleIndex++;
    }

    final list = Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
    if (widget.frameBuilder != null) {
      return widget.frameBuilder!(context, list, empty);
    }
    return empty ? const SizedBox.shrink() : list;
  }
}

class _ReorderableInboxRow extends StatefulWidget {
  final int index;
  final double itemExtent;
  final Duration reorderDuration;
  final Widget child;

  const _ReorderableInboxRow({
    required this.index,
    required this.itemExtent,
    required this.reorderDuration,
    required this.child,
  });

  @override
  State<_ReorderableInboxRow> createState() => _ReorderableInboxRowState();
}

/// Idle row: one controller only when pin-reorder needs it (not 2 forever).
class _ReorderableInboxRowState extends State<_ReorderableInboxRow>
    with SingleTickerProviderStateMixin {
  AnimationController? _reorder;
  double _reorderFrom = 0;

  @override
  void didUpdateWidget(covariant _ReorderableInboxRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index == oldWidget.index) return;
    final delta = (oldWidget.index - widget.index) * widget.itemExtent;
    if (delta.abs() <= 0.5) return;
    _reorder ??= AnimationController(
      vsync: this,
      duration: widget.reorderDuration,
      value: 1,
    )..addListener(() {
        if (mounted) setState(() {});
      });
    _reorderFrom = delta;
    _reorder!.duration = widget.reorderDuration;
    _reorder!.forward(from: 0);
  }

  @override
  void dispose() {
    _reorder?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = _reorder;
    if (ctrl == null || ctrl.isCompleted || ctrl.value >= 1) {
      return widget.child;
    }
    final reorderT = Curves.easeOutCubic.transform(ctrl.value);
    final dy = _reorderFrom * (1 - reorderT);
    return Transform.translate(
      offset: Offset(0, dy),
      child: widget.child,
    );
  }
}

class _AnimatedInboxRow extends StatefulWidget {
  final int index;
  final double itemExtent;
  final bool exiting;
  final bool entering;
  final bool removeSlideTowardEnd;
  final Duration removeDuration;
  final Duration insertDuration;
  final Duration reorderDuration;
  final VoidCallback onExitComplete;
  final VoidCallback onEnterComplete;
  final Widget child;

  const _AnimatedInboxRow({
    required this.index,
    required this.itemExtent,
    required this.exiting,
    required this.entering,
    required this.removeSlideTowardEnd,
    required this.removeDuration,
    required this.insertDuration,
    required this.reorderDuration,
    required this.onExitComplete,
    required this.onEnterComplete,
    required this.child,
  });

  @override
  State<_AnimatedInboxRow> createState() => _AnimatedInboxRowState();
}

class _AnimatedInboxRowState extends State<_AnimatedInboxRow>
    with TickerProviderStateMixin {
  late final AnimationController _life;
  late final AnimationController _reorder;
  late Animation<double> _size;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  double _reorderFrom = 0;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _life = AnimationController(vsync: this, duration: widget.insertDuration);
    _reorder = AnimationController(
      vsync: this,
      duration: widget.reorderDuration,
      value: 1,
    );

    if (widget.exiting) {
      // Mounted already exiting (switched from idle row) — play exit now.
      _isExiting = true;
      _life.duration = widget.removeDuration;
      _setupExit();
      _life.forward(from: 0).whenComplete(widget.onExitComplete);
    } else if (widget.entering) {
      _setupEnter();
      _life.forward(from: 0).whenComplete(widget.onEnterComplete);
    } else {
      _setupShown();
      _life.value = 1;
    }
  }

  void _setupShown() {
    _size = const AlwaysStoppedAnimation(1);
    _fade = const AlwaysStoppedAnimation(1);
    _slide = const AlwaysStoppedAnimation(Offset.zero);
  }

  void _setupEnter() {
    final curved = CurvedAnimation(
      parent: _life,
      curve: Curves.easeOutCubic,
    );
    _size = curved;
    _fade = curved;
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.14),
      end: Offset.zero,
    ).animate(curved);
  }

  void _setupExit() {
    final dx = widget.removeSlideTowardEnd ? 0.28 : -0.28;
    final curved = CurvedAnimation(
      parent: _life,
      curve: Curves.easeInCubic,
    );
    _size = Tween<double>(begin: 1, end: 0).animate(curved);
    _fade = Tween<double>(begin: 1, end: 0).animate(curved);
    _slide = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(dx, 0),
    ).animate(curved);
  }

  @override
  void didUpdateWidget(covariant _AnimatedInboxRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.exiting && !oldWidget.exiting && !_isExiting) {
      _isExiting = true;
      _life.duration = widget.removeDuration;
      _setupExit();
      _life.forward(from: 0).whenComplete(widget.onExitComplete);
    }

    if (widget.entering && !oldWidget.entering && !_isExiting) {
      _life.duration = widget.insertDuration;
      _setupEnter();
      _life.forward(from: 0).whenComplete(widget.onEnterComplete);
    }

    if (!_isExiting && !widget.entering && widget.index != oldWidget.index) {
      final delta = (oldWidget.index - widget.index) * widget.itemExtent;
      if (delta.abs() > 0.5) {
        _reorderFrom = delta;
        _reorder.duration = widget.reorderDuration;
        _reorder.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _life.dispose();
    _reorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_life, _reorder]),
      builder: (context, child) {
        final reorderT = Curves.easeOutCubic.transform(_reorder.value);
        final dy = _reorderFrom * (1 - reorderT);
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _size.value.clamp(0.0, 1.0),
            child: Opacity(
              opacity: _fade.value.clamp(0.0, 1.0),
              child: FractionalTranslation(
                translation: _slide.value,
                child: Transform.translate(
                  offset: Offset(0, dy),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
