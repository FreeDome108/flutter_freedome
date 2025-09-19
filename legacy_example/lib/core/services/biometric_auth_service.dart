import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricAuthService {
  static final LocalAuthentication _localAuth = LocalAuthentication();

  static Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  static Future<bool> authenticate({
    String localizedReason = 'Пожалуйста, подтвердите вашу личность',
    String? cancelLabel,
    String? okLabel,
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: localizedReason,
        cancelLabel: cancelLabel,
        okLabel: okLabel,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  static Future<bool> authenticateWithBiometrics() async {
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) return false;

      return await authenticate(
        localizedReason: 'Войдите в аккаунт TaxLien.online',
      );
    } catch (e) {
      return false;
    }
  }
}

class BiometricAuthNotifier extends StateNotifier<BiometricAuthState> {
  BiometricAuthNotifier() : super(const BiometricAuthState()) {
    _initialize();
  }

  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _biometricTypeKey = 'biometric_type';

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_biometricEnabledKey) ?? false;
    final biometricType = prefs.getString(_biometricTypeKey);

    state = state.copyWith(
      isEnabled: isEnabled,
      biometricType: biometricType,
    );

    await _checkAvailability();
  }

  Future<void> _checkAvailability() async {
    final isAvailable = await BiometricAuthService.isBiometricAvailable();
    final availableBiometrics = await BiometricAuthService.getAvailableBiometrics();

    state = state.copyWith(
      isAvailable: isAvailable,
      availableBiometrics: availableBiometrics,
    );
  }

  Future<void> enableBiometricAuth() async {
    if (!state.isAvailable) return;

    final isAuthenticated = await BiometricAuthService.authenticateWithBiometrics();
    if (isAuthenticated) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_biometricEnabledKey, true);
      
      final biometricType = state.availableBiometrics.isNotEmpty 
          ? state.availableBiometrics.first.toString()
          : null;
      await prefs.setString(_biometricTypeKey, biometricType ?? '');

      state = state.copyWith(
        isEnabled: true,
        biometricType: biometricType,
      );
    }
  }

  Future<void> disableBiometricAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, false);
    await prefs.remove(_biometricTypeKey);

    state = state.copyWith(
      isEnabled: false,
      biometricType: null,
    );
  }

  Future<bool> authenticate() async {
    if (!state.isEnabled || !state.isAvailable) return false;
    return await BiometricAuthService.authenticateWithBiometrics();
  }

  String getBiometricTypeName() {
    if (state.biometricType == null) return 'Биометрия';
    
    switch (state.biometricType) {
      case 'BiometricType.fingerprint':
        return 'Отпечаток пальца';
      case 'BiometricType.face':
        return 'Face ID';
      case 'BiometricType.iris':
        return 'Радужная оболочка';
      default:
        return 'Биометрия';
    }
  }
}

class BiometricAuthState {
  final bool isAvailable;
  final bool isEnabled;
  final List<BiometricType> availableBiometrics;
  final String? biometricType;

  const BiometricAuthState({
    this.isAvailable = false,
    this.isEnabled = false,
    this.availableBiometrics = const [],
    this.biometricType,
  });

  BiometricAuthState copyWith({
    bool? isAvailable,
    bool? isEnabled,
    List<BiometricType>? availableBiometrics,
    String? biometricType,
  }) {
    return BiometricAuthState(
      isAvailable: isAvailable ?? this.isAvailable,
      isEnabled: isEnabled ?? this.isEnabled,
      availableBiometrics: availableBiometrics ?? this.availableBiometrics,
      biometricType: biometricType ?? this.biometricType,
    );
  }
}

final biometricAuthProvider = StateNotifierProvider<BiometricAuthNotifier, BiometricAuthState>((ref) {
  return BiometricAuthNotifier();
});
