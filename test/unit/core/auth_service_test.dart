import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_freedome/src/core/auth_service.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  group('FreeDomeAuthService', () {
    late FreeDomeAuthService authService;
    late MockFlutterSecureStorage mockSecureStorage;

    setUp(() {
      authService = FreeDomeAuthService();
      mockSecureStorage = MockFlutterSecureStorage();
      
      // Set up SharedPreferences mock
      SharedPreferences.setMockInitialValues({});
    });

    tearDown(() {
      authService.dispose();
    });

    group('Initialization', () {
      test('should initialize successfully with no stored session', () async {
        when(mockSecureStorage.read(key: anyNamed('key'))).thenAnswer((_) async => null);

        await authService.initialize();

        expect(authService.isAuthenticated, false);
        expect(authService.isGuest, false);
        expect(authService.currentUser, null);
        expect(authService.currentSession, null);
        expect(authService.currentRole, FreeDomeUserRole.guest);
      });

      test('should load stored guest session on initialization', () async {
        final prefs = await SharedPreferences.getInstance();
        const sessionData = {
          'id': 'guest_12345',
          'userId': 'guest',
          'domeId': 'default',
          'startTime': '2023-01-01T10:00:00.000Z',
          'duration': 0,
        };
        await prefs.setString('freedome_guest_session', 
            '{"id":"guest_12345","userId":"guest","domeId":"default","startTime":"2023-01-01T10:00:00.000Z","duration":0}');

        await authService.initialize();

        expect(authService.isAuthenticated, true);
        expect(authService.isGuest, true);
        expect(authService.currentUser?.name, 'Гость');
        expect(authService.currentUser?.role, FreeDomeUserRole.guest);
        expect(authService.currentSession?.id, 'guest_12345');
      });

      test('should load stored authenticated session on initialization', () async {
        const userData = '{"id":"admin_123","name":"Admin User","role":"admin","permissions":["playContent","controlBasics","manageContent","calibrateAudio","calibrateProjectors","systemManagement"]}';
        const sessionData = '{"id":"session_123","userId":"admin_123","domeId":"dome_1","startTime":"2023-01-01T10:00:00.000Z","duration":0}';

        when(mockSecureStorage.read(key: 'freedome_user')).thenAnswer((_) async => userData);
        when(mockSecureStorage.read(key: 'freedome_session')).thenAnswer((_) async => sessionData);

        await authService.initialize();

        expect(authService.isAuthenticated, true);
        expect(authService.isGuest, false);
        expect(authService.currentUser?.name, 'Admin User');
        expect(authService.currentUser?.role, FreeDomeUserRole.admin);
        expect(authService.currentSession?.id, 'session_123');
      });

      test('should handle initialization errors gracefully', () async {
        when(mockSecureStorage.read(key: anyNamed('key'))).thenThrow(Exception('Storage error'));

        await authService.initialize();

        expect(authService.isAuthenticated, false);
        expect(authService.currentUser, null);
      });
    });

    group('Guest Session Management', () {
      test('should create guest session successfully', () async {
        final result = await authService.createGuestSession();

        expect(result, true);
        expect(authService.isAuthenticated, true);
        expect(authService.isGuest, true);
        expect(authService.currentUser?.name, 'Гость');
        expect(authService.currentUser?.role, FreeDomeUserRole.guest);
        expect(authService.currentSession?.userId, 'guest');
        expect(authService.currentSession?.domeId, 'default');
      });

      test('should create guest session with custom dome ID', () async {
        final result = await authService.createGuestSession(domeId: 'custom-dome');

        expect(result, true);
        expect(authService.currentSession?.domeId, 'custom-dome');
      });

      test('should handle guest session creation errors', () async {
        // Simulate SharedPreferences error by not setting up mock values
        SharedPreferences.setMockInitialValues(null);

        final result = await authService.createGuestSession();

        // Should still succeed but might not persist
        expect(result, true);
        expect(authService.isGuest, true);
      });
    });

    group('Admin Authentication', () {
      test('should authenticate admin with valid credentials', () async {
        final result = await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        expect(result, true);
        expect(authService.isAuthenticated, true);
        expect(authService.isGuest, false);
        expect(authService.currentUser?.name, 'admin');
        expect(authService.currentUser?.role, FreeDomeUserRole.admin);
        expect(authService.currentUser?.permissions, 
            FreeDomeUserRole.admin.defaultPermissions);
      });

      test('should fail authentication with invalid credentials', () async {
        final result = await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'wrongpassword',
        );

        expect(result, false);
        expect(authService.isAuthenticated, false);
        expect(authService.currentUser, null);
      });

      test('should authenticate with different valid users', () async {
        final result1 = await authService.authenticateAsAdmin(
          username: 'operator',
          password: 'operator123',
        );

        expect(result1, true);
        expect(authService.currentUser?.name, 'operator');

        // Logout and test another user
        await authService.logout();

        final result2 = await authService.authenticateAsAdmin(
          username: 'technician',
          password: 'tech123',
        );

        expect(result2, true);
        expect(authService.currentUser?.name, 'technician');
      });

      test('should include dome ID in session when provided', () async {
        final result = await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
          domeId: 'specific-dome',
        );

        expect(result, true);
        expect(authService.currentSession?.domeId, 'specific-dome');
      });

      test('should handle authentication errors gracefully', () async {
        when(mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenThrow(Exception('Storage error'));

        final result = await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        expect(result, false);
      });
    });

    group('Session Management', () {
      test('should logout successfully from authenticated session', () async {
        // First authenticate
        await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );
        expect(authService.isAuthenticated, true);

        // Then logout
        await authService.logout();

        expect(authService.isAuthenticated, false);
        expect(authService.isGuest, false);
        expect(authService.currentUser, null);
        expect(authService.currentSession, null);
      });

      test('should logout successfully from guest session', () async {
        // First create guest session
        await authService.createGuestSession();
        expect(authService.isGuest, true);

        // Then logout
        await authService.logout();

        expect(authService.isAuthenticated, false);
        expect(authService.isGuest, false);
        expect(authService.currentUser, null);
        expect(authService.currentSession, null);
      });

      test('should switch to guest mode from authenticated session', () async {
        // First authenticate as admin
        await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );
        expect(authService.currentRole, FreeDomeUserRole.admin);

        // Then switch to guest mode
        final result = await authService.switchToGuestMode();

        expect(result, true);
        expect(authService.isAuthenticated, true);
        expect(authService.isGuest, true);
        expect(authService.currentRole, FreeDomeUserRole.guest);
      });

      test('should return true when already in guest mode', () async {
        // Create guest session first
        await authService.createGuestSession();
        expect(authService.isGuest, true);

        // Switch to guest mode should return true
        final result = await authService.switchToGuestMode();
        expect(result, true);
        expect(authService.isGuest, true);
      });

      test('should extend session successfully', () async {
        await authService.createGuestSession();
        
        final result = await authService.extendSession();
        
        expect(result, true);
      });

      test('should fail to extend session when no session exists', () async {
        final result = await authService.extendSession();
        
        expect(result, false);
      });
    });

    group('Permission Management', () {
      test('should check permissions correctly for guest user', () async {
        await authService.createGuestSession();

        expect(authService.hasPermission(FreeDomePermission.playContent), true);
        expect(authService.hasPermission(FreeDomePermission.controlBasics), true);
        expect(authService.hasPermission(FreeDomePermission.manageContent), false);
        expect(authService.hasPermission(FreeDomePermission.calibrateAudio), false);
        expect(authService.hasPermission(FreeDomePermission.systemManagement), false);
      });

      test('should check permissions correctly for admin user', () async {
        await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        expect(authService.hasPermission(FreeDomePermission.playContent), true);
        expect(authService.hasPermission(FreeDomePermission.controlBasics), true);
        expect(authService.hasPermission(FreeDomePermission.manageContent), true);
        expect(authService.hasPermission(FreeDomePermission.calibrateAudio), true);
        expect(authService.hasPermission(FreeDomePermission.calibrateProjectors), true);
        expect(authService.hasPermission(FreeDomePermission.systemManagement), true);
        expect(authService.hasPermission(FreeDomePermission.vendorManagement), false); // Only superadmin
      });

      test('should return false for permissions when not authenticated', () {
        expect(authService.hasPermission(FreeDomePermission.playContent), false);
        expect(authService.hasPermission(FreeDomePermission.controlBasics), false);
      });

      test('should get available permissions correctly', () async {
        await authService.createGuestSession();
        
        final guestPermissions = authService.getAvailablePermissions();
        expect(guestPermissions, FreeDomeUserRole.guest.defaultPermissions);

        await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        final adminPermissions = authService.getAvailablePermissions();
        expect(adminPermissions, FreeDomeUserRole.admin.defaultPermissions);
      });

      test('should return empty permissions when not authenticated', () {
        final permissions = authService.getAvailablePermissions();
        expect(permissions, isEmpty);
      });
    });

    group('Role Management', () {
      test('should check roles correctly for guest user', () async {
        await authService.createGuestSession();

        expect(authService.hasRole(FreeDomeUserRole.guest), true);
        expect(authService.hasRole(FreeDomeUserRole.operator), false);
        expect(authService.hasRole(FreeDomeUserRole.admin), false);
        expect(authService.hasRole(FreeDomeUserRole.superadmin), false);
      });

      test('should check roles correctly for admin user', () async {
        await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        expect(authService.hasRole(FreeDomeUserRole.guest), true);
        expect(authService.hasRole(FreeDomeUserRole.operator), true);
        expect(authService.hasRole(FreeDomeUserRole.admin), true);
        expect(authService.hasRole(FreeDomeUserRole.superadmin), false);
      });

      test('should return false for role checks when not authenticated', () {
        expect(authService.hasRole(FreeDomeUserRole.guest), false);
        expect(authService.hasRole(FreeDomeUserRole.admin), false);
      });
    });

    group('Session Information', () {
      test('should provide comprehensive session info for guest', () async {
        await authService.createGuestSession();

        final sessionInfo = authService.getSessionInfo();

        expect(sessionInfo['isAuthenticated'], true);
        expect(sessionInfo['isGuest'], true);
        expect(sessionInfo['role'], 'guest');
        expect(sessionInfo['user'], isNotNull);
        expect(sessionInfo['session'], isNotNull);
        expect(sessionInfo['permissions'], isA<List>());
        expect(sessionInfo['permissions'], contains('playContent'));
        expect(sessionInfo['permissions'], contains('controlBasics'));
      });

      test('should provide comprehensive session info for admin', () async {
        await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        final sessionInfo = authService.getSessionInfo();

        expect(sessionInfo['isAuthenticated'], true);
        expect(sessionInfo['isGuest'], false);
        expect(sessionInfo['role'], 'admin');
        expect(sessionInfo['user'], isNotNull);
        expect(sessionInfo['session'], isNotNull);
        expect(sessionInfo['permissions'], isA<List>());
        expect(sessionInfo['permissions'], contains('calibrateAudio'));
        expect(sessionInfo['permissions'], contains('systemManagement'));
      });

      test('should provide empty session info when not authenticated', () {
        final sessionInfo = authService.getSessionInfo();

        expect(sessionInfo['isAuthenticated'], false);
        expect(sessionInfo['isGuest'], false);
        expect(sessionInfo['role'], 'guest');
        expect(sessionInfo['user'], null);
        expect(sessionInfo['session'], null);
        expect(sessionInfo['permissions'], isEmpty);
      });
    });

    group('Password Hashing', () {
      test('should hash passwords consistently', () async {
        // This tests the internal password hashing by trying to authenticate
        // with the same password multiple times
        final result1 = await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );
        await authService.logout();

        final result2 = await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        expect(result1, true);
        expect(result2, true);
      });

      test('should reject wrong passwords consistently', () async {
        final result1 = await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'wrongpassword',
        );

        final result2 = await authService.authenticateAsAdmin(
          username: 'admin',
          password: 'differentwrong',
        );

        expect(result1, false);
        expect(result2, false);
      });
    });

    group('Error Handling', () {
      test('should handle logout errors gracefully', () async {
        await authService.createGuestSession();
        
        // Simulate storage error during logout
        SharedPreferences.setMockInitialValues(null);

        // Should not throw exception
        await authService.logout();

        expect(authService.isAuthenticated, false);
      });

      test('should handle session extension errors gracefully', () async {
        await authService.createGuestSession();
        
        // Simulate storage error
        SharedPreferences.setMockInitialValues(null);

        final result = await authService.extendSession();
        expect(result, false);
      });
    });
  });
}
