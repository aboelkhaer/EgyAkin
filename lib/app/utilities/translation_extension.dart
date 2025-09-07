import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/localization_bloc.dart';

extension TranslationExtension on BuildContext {
  String tr(String key) {
    return this.read<LocalizationBloc>().translate(key);
  }
  
  bool get isRTL {
    final state = this.read<LocalizationBloc>().state;
    if (state is LocalizationLoaded) {
      return state.isRTL;
    }
    return false;
  }
  
  Locale? get currentLocale {
    final state = this.read<LocalizationBloc>().state;
    if (state is LocalizationLoaded) {
      return state.locale;
    }
    return null;
  }
} 