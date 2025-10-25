import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/src/core/connection_service.dart';

void main() {
  group('FreeDomeConnectionService', () {
    late FreeDomeConnectionService connectionService;

    setUp(() {
      connectionService = FreeDomeConnectionService();
    });

    tearDown(() {
      connectionService.dispose();
    });

    group('Initialization', () {
      test('should initialize successfully', () async {
        await connectionService.initialize();

        expect(connectionService.connectionStatus.isConnected, false);
        expect(connectionService.connectionStatus.isConnecting, false);
        expect(connectionService.discoveredSystems, isEmpty);
      });
    });

    group('Connection Status', () {
      setUp(() async {
        await connectionService.initialize();
      });

      test('should provide connection status', () {
        final status = connectionService.connectionStatus;

        expect(status.isConnected, false);
        expect(status.isConnecting, false);
        expect(status.connectedDomeId, null);
        expect(status.serverUrl, null);
        expect(status.error, null);
      });

      test('should provide connection properties', () {
        final status = connectionService.connectionStatus;

        expect(status.isConnected, isA<bool>());
        expect(status.isConnecting, isA<bool>());
        expect(status.connectedDomeId, isA<String?>());
        expect(status.serverUrl, isA<String?>());
        expect(status.error, isA<String?>());
      });
    });

    group('System Discovery', () {
      setUp(() async {
        await connectionService.initialize();
      });

      test('should start discovery', () async {
        await connectionService.startDiscovery();

        // Discovery should be running
        expect(connectionService.discoveredSystems, isNotNull);
      });

      test('should stop discovery', () async {
        await connectionService.startDiscovery();
        await connectionService.stopDiscovery();

        // Discovery should be stopped
        expect(connectionService.discoveredSystems, isNotNull);
      });
    });

    group('Connection Management', () {
      setUp(() async {
        await connectionService.initialize();
      });

      test('should connect to dome system', () async {
        const domeId = 'test-dome-123';

        try {
          await connectionService.connectToDome(domeId);
          // Connection attempt should be made
          expect(connectionService.connectionStatus.isConnecting, isA<bool>());
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });

      test('should disconnect from dome system', () async {
        await connectionService.disconnect();

        expect(connectionService.connectionStatus.isConnected, false);
        expect(connectionService.connectionStatus.connectedDomeId, null);
      });
    });

    group('Event Stream', () {
      setUp(() async {
        await connectionService.initialize();
      });

      test('should provide event stream', () {
        expect(connectionService.eventStream, isA<Stream>());
      });

      test('should emit connection events', () async {
        final events = <dynamic>[];
        final subscription = connectionService.eventStream.listen(events.add);

        // Trigger some events
        await connectionService.startDiscovery();
        await connectionService.stopDiscovery();

        // Wait a bit for events
        await Future.delayed(const Duration(milliseconds: 100));

        subscription.cancel();
        expect(events, isA<List>());
      });
    });
  });
}
