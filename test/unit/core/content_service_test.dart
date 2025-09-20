import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_freedome/src/core/content_service.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';
import 'package:flutter_freedome/src/core/auth_service.dart';
import 'package:flutter_freedome/src/models/content_models.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';
import 'package:flutter_freedome/src/models/calibration_models.dart';

// Mocktail моки без кодогенерации
class MockFreeDomeConnectionService extends Mock implements FreeDomeConnectionService {}
class MockFreeDomeAuthService extends Mock implements FreeDomeAuthService {}

void main() {
  group('FreeDomeContentService', () {
    late FreeDomeContentService contentService;
    late MockFreeDomeConnectionService mockConnectionService;
    late MockFreeDomeAuthService mockAuthService;

    setUp(() async {
      // Set up SharedPreferences mock
      SharedPreferences.setMockInitialValues({});
      
      contentService = FreeDomeContentService();
      mockConnectionService = MockFreeDomeConnectionService();
      mockAuthService = MockFreeDomeAuthService();
      
      // Initialize service
      await contentService.initialize();
    });

    tearDown(() {
      contentService.dispose();
    });

    group('Initialization', () {
      test('should initialize with demo content', () {
        expect(contentService.contentLibrary.length, 3);
        expect(contentService.playlists.length, 0);
        
        final starryContent = contentService.contentLibrary
            .firstWhere((c) => c.id == 'demo_starry_sky');
        expect(starryContent.name, 'Звездное небо');
        expect(starryContent.type, ContentType.video);
        expect(starryContent.format, ProjectionFormat.fulldome);
      });
    });

    group('Content Search', () {
      test('should search content by query', () {
        final results = contentService.searchContent(query: 'звезд');
        
        expect(results.length, 1);
        expect(results.first.name, 'Звездное небо');
      });

      test('should search content by type', () {
        final results = contentService.searchContent(type: ContentType.video);
        
        expect(results.length, 3); // All demo content is video
      });

      test('should search content by tags', () {
        final results = contentService.searchContent(tags: ['космос']);
        
        expect(results.length, 2); // Two items have 'космос' tag
      });

      test('should be case insensitive', () {
        final results = contentService.searchContent(query: 'ЗВЕЗД');
        
        expect(results.length, 1);
        expect(results.first.name, 'Звездное небо');
      });

      test('should search with multiple criteria', () {
        final results = contentService.searchContent(
          query: 'солнечная',
          type: ContentType.video,
          tags: ['планеты'],
        );
        
        expect(results.length, 1);
        expect(results.first.name, 'Солнечная система');
      });

      test('should return empty list for no matches', () {
        final results = contentService.searchContent(query: 'nonexistent');
        
        expect(results.isEmpty, true);
      });
    });

    group('Content Management', () {
      test('should get content by ID', () {
        final content = contentService.getContent('demo_starry_sky');
        
        expect(content, isNotNull);
        expect(content!.name, 'Звездное небо');
      });

      test('should return null for non-existent content', () {
        final content = contentService.getContent('nonexistent');
        
        expect(content, null);
      });
    });

    group('Usage Statistics', () {
      test('should provide usage statistics', () {
        final stats = contentService.getUsageStats();

        expect(stats['totalContent'], 3);
        expect(stats['totalPlaylists'], 0);
        expect(stats['totalPlayCount'], 0);
        expect(stats['mostPlayedContent'], null);
        expect(stats['currentPlayback'], isA<Map>());
      });
    });
  });
}
