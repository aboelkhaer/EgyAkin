import '../../../exports.dart';

extension CubitExtensions on Cubit {
  void safeClose() {
    if (!isClosed) {
      close();
    }
  }
}
