import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_member_search_state.dart';

import '../../../../exports.dart';

class InboxMemberSearchCubit extends Cubit<InboxMemberSearchState> {
  InboxMemberSearchCubit(this._repository)
      : super(const InboxMemberSearchState.initial());

  final ChatRoomRepository _repository;
  Timer? _debounce;

  static InboxMemberSearchCubit get(context) =>
      BlocProvider.of<InboxMemberSearchCubit>(context);

  void onQueryChanged(String query) {
    final trimmed = query.trim();
    _debounce?.cancel();

    if (trimmed.length < 2) {
      emit(trimmed.isEmpty
          ? const InboxMemberSearchState.initial()
          : const InboxMemberSearchState.hint());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search(trimmed);
    });
  }

  Future<void> _search(String query) async {
    emit(const InboxMemberSearchState.loading());

    final result = await _repository.searchUsers(query);

    result.fold(
      (failure) => emit(InboxMemberSearchState.error(failure.message)),
      (response) {
        final users = response.data ?? const [];
        if (users.isEmpty) {
          emit(const InboxMemberSearchState.empty());
        } else {
          emit(InboxMemberSearchState.loaded(users: users));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
