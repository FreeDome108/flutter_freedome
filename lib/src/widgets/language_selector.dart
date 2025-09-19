import 'package:flutter/material.dart';
import '../utils/localization_manager.dart';

/// Виджет для выбора языка с поддержкой Харконненов и Атрейдесов
class LanguageSelector extends StatefulWidget {
  final String currentLanguage;
  final Function(String) onLanguageChanged;
  final bool showDescriptions;

  const LanguageSelector({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
    this.showDescriptions = true,
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Выберите язык / Select Language',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...LocalizationManager.supportedLocales.map((locale) {
          final languageCode = locale.languageCode;
          final isSelected = languageCode == _selectedLanguage;
          
          return _buildLanguageOption(
            languageCode: languageCode,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                _selectedLanguage = languageCode;
              });
              widget.onLanguageChanged(languageCode);
            },
          );
        }).toList(),
      ],
    );
  }

  Widget _buildLanguageOption({
    required String languageCode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final languageName = LocalizationManager.getLanguageName(languageCode, context);
    final description = LocalizationManager.getLanguageDescription(languageCode);
    final icon = LocalizationManager.getLanguageIcon(languageCode);
    final themeColor = LocalizationManager.getLanguageThemeColor(languageCode);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isSelected ? 4 : 1,
      color: isSelected ? themeColor.withOpacity(0.1) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: themeColor, width: 2)
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: themeColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageName,
                      style: LocalizationManager.getLanguageTextStyle(
                        languageCode,
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ) ?? const TextStyle(),
                      ),
                    ),
                    if (widget.showDescriptions) ...[
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: themeColor,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Диалог для выбора языка
class LanguageSelectorDialog extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageChanged;

  const LanguageSelectorDialog({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.language,
            color: LocalizationManager.getLanguageThemeColor(currentLanguage),
          ),
          const SizedBox(width: 8),
          const Text('Выбор языка'),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: LanguageSelector(
          currentLanguage: currentLanguage,
          onLanguageChanged: (languageCode) {
            onLanguageChanged(languageCode);
            Navigator.of(context).pop();
          },
          showDescriptions: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
