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
class MockFreeDomeConnectionService extends Mock
    implements FreeDomeConnectionService {}

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
      // Don't dispose here to avoid issues with subsequent tests
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
      test('should search content by query', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final results = service.searchContent(query: 'звезд');

        expect(results.length, 1);
        expect(results.first.name, 'Звездное небо');
        service.dispose();
      });

      test('should search content by type', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final results = service.searchContent(type: ContentType.video);

        expect(results.length, 3); // All demo content is video
        service.dispose();
      });

      test('should search content by tags', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final results = service.searchContent(tags: ['космос']);

        expect(results.length, 2); // Two items have 'космос' tag
        service.dispose();
      });

      test('should be case insensitive', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final results = service.searchContent(query: 'ЗВЕЗД');

        expect(results.length, 1);
        expect(results.first.name, 'Звездное небо');
        service.dispose();
      });

      test('should search with multiple criteria', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final results = service.searchContent(
          query: 'солнечная',
          type: ContentType.video,
          tags: ['планеты'],
        );

        expect(results.length, 1);
        expect(results.first.name, 'Солнечная система');
        service.dispose();
      });

      test('should return empty list for no matches', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final results = service.searchContent(query: 'nonexistent');

        expect(results.isEmpty, true);
        service.dispose();
      });
    });

    group('Content Management', () {
      test('should get content by ID', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final content = service.getContent('demo_starry_sky');

        expect(content, isNotNull);
        expect(content!.name, 'Звездное небо');
        service.dispose();
      });

      test('should return null for non-existent content', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final content = service.getContent('nonexistent');

        expect(content, null);
        service.dispose();
      });
    });

    group('Usage Statistics', () {
      test('should provide usage statistics', () async {
        final service = FreeDomeContentService();
        await service.initialize();
        final stats = service.getUsageStats();

        expect(stats['totalContent'], 3);
        expect(stats['totalPlaylists'], 0);
        expect(stats['totalPlayCount'], 0);
        expect(stats['mostPlayedContent'], null);
        expect(stats['currentPlayback'], isA<Map>());
        service.dispose();
      });
    });
  });
}
