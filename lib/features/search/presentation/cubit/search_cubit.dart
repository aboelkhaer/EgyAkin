import 'package:egy_akin/features/search/domain/usecases/get_search_home_usecase.dart';
import 'package:egy_akin/features/search/presentation/cubit/search_state.dart';

import '../../../../exports.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._getSearchHomeUsecase) : super(const SearchState.initial());
  final GetSearchHomeUsecase _getSearchHomeUsecase;
  static SearchCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();

  getSearchHome() async {
    if (searchController.text.trim().isNotEmpty) {
      emit(const SearchState.loading());

      final result = await _getSearchHomeUsecase.excute(searchController.text);
      result.fold(
        (l) => emit(SearchState.error(l.message)),
        (r) {
          emit(SearchState.loaded(r.data));
        },
      );
    }
  }
}
