import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:egy_akin/features/inbox/data/models/get_inbox_model_response.dart';
import 'package:egy_akin/features/inbox/data/models/inbox_thread.dart';

part 'inbox_state.freezed.dart';

@freezed
class InboxState with _$InboxState {
  const factory InboxState.initial() = _Initial;
  const factory InboxState.loading() = _Loading;
  const factory InboxState.loaded({
    required List<InboxThread> threads,
    required InboxCountsModel? counts,
    required InboxFilter filter,
    required bool isLastPage,
    required int currentPage,
    /// Total conversations from API `meta.total` (all pages).
    int? totalCount,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
  }) = _Loaded;
  const factory InboxState.error(String message) = _Error;
}
