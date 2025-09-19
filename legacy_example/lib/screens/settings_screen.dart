import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/providers/theme_provider.dart';
import '../core/services/notification_service.dart';
import '../core/services/biometric_auth_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final notificationsEnabled = ref.watch(notificationProvider);
    final biometricState = ref.watch(biometricAuthProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Настройки',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Section
            _buildSectionHeader(context, 'Внешний вид'),
            const SizedBox(height: 12),
            
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildThemeSelector(context, ref, themeMode),
                    const Divider(height: 32),
                    _buildDarkModePreview(context, ref),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Notifications Section
            _buildSectionHeader(context, 'Уведомления'),
            const SizedBox(height: 12),
            
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildNotificationToggle(context, ref, notificationsEnabled),
                    const SizedBox(height: 16),
                    _buildNotificationTypes(context, ref),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Security Section
            _buildSectionHeader(context, 'Безопасность'),
            const SizedBox(height: 12),
            
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildBiometricAuth(context, ref, biometricState),
                    const SizedBox(height: 16),
                    _buildSecurityOptions(context, ref),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // About Section
            _buildSectionHeader(context, 'О приложении'),
            const SizedBox(height: 12),
            
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildAboutInfo(context),
                    const SizedBox(height: 16),
                    _buildAppActions(context, ref),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ).animate().fadeIn().slideX(begin: -0.3);
  }

  Widget _buildThemeSelector(BuildContext context, WidgetRef ref, ThemeMode themeMode) {
    return Row(
      children: [
        Icon(
          Icons.palette_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Тема',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _getThemeModeName(themeMode),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<ThemeMode>(
          initialValue: themeMode,
          onSelected: (ThemeMode mode) {
            ref.read(themeProvider.notifier).setThemeMode(mode);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: ThemeMode.light,
              child: Row(
                children: [
                  Icon(Icons.light_mode),
                  SizedBox(width: 8),
                  Text('Светлая'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: ThemeMode.dark,
              child: Row(
                children: [
                  Icon(Icons.dark_mode),
                  SizedBox(width: 8),
                  Text('Темная'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: ThemeMode.system,
              child: Row(
                children: [
                  Icon(Icons.settings_system_daydream),
                  SizedBox(width: 8),
                  Text('Системная'),
                ],
              ),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDarkModePreview(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Center(
              child: Text(
                'Светлая',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade700),
            ),
            child: const Center(
              child: Text(
                'Темная',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationToggle(BuildContext context, WidgetRef ref, bool enabled) {
    return Row(
      children: [
        Icon(
          Icons.notifications_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Push уведомления',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                enabled ? 'Включены' : 'Отключены',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: enabled,
          onChanged: (value) {
            ref.read(notificationProvider.notifier).toggleNotifications();
          },
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildNotificationTypes(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildNotificationTypeItem(
          context,
          'Новые налоговые залоги',
          'Уведомления о новых предложениях',
          Icons.home_outlined,
          true,
        ),
        const SizedBox(height: 12),
        _buildNotificationTypeItem(
          context,
          'Аукционы',
          'Напоминания о предстоящих аукционах',
          Icons.gavel_outlined,
          true,
        ),
        const SizedBox(height: 12),
        _buildNotificationTypeItem(
          context,
          'Ставки',
          'Уведомления о новых ставках',
          Icons.attach_money_outlined,
          false,
        ),
      ],
    );
  }

  Widget _buildNotificationTypeItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool enabled,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: enabled,
          onChanged: (value) {
            // TODO: Implement individual notification settings
          },
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildBiometricAuth(BuildContext context, WidgetRef ref, BiometricAuthState state) {
    return Row(
      children: [
        Icon(
          state.isEnabled ? Icons.fingerprint : Icons.fingerprint_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Биометрическая аутентификация',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                state.isEnabled 
                    ? state.getBiometricTypeName()
                    : state.isAvailable 
                        ? 'Доступна'
                        : 'Недоступна',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        if (state.isAvailable)
          Switch(
            value: state.isEnabled,
            onChanged: (value) {
              if (value) {
                ref.read(biometricAuthProvider.notifier).enableBiometricAuth();
              } else {
                ref.read(biometricAuthProvider.notifier).disableBiometricAuth();
              }
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
      ],
    );
  }

  Widget _buildSecurityOptions(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildSecurityItem(
          context,
          'Изменить пароль',
          Icons.lock_outline,
          () {
            // TODO: Implement password change
          },
        ),
        const SizedBox(height: 12),
        _buildSecurityItem(
          context,
          'Двухфакторная аутентификация',
          Icons.security_outlined,
          () {
            // TODO: Implement 2FA
          },
        ),
      ],
    );
  }

  Widget _buildSecurityItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutInfo(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.account_balance,
            size: 40,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'TaxLien.online',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Версия 2.0.0',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildAppActions(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildActionItem(
          context,
          'Политика конфиденциальности',
          Icons.privacy_tip_outlined,
          () {
            // TODO: Open privacy policy
          },
        ),
        const SizedBox(height: 12),
        _buildActionItem(
          context,
          'Условия использования',
          Icons.description_outlined,
          () {
            // TODO: Open terms of service
          },
        ),
        const SizedBox(height: 12),
        _buildActionItem(
          context,
          'Обратная связь',
          Icons.feedback_outlined,
          () {
            // TODO: Open feedback form
          },
        ),
        const SizedBox(height: 12),
        _buildActionItem(
          context,
          'Выйти',
          Icons.logout,
          () {
            // TODO: Implement logout
          },
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive 
                  ? Colors.red 
                  : Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red : null,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Светлая';
      case ThemeMode.dark:
        return 'Темная';
      case ThemeMode.system:
        return 'Системная';
    }
  }
}
