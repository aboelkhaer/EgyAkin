import 'package:egy_akin/injection_container.dart';
import 'package:egy_akin/features/home/presentation/cubit/home_cubit.dart';

/// Updates Profile tab post counters in memory (no extra API calls).
class ProfilePostCounts {
  static HomeCubit? _home() {
    if (!sl.isRegistered<HomeCubit>()) return null;
    final cubit = resolveHomeCubit();
    return cubit.isClosed ? null : cubit;
  }

  static void onSaveOrUnsave(String saveOrUnsave) {
    _home()?.adjustSavedPostsCount(saveOrUnsave == 'save' ? 1 : -1);
  }

  static void revertSaveOrUnsave(String saveOrUnsave) {
    onSaveOrUnsave(saveOrUnsave == 'save' ? 'unsave' : 'save');
  }

  static void onOwnPostCreated() {
    _home()?.adjustOwnPostsCount(1);
  }

  static void onOwnPostDeleted({bool wasSaved = false}) {
    _home()?.adjustOwnPostsCount(-1);
    if (wasSaved) {
      _home()?.adjustSavedPostsCount(-1);
    }
  }
}
