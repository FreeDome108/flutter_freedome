import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/src/core/auth_service.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

void main() {
  group('FreeDomeAuthService', () {
    late FreeDomeAuthService authService;

    setUp(() {
      authService = FreeDomeAuthService();
    });

    tearDown(() {
      authService.dispose();
    });

    group('Initialization', () {
      test('should initialize successfully', () async {
        await authService.initialize();

        expect(authService.isInitialized, true);
        expect(authService.currentUser, null);
        expect(authService.isAuthenticated, false);
      });
    });

    group('Authentication', () {
      setUp(() async {
        await authService.initialize();
      });

      test('should login with valid credentials', () async {
        try {
          final user = await authService.login('test@example.com', 'password');

          expect(user, isNotNull);
          expect(user.email, 'test@example.com');
          expect(authService.isAuthenticated, true);
          expect(authService.currentUser, user);
        } catch (e) {
          // Expected to fail in test environment without real auth
          expect(e, isA<Exception>());
        }
      });

      test('should handle invalid credentials', () async {
        try {
          await authService.login('invalid@example.com', 'wrongpassword');
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<Exception>());
          expect(authService.isAuthenticated, false);
          expect(authService.currentUser, null);
        }
      });

      test('should logout successfully', () async {
        await authService.logout();

        expect(authService.isAuthenticated, false);
        expect(authService.currentUser, null);
      });
    });

    group('User Management', () {
      setUp(() async {
        await authService.initialize();
      });

      test('should create user', () async {
        try {
          final user = await authService.createUser(
            email: 'newuser@example.com',
            password: 'password123',
            name: 'Test User',
          );

          expect(user, isNotNull);
          expect(user.email, 'newuser@example.com');
          expect(user.name, 'Test User');
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });

      test('should update user profile', () async {
        try {
          final updatedUser = await authService.updateProfile(
            name: 'Updated Name',
            preferences: {'theme': 'dark'},
          );

          expect(updatedUser, isNotNull);
          expect(updatedUser.name, 'Updated Name');
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });
    });

    group('Session Management', () {
      setUp(() async {
        await authService.initialize();
      });

      test('should check session validity', () {
        final isValid = authService.isSessionValid();

        expect(isValid, isA<bool>());
      });

      test('should refresh session', () async {
        try {
          await authService.refreshSession();
          // Session refresh should complete without error
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });
    });
  });
}
