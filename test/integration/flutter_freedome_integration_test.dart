import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/flutter_freedome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FlutterFreeDome Integration Tests', () {
    setUp(() {
      // Set up SharedPreferences mock
      SharedPreferences.setMockInitialValues({});
    });

    group('Static API', () {
      test('should provide correct version information', () {
        expect(FlutterFreeDome.version, '1.0.0');
      });

      test('should provide comprehensive library information', () {
        final info = FlutterFreeDome.info;

        expect(info['name'], 'flutter_freedome');
        expect(info['version'], '1.0.0');
        expect(info['description'], contains('FreeDome'));
        expect(info['author'], 'NativeMind Team');
        expect(info['license'], 'NativeMindNONC');
        expect(info['supportedPlatforms'], isA<List>());
        expect(info['supportedPlatforms'], contains('Android'));
        expect(info['supportedPlatforms'], contains('iOS'));
        expect(info['supportedPlatforms'], contains('Web'));
        expect(info['features'], isA<List>());
        expect(info['features'], contains('Автоматическое обнаружение куполов'));
      });

      test('should initialize guest provider successfully', () async {
        final provider = await FlutterFreeDome.initializeGuest();

        expect(provider, isNotNull);
        expect(provider.isInitialized, true);
        expect(provider.currentRole, FreeDomeUserRole.guest);
        expect(provider.isAuthenticated, true);

        provider.dispose();
      });

      test('should fail admin initialization with wrong credentials', () async {
        final provider = await FlutterFreeDome.initializeAdmin(
          username: 'admin',
          password: 'wrongpassword',
        );

        expect(provider, null);
      });

      test('should succeed admin initialization with correct credentials', () async {
        final provider = await FlutterFreeDome.initializeAdmin(
          username: 'admin',
          password: 'admin123',
        );

        expect(provider, isNotNull);
        expect(provider!.isInitialized, true);
        expect(provider.currentRole, FreeDomeUserRole.admin);
        expect(provider.isAuthenticated, true);

        provider.dispose();
      });

      test('should check FreeDome availability', () async {
        // This test simulates checking availability
        // In a real scenario, this would attempt to discover systems
        final isAvailable = await FlutterFreeDome.isFreeDomeAvailable();

        // Since we're in a test environment without real FreeDome systems,
        // this should return false
        expect(isAvailable, false);
      });

      test('should handle quick play with no available systems', () async {
        final success = await FlutterFreeDome.quickPlay(
          appName: 'TestApp',
          contentName: 'Test Content',
          appData: {'type': 'demo'},
        );

        // Should fail since no systems are available in test environment
        expect(success, false);
      });
    });

    group('Provider Lifecycle', () {
      test('should complete full lifecycle: init -> connect -> play -> disconnect', () async {
        final provider = await FlutterFreeDome.initializeGuest();

        // Verify initialization
        expect(provider.isInitialized, true);
        expect(provider.isReady, true);

        // Test connection attempt (will fail in test environment)
        final connected = await provider.connectToNearestDome();
        expect(connected, false); // No real systems available

        // Test content playback (should fail without connection)
        final playSuccess = await provider.playAppContent(
          appName: 'TestApp',
          contentName: 'Test Content',
          appData: {'type': 'test'},
        );
        expect(playSuccess, false); // No connection

        // Test basic controls (should fail without connection)
        final volumeSuccess = await provider.setVolume(0.8);
        final brightnessSuccess = await provider.setBrightness(0.7);
        expect(volumeSuccess, false);
        expect(brightnessSuccess, false);

        // Test disconnect (should succeed even without connection)
        await provider.disconnect();

        // Test reset
        await provider.reset();
        expect(provider.isInitialized, false);

        provider.dispose();
      });

      test('should handle authentication flow correctly', () async {
        final provider = await FlutterFreeDome.initializeGuest();

        // Start as guest
        expect(provider.currentRole, FreeDomeUserRole.guest);
        expect(provider.isGuest, true);

        // Authenticate as admin
        final authSuccess = await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );
        expect(authSuccess, true);
        expect(provider.currentRole, FreeDomeUserRole.admin);
        expect(provider.isGuest, false);

        // Check admin permissions
        expect(provider.hasPermission(FreeDomePermission.calibrateAudio), true);
        expect(provider.hasPermission(FreeDomePermission.systemManagement), true);
        expect(provider.hasRole(FreeDomeUserRole.admin), true);

        // Switch back to guest
        final guestSuccess = await provider.switchToGuestMode();
        expect(guestSuccess, true);
        expect(provider.currentRole, FreeDomeUserRole.guest);
        expect(provider.isGuest, true);

        // Check guest permissions
        expect(provider.hasPermission(FreeDomePermission.playContent), true);
        expect(provider.hasPermission(FreeDomePermission.calibrateAudio), false);

        // Logout
        await provider.logout();
        expect(provider.isAuthenticated, false);

        provider.dispose();
      });

      test('should provide comprehensive system status', () async {
        final provider = await FlutterFreeDome.initializeGuest();

        final status = provider.getSystemStatus();

        expect(status['isInitialized'], true);
        expect(status['isInitializing'], false);
        expect(status['isReady'], true);
        expect(status['error'], null);
        expect(status['connection'], isA<Map>());
        expect(status['auth'], isA<Map>());
        expect(status['content'], isA<Map>());

        provider.dispose();
      });
    });

    group('Content Management Integration', () {
      test('should handle content library operations', () async {
        final provider = await FlutterFreeDome.initializeGuest();

        // Check initial content library (should have demo content)
        final initialContent = provider.content.contentLibrary;
        expect(initialContent, isNotEmpty);
        expect(initialContent.length, 3); // Demo content

        // Verify demo content
        final starryContent = initialContent.firstWhere(
          (c) => c.id == 'demo_starry_sky',
        );
        expect(starryContent.name, 'Звездное небо');
        expect(starryContent.type, ContentType.video);
        expect(starryContent.format, ProjectionFormat.fulldome);

        // Test content search
        final searchResults = provider.content.searchContent(query: 'звезд');
        expect(searchResults, isNotEmpty);
        expect(searchResults.first.name, contains('звезд'));

        // Test search by type
        final videoContent = provider.content.searchContent(type: ContentType.video);
        expect(videoContent.length, 3); // All demo content is video

        // Test search by tags
        final spaceContent = provider.content.searchContent(tags: ['космос']);
        expect(spaceContent.length, 2); // Two items have 'космос' tag

        provider.dispose();
      });

      test('should handle playback state correctly', () async {
        final provider = await FlutterFreeDome.initializeGuest();

        // Check initial playback state
        final initialState = provider.playbackState;
        expect(initialState.status, PlaybackStatus.stopped);
        expect(initialState.currentContentId, null);
        expect(initialState.volume, 0.5);

        // Test playback state extensions
        expect(initialState.isPlaying, false);
        expect(initialState.canStop, false);
        expect(initialState.canPause, false);
        expect(initialState.canResume, false);
        expect(initialState.progressPercent, 0.0);

        provider.dispose();
      });

      test('should handle playlist operations for operators', () async {
        final provider = FreeDomeProvider();
        await provider.initialize();

        // Authenticate as admin (has playlist management permissions)
        await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        // Get content IDs for playlist
        final contentIds = provider.content.contentLibrary
            .take(2)
            .map((c) => c.id)
            .toList();

        // Create playlist
        final playlist = await provider.content.createPlaylist(
          name: 'Test Playlist',
          contentIds: contentIds,
          description: 'Integration test playlist',
        );

        expect(playlist, isNotNull);
        expect(playlist!.name, 'Test Playlist');
        expect(playlist.contentIds.length, 2);
        expect(playlist.description, 'Integration test playlist');

        // Check playlist was added to library
        final playlists = provider.content.playlists;
        expect(playlists, contains(playlist));

        provider.dispose();
      });
    });

    group('Permission System Integration', () {
      test('should enforce permissions correctly across different roles', () async {
        final provider = FreeDomeProvider();
        await provider.initialize();

        // Start with guest session
        await provider.auth.createGuestSession();

        // Guest permissions
        expect(provider.hasPermission(FreeDomePermission.playContent), true);
        expect(provider.hasPermission(FreeDomePermission.controlBasics), true);
        expect(provider.hasPermission(FreeDomePermission.manageContent), false);
        expect(provider.hasPermission(FreeDomePermission.calibrateAudio), false);

        // Authenticate as admin
        await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        // Admin permissions
        expect(provider.hasPermission(FreeDomePermission.playContent), true);
        expect(provider.hasPermission(FreeDomePermission.controlBasics), true);
        expect(provider.hasPermission(FreeDomePermission.manageContent), true);
        expect(provider.hasPermission(FreeDomePermission.calibrateAudio), true);
        expect(provider.hasPermission(FreeDomePermission.calibrateProjectors), true);
        expect(provider.hasPermission(FreeDomePermission.systemManagement), true);
        expect(provider.hasPermission(FreeDomePermission.vendorManagement), false); // Only superadmin

        // Test role hierarchy
        expect(provider.hasRole(FreeDomeUserRole.guest), true);
        expect(provider.hasRole(FreeDomeUserRole.operator), true);
        expect(provider.hasRole(FreeDomeUserRole.admin), true);
        expect(provider.hasRole(FreeDomeUserRole.superadmin), false);

        provider.dispose();
      });

      test('should restrict admin services based on permissions', () async {
        final provider = FreeDomeProvider();
        await provider.initialize();

        // Guest should not have access to admin services
        await provider.auth.createGuestSession();
        expect(provider.calibration, null);
        expect(provider.system, null);

        // Admin should have access to admin services
        await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );
        expect(provider.calibration, isNotNull);
        expect(provider.system, isNotNull);

        provider.dispose();
      });
    });

    group('Error Handling Integration', () {
      test('should handle initialization errors gracefully', () async {
        final provider = FreeDomeProvider();

        // Test multiple initialization attempts
        final result1 = await provider.initialize();
        final result2 = await provider.initialize(); // Should return immediately

        expect(result1, true);
        expect(result2, true);
        expect(provider.isInitialized, true);

        provider.dispose();
      });

      test('should handle authentication errors', () async {
        final provider = FreeDomeProvider();
        await provider.initialize();

        // Test wrong credentials
        final result1 = await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'wrongpassword',
        );
        expect(result1, false);
        expect(provider.currentRole, FreeDomeUserRole.guest);

        // Test non-existent user
        final result2 = await provider.authenticateAsAdmin(
          username: 'nonexistent',
          password: 'password',
        );
        expect(result2, false);

        provider.dispose();
      });

      test('should handle operations when not initialized', () async {
        final provider = FreeDomeProvider();

        // Test operations before initialization
        final connectResult = await provider.connectToNearestDome();
        final playResult = await provider.playAppContent(
          appName: 'Test',
          contentName: 'Test',
          appData: {},
        );
        final authResult = await provider.authenticateAsAdmin(
          username: 'admin',
          password: 'admin123',
        );

        expect(connectResult, false);
        expect(playResult, false);
        expect(authResult, false);

        provider.dispose();
      });
    });

    group('Model Integration', () {
      test('should handle model serialization and deserialization', () {
        // Test DomeSystem
        const originalDome = DomeSystem(
          id: 'integration-dome',
          name: 'Integration Test Dome',
          ipAddress: '192.168.1.200',
          port: 8080,
          type: DomeSystemType.hybrid,
          status: DomeSystemStatus.online,
          isConnected: true,
          systemVolume: 0.8,
          systemBrightness: 0.9,
        );

        final domeJson = originalDome.toJson();
        final reconstructedDome = DomeSystem.fromJson(domeJson);

        expect(reconstructedDome.id, originalDome.id);
        expect(reconstructedDome.name, originalDome.name);
        expect(reconstructedDome.type, originalDome.type);
        expect(reconstructedDome.isConnected, originalDome.isConnected);
        expect(reconstructedDome.systemVolume, originalDome.systemVolume);

        // Test ProjectionContent
        const originalContent = ProjectionContent(
          id: 'integration-content',
          name: 'Integration Test Content',
          filePath: '/test/integration.mp4',
          type: ContentType.interactive,
          duration: Duration(minutes: 15),
          tags: ['integration', 'test'],
          format: ProjectionFormat.spherical,
          playCount: 10,
        );

        final contentJson = originalContent.toJson();
        final reconstructedContent = ProjectionContent.fromJson(contentJson);

        expect(reconstructedContent.id, originalContent.id);
        expect(reconstructedContent.name, originalContent.name);
        expect(reconstructedContent.type, originalContent.type);
        expect(reconstructedContent.tags, originalContent.tags);
        expect(reconstructedContent.format, originalContent.format);
        expect(reconstructedContent.playCount, originalContent.playCount);

        // Test FreeDome data conversion
        final freedomeData = originalContent.toFreeDomeData();
        expect(freedomeData['type'], 'projection_content');
        expect(freedomeData['content']['id'], 'integration-content');
        expect(freedomeData['content']['contentType'], 'interactive');
      });

      test('should handle model extensions correctly', () {
        // Test role extensions
        expect(FreeDomeUserRole.admin.displayName, 'Администратор');
        expect(FreeDomeUserRole.admin.defaultPermissions.length, 6);
        expect(FreeDomeUserRole.admin.hasPermission(FreeDomePermission.calibrateAudio), true);

        // Test system type extensions
        expect(DomeSystemType.professional.displayName, 'Профессиональная');
        expect(DomeSystemType.mobile.description, 'Портативная мобильная система');

        // Test status extensions
        expect(DomeSystemStatus.online.isOperational, true);
        expect(DomeSystemStatus.error.requiresAttention, true);

        // Test content type extensions
        expect(ContentType.video.displayName, 'Видео');
        expect(ContentType.interactive.fileExtensions, 'app, unity, web');

        // Test playback status extensions
        expect(PlaybackStatus.playing.canPause, true);
        expect(PlaybackStatus.paused.canResume, true);

        // Test projection format extensions
        expect(ProjectionFormat.equirectangular.supportsInteraction, true);
        expect(ProjectionFormat.fisheye.supportsInteraction, false);
      });
    });

    group('Memory Management', () {
      test('should properly dispose resources', () async {
        final provider = await FlutterFreeDome.initializeGuest();

        // Use provider
        await provider.connectToNearestDome();
        await provider.playAppContent(
          appName: 'Test',
          contentName: 'Test',
          appData: {},
        );

        // Reset should clean up resources
        await provider.reset();
        expect(provider.isInitialized, false);

        // Dispose should not throw
        expect(() => provider.dispose(), returnsNormally);
      });

      test('should handle multiple provider instances', () async {
        // Create multiple providers (though they should be singletons)
        final provider1 = FreeDomeProvider();
        final provider2 = FreeDomeProvider();

        // They should be the same instance
        expect(identical(provider1, provider2), true);

        await provider1.initialize();
        expect(provider2.isInitialized, true);

        provider1.dispose();
      });
    });
  });
}
