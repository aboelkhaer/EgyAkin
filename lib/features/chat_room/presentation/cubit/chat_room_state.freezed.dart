// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatRoomState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomStateCopyWith<$Res> {
  factory $ChatRoomStateCopyWith(
          ChatRoomState value, $Res Function(ChatRoomState) then) =
      _$ChatRoomStateCopyWithImpl<$Res, ChatRoomState>;
}

/// @nodoc
class _$ChatRoomStateCopyWithImpl<$Res, $Val extends ChatRoomState>
    implements $ChatRoomStateCopyWith<$Res> {
  _$ChatRoomStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ChatRoomStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ChatRoomState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ChatRoomState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ChatRoomStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ChatRoomState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ChatRoomState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ChatMessageItem> messages,
      int? conversationId,
      bool hasMore,
      bool isSending,
      bool isLoadingMore,
      bool peerIsTyping,
      ChatComposerActivity peerActivity,
      String? peerTypingName,
      bool peerIsOnline,
      ChatMessageItem? replyToMessage,
      ChatMessageItem? editingMessage,
      int rosterVersion});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ChatRoomStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? conversationId = freezed,
    Object? hasMore = null,
    Object? isSending = null,
    Object? isLoadingMore = null,
    Object? peerIsTyping = null,
    Object? peerActivity = null,
    Object? peerTypingName = freezed,
    Object? peerIsOnline = null,
    Object? replyToMessage = freezed,
    Object? editingMessage = freezed,
    Object? rosterVersion = null,
  }) {
    return _then(_$LoadedImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageItem>,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      peerIsTyping: null == peerIsTyping
          ? _value.peerIsTyping
          : peerIsTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      peerActivity: null == peerActivity
          ? _value.peerActivity
          : peerActivity // ignore: cast_nullable_to_non_nullable
              as ChatComposerActivity,
      peerTypingName: freezed == peerTypingName
          ? _value.peerTypingName
          : peerTypingName // ignore: cast_nullable_to_non_nullable
              as String?,
      peerIsOnline: null == peerIsOnline
          ? _value.peerIsOnline
          : peerIsOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      replyToMessage: freezed == replyToMessage
          ? _value.replyToMessage
          : replyToMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessageItem?,
      editingMessage: freezed == editingMessage
          ? _value.editingMessage
          : editingMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessageItem?,
      rosterVersion: null == rosterVersion
          ? _value.rosterVersion
          : rosterVersion // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<ChatMessageItem> messages,
      this.conversationId,
      this.hasMore = false,
      this.isSending = false,
      this.isLoadingMore = false,
      this.peerIsTyping = false,
      this.peerActivity = ChatComposerActivity.none,
      this.peerTypingName,
      this.peerIsOnline = false,
      this.replyToMessage,
      this.editingMessage,
      this.rosterVersion = 0})
      : _messages = messages;

  final List<ChatMessageItem> _messages;
  @override
  List<ChatMessageItem> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final int? conversationId;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool peerIsTyping;
  @override
  @JsonKey()
  final ChatComposerActivity peerActivity;
  @override
  final String? peerTypingName;

  /// Peer is currently in this conversation channel (Ably presence).
  @override
  @JsonKey()
  final bool peerIsOnline;

  /// Message the user is replying to (shown as a banner above input).
  @override
  final ChatMessageItem? replyToMessage;

  /// Message currently being edited (WhatsApp-style banner above input).
  @override
  final ChatMessageItem? editingMessage;

  /// Bumps when group roster changes so the header subtitle rebuilds.
  @override
  @JsonKey()
  final int rosterVersion;

  @override
  String toString() {
    return 'ChatRoomState.loaded(messages: $messages, conversationId: $conversationId, hasMore: $hasMore, isSending: $isSending, isLoadingMore: $isLoadingMore, peerIsTyping: $peerIsTyping, peerActivity: $peerActivity, peerTypingName: $peerTypingName, peerIsOnline: $peerIsOnline, replyToMessage: $replyToMessage, editingMessage: $editingMessage, rosterVersion: $rosterVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.peerIsTyping, peerIsTyping) ||
                other.peerIsTyping == peerIsTyping) &&
            (identical(other.peerActivity, peerActivity) ||
                other.peerActivity == peerActivity) &&
            (identical(other.peerTypingName, peerTypingName) ||
                other.peerTypingName == peerTypingName) &&
            (identical(other.peerIsOnline, peerIsOnline) ||
                other.peerIsOnline == peerIsOnline) &&
            (identical(other.replyToMessage, replyToMessage) ||
                other.replyToMessage == replyToMessage) &&
            (identical(other.editingMessage, editingMessage) ||
                other.editingMessage == editingMessage) &&
            (identical(other.rosterVersion, rosterVersion) ||
                other.rosterVersion == rosterVersion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      conversationId,
      hasMore,
      isSending,
      isLoadingMore,
      peerIsTyping,
      peerActivity,
      peerTypingName,
      peerIsOnline,
      replyToMessage,
      editingMessage,
      rosterVersion);

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
        messages,
        conversationId,
        hasMore,
        isSending,
        isLoadingMore,
        peerIsTyping,
        peerActivity,
        peerTypingName,
        peerIsOnline,
        replyToMessage,
        editingMessage,
        rosterVersion);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
        messages,
        conversationId,
        hasMore,
        isSending,
        isLoadingMore,
        peerIsTyping,
        peerActivity,
        peerTypingName,
        peerIsOnline,
        replyToMessage,
        editingMessage,
        rosterVersion);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          messages,
          conversationId,
          hasMore,
          isSending,
          isLoadingMore,
          peerIsTyping,
          peerActivity,
          peerTypingName,
          peerIsOnline,
          replyToMessage,
          editingMessage,
          rosterVersion);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ChatRoomState {
  const factory _Loaded(
      {required final List<ChatMessageItem> messages,
      final int? conversationId,
      final bool hasMore,
      final bool isSending,
      final bool isLoadingMore,
      final bool peerIsTyping,
      final ChatComposerActivity peerActivity,
      final String? peerTypingName,
      final bool peerIsOnline,
      final ChatMessageItem? replyToMessage,
      final ChatMessageItem? editingMessage,
      final int rosterVersion}) = _$LoadedImpl;

  List<ChatMessageItem> get messages;
  int? get conversationId;
  bool get hasMore;
  bool get isSending;
  bool get isLoadingMore;
  bool get peerIsTyping;
  ChatComposerActivity get peerActivity;
  String? get peerTypingName;

  /// Peer is currently in this conversation channel (Ably presence).
  bool get peerIsOnline;

  /// Message the user is replying to (shown as a banner above input).
  ChatMessageItem? get replyToMessage;

  /// Message currently being edited (WhatsApp-style banner above input).
  ChatMessageItem? get editingMessage;

  /// Bumps when group roster changes so the header subtitle rebuilds.
  int get rosterVersion;

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ChatRoomStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatRoomState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ChatMessageItem> messages,
            int? conversationId,
            bool hasMore,
            bool isSending,
            bool isLoadingMore,
            bool peerIsTyping,
            ChatComposerActivity peerActivity,
            String? peerTypingName,
            bool peerIsOnline,
            ChatMessageItem? replyToMessage,
            ChatMessageItem? editingMessage,
            int rosterVersion)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ChatRoomState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ChatRoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
