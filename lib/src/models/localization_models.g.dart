// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocaleInfo _$LocaleInfoFromJson(Map<String, dynamic> json) => LocaleInfo(
      json['languageCode'] as String,
      json['countryCode'] as String,
      json['nativeName'] as String,
      json['englishName'] as String,
    );

Map<String, dynamic> _$LocaleInfoToJson(LocaleInfo instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'countryCode': instance.countryCode,
      'nativeName': instance.nativeName,
      'englishName': instance.englishName,
    };

LocalizationSettings _$LocalizationSettingsFromJson(
        Map<String, dynamic> json) =>
    LocalizationSettings(
      selectedLanguage: json['selectedLanguage'] as String,
      selectedCountry: json['selectedCountry'] as String?,
      autoDetectLocale: json['autoDetectLocale'] as bool? ?? true,
      preferredLanguages: (json['preferredLanguages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      customTranslations:
          (json['customTranslations'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const {},
    );

Map<String, dynamic> _$LocalizationSettingsToJson(
    LocalizationSettings instance) {
  final val = <String, dynamic>{
    'selectedLanguage': instance.selectedLanguage,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('selectedCountry', instance.selectedCountry);
  val['autoDetectLocale'] = instance.autoDetectLocale;
  val['preferredLanguages'] = instance.preferredLanguages;
  val['customTranslations'] = instance.customTranslations;
  return val;
}
