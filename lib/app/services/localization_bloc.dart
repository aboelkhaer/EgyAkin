import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localization_service.dart';

// Events
abstract class LocalizationEvent {}

class InitializeLocalization extends LocalizationEvent {}

class ChangeLanguage extends LocalizationEvent {
  final String languageCode;
  ChangeLanguage(this.languageCode);
}

// States
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class LocalizationLoading extends LocalizationState {}

class LocalizationLoaded extends LocalizationState {
  final Locale locale;
  final bool isRTL;
  
  LocalizationLoaded({required this.locale, required this.isRTL});
}

class LocalizationError extends LocalizationState {
  final String message;
  LocalizationError(this.message);
}

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final LocalizationService _localizationService = LocalizationService.instance;

  LocalizationBloc() : super(LocalizationInitial()) {
    on<InitializeLocalization>(_onInitialize);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onInitialize(InitializeLocalization event, Emitter<LocalizationState> emit) async {
    emit(LocalizationLoading());
    
    try {
      await _localizationService.initialize();
      emit(LocalizationLoaded(
        locale: _localizationService.currentLocale,
        isRTL: _localizationService.isRTL,
      ));
    } catch (e) {
      emit(LocalizationError(e.toString()));
    }
  }

  Future<void> _onChangeLanguage(ChangeLanguage event, Emitter<LocalizationState> emit) async {
    emit(LocalizationLoading());
    
    try {
      await _localizationService.changeLanguage(event.languageCode);
      emit(LocalizationLoaded(
        locale: _localizationService.currentLocale,
        isRTL: _localizationService.isRTL,
      ));
    } catch (e) {
      emit(LocalizationError(e.toString()));
    }
  }

  String translate(String key) {
    return _localizationService.translate(key);
  }
} 