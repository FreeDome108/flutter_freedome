import 'package:json_annotation/json_annotation.dart';

part 'localization_models.g.dart';

/// Информация о локали
@JsonSerializable()
class LocaleInfo {
  final String languageCode;
  final String countryCode;
  final String nativeName;
  final String englishName;

  const LocaleInfo(
    this.languageCode,
    this.countryCode,
    this.nativeName,
    this.englishName,
  );

  factory LocaleInfo.fromJson(Map<String, dynamic> json) =>
      _$LocaleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LocaleInfoToJson(this);

  @override
  String toString() => '$languageCode-$countryCode';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleInfo &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode &&
          countryCode == other.countryCode;

  @override
  int get hashCode => languageCode.hashCode ^ countryCode.hashCode;
}

/// Настройки локализации
@JsonSerializable()
class LocalizationSettings {
  final String selectedLanguage;
  final String? selectedCountry;
  final bool autoDetectLocale;
  final List<String> preferredLanguages;
  final Map<String, String> customTranslations;

  const LocalizationSettings({
    required this.selectedLanguage,
    this.selectedCountry,
    this.autoDetectLocale = true,
    this.preferredLanguages = const [],
    this.customTranslations = const {},
  });

  factory LocalizationSettings.fromJson(Map<String, dynamic> json) =>
      _$LocalizationSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizationSettingsToJson(this);

  LocalizationSettings copyWith({
    String? selectedLanguage,
    String? selectedCountry,
    bool? autoDetectLocale,
    List<String>? preferredLanguages,
    Map<String, String>? customTranslations,
  }) {
    return LocalizationSettings(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      autoDetectLocale: autoDetectLocale ?? this.autoDetectLocale,
      preferredLanguages: preferredLanguages ?? this.preferredLanguages,
      customTranslations: customTranslations ?? this.customTranslations,
    );
  }
}

/// Контекст локализации для передачи дополнительной информации
class LocalizationContext {
  final String? domain;
  final Map<String, dynamic> metadata;
  final DateTime? timestamp;

  const LocalizationContext({
    this.domain,
    this.metadata = const {},
    this.timestamp,
  });
}

/// Результат перевода
class TranslationResult {
  final String translation;
  final String originalKey;
  final bool wasFound;
  final String? fallbackUsed;
  final LocalizationContext? context;

  const TranslationResult({
    required this.translation,
    required this.originalKey,
    required this.wasFound,
    this.fallbackUsed,
    this.context,
  });
}
