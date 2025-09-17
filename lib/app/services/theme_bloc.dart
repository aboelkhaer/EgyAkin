import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent {}

class InitializeTheme extends ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class SetThemeMode extends ThemeEvent {
  final ThemeMode mode;
  SetThemeMode(this.mode);
}

// States
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeMode themeMode;
  final bool isDarkMode;

  ThemeLoaded({
    required this.themeMode,
    required this.isDarkMode,
  });
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';
  static const String _lightTheme = 'light';
  static const String _darkTheme = 'dark';
  static const String _systemTheme = 'system';

  ThemeBloc() : super(ThemeInitial()) {
    on<InitializeTheme>(_onInitializeTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SetThemeMode>(_onSetThemeMode);
  }

  Future<void> _onInitializeTheme(
      InitializeTheme event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themeKey) ?? _systemTheme;

      ThemeMode themeMode;
      bool isDarkMode;

      switch (savedTheme) {
        case _lightTheme:
          themeMode = ThemeMode.light;
          isDarkMode = false;
          break;
        case _darkTheme:
          themeMode = ThemeMode.dark;
          isDarkMode = true;
          break;
        case _systemTheme:
        default:
          themeMode = ThemeMode.system;
          isDarkMode = _isSystemDarkMode();
          break;
      }

      emit(ThemeLoaded(themeMode: themeMode, isDarkMode: isDarkMode));
    } catch (e) {
      emit(ThemeLoaded(
        themeMode: ThemeMode.system,
        isDarkMode: _isSystemDarkMode(),
      ));
    }
  }

  Future<void> _onToggleTheme(
      ToggleTheme event, Emitter<ThemeState> emit) async {
    if (state is ThemeLoaded) {
      final currentState = state as ThemeLoaded;
      ThemeMode newMode;

      if (currentState.themeMode == ThemeMode.light) {
        newMode = ThemeMode.dark;
      } else {
        newMode = ThemeMode.light;
      }

      add(SetThemeMode(newMode));
    }
  }

  Future<void> _onSetThemeMode(
      SetThemeMode event, Emitter<ThemeState> emit) async {
    ThemeMode themeMode = event.mode;
    bool isDarkMode;

    switch (themeMode) {
      case ThemeMode.light:
        isDarkMode = false;
        break;
      case ThemeMode.dark:
        isDarkMode = true;
        break;
      case ThemeMode.system:
        isDarkMode = _isSystemDarkMode();
        break;
    }

    await _saveThemeToPrefs(themeMode);
    emit(ThemeLoaded(themeMode: themeMode, isDarkMode: isDarkMode));
  }

  bool _isSystemDarkMode() {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }

  Future<void> _saveThemeToPrefs(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String themeString;

      switch (mode) {
        case ThemeMode.light:
          themeString = _lightTheme;
          break;
        case ThemeMode.dark:
          themeString = _darkTheme;
          break;
        case ThemeMode.system:
          themeString = _systemTheme;
          break;
      }

      await prefs.setString(_themeKey, themeString);
    } catch (e) {
      // Handle error silently
    }
  }

  String getCurrentThemeString() {
    if (state is ThemeLoaded) {
      final currentState = state as ThemeLoaded;
      switch (currentState.themeMode) {
        case ThemeMode.light:
          return _lightTheme;
        case ThemeMode.dark:
          return _darkTheme;
        case ThemeMode.system:
          return _systemTheme;
      }
    }
    return _systemTheme;
  }
}
