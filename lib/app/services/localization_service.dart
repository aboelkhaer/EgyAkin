import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  static const String _languageKey = 'selected_language';
  static const String _defaultLanguage = 'en';
  
  static final LocalizationService _instance = LocalizationService._internal();
  factory LocalizationService() => _instance;
  LocalizationService._internal();

  static LocalizationService get instance => _instance;

  Locale _currentLocale = const Locale('en');
  Map<String, dynamic> _translations = {};
  bool _isInitialized = false;

  Locale get currentLocale => _currentLocale;
  bool get isInitialized => _isInitialized;

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  // Initialize the service
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Load saved language preference
    await _loadSavedLanguage();
    
    // Load translations for current language
    await _loadTranslations(_currentLocale.languageCode);
    
    _isInitialized = true;
  }

  // Load saved language from SharedPreferences
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);
      
      if (savedLanguage != null) {
        _currentLocale = Locale(savedLanguage);
      } else {
        // Use device locale if no saved preference
        final deviceLocale = WidgetsBinding.instance.window.locale;
        if (supportedLocales.contains(deviceLocale)) {
          _currentLocale = deviceLocale;
        } else {
          _currentLocale = const Locale(_defaultLanguage);
        }
      }
    } catch (e) {
      _currentLocale = const Locale(_defaultLanguage);
    }
  }

  // Load translations from JSON file
  Future<void> _loadTranslations(String languageCode) async {
    try {
      final jsonString = await rootBundle.loadString('assets/translations/$languageCode.json');
      _translations = json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      // Fallback to English if translation file not found
      if (languageCode != 'en') {
        await _loadTranslations('en');
      }
    }
  }

  // Change language
  Future<void> changeLanguage(String languageCode) async {
    if (_currentLocale.languageCode == languageCode) return;

    _currentLocale = Locale(languageCode);
    
    // Save language preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    
    // Load new translations
    await _loadTranslations(languageCode);
  }

  // Get translated string
  String translate(String key) {
    if (!_isInitialized) {
      return key; // Return key if not initialized
    }
    
    return _translations[key] ?? key;
  }

  // Get current language code
  String get currentLanguageCode => _currentLocale.languageCode;

  // Check if current language is RTL
  bool get isRTL => _currentLocale.languageCode == 'ar';

  // Get text direction
  TextDirection get textDirection => isRTL ? TextDirection.rtl : TextDirection.ltr;
} 