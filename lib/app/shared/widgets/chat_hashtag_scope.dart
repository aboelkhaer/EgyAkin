import 'package:egy_akin/exports.dart';

/// Provides doctor/home context so chat message hashtags can open community search.
class ChatHashtagScope extends InheritedWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const ChatHashtagScope({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required super.child,
  });

  static ChatHashtagScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChatHashtagScope>();
  }

  @override
  bool updateShouldNotify(ChatHashtagScope oldWidget) {
    return currentDoctorModel != oldWidget.currentDoctorModel ||
        homeDataModel != oldWidget.homeDataModel;
  }
}
