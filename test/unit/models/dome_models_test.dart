import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_freedome/src/models/dome_models.dart';

void main() {
  group('DomeSystem', () {
    test('should create DomeSystem with required fields', () {
      const dome = DomeSystem(
        id: 'test-dome-1',
        name: 'Test Dome',
        ipAddress: '192.168.1.100',
        port: 8080,
        type: DomeSystemType.professional,
        status: DomeSystemStatus.online,
      );

      expect(dome.id, 'test-dome-1');
      expect(dome.name, 'Test Dome');
      expect(dome.ipAddress, '192.168.1.100');
      expect(dome.port, 8080);
      expect(dome.type, DomeSystemType.professional);
      expect(dome.status, DomeSystemStatus.online);
      expect(dome.isConnected, false); // default value
      expect(dome.projectors, isEmpty);
      expect(dome.audioChannels, isEmpty);
    });

    test('should create DomeSystem with all optional fields', () {
      final lastConnected = DateTime.now();
      const dome = DomeSystem(
        id: 'test-dome-2',
        name: 'Advanced Dome',
        ipAddress: '10.0.0.50',
        port: 9000,
        type: DomeSystemType.hybrid,
        status: DomeSystemStatus.calibrating,
        isConnected: true,
        projectors: [
          ProjectorConfig(
            id: 'proj-1',
            name: 'Main Projector',
            type: ProjectorType.laser,
            brightness: 80,
            contrast: 70,
            status: ProjectorStatus.active,
          ),
        ],
        audioChannels: [
          AudioChannel(
            id: 'audio-1',
            name: 'Main Audio',
            type: AudioChannelType.surround,
          ),
        ],
        firmwareVersion: '2.1.0',
        capabilities: {'supports_4k': true, 'max_projectors': 6},
        activeVendor: 'TestVendor',
        systemVolume: 0.8,
        systemBrightness: 0.9,
        systemRotation: 45.0,
      );

      expect(dome.isConnected, true);
      expect(dome.projectors.length, 1);
      expect(dome.audioChannels.length, 1);
      expect(dome.firmwareVersion, '2.1.0');
      expect(dome.capabilities?['supports_4k'], true);
      expect(dome.activeVendor, 'TestVendor');
      expect(dome.systemVolume, 0.8);
      expect(dome.systemBrightness, 0.9);
      expect(dome.systemRotation, 45.0);
    });

    test('should serialize to and from JSON correctly', () {
      const originalDome = DomeSystem(
        id: 'json-test',
        name: 'JSON Test Dome',
        ipAddress: '172.16.0.1',
        port: 3000,
        type: DomeSystemType.mobile,
        status: DomeSystemStatus.maintenance,
        isConnected: true,
        firmwareVersion: '1.5.2',
      );

      final json = originalDome.toJson();
      final reconstructedDome = DomeSystem.fromJson(json);

      expect(reconstructedDome.id, originalDome.id);
      expect(reconstructedDome.name, originalDome.name);
      expect(reconstructedDome.ipAddress, originalDome.ipAddress);
      expect(reconstructedDome.port, originalDome.port);
      expect(reconstructedDome.type, originalDome.type);
      expect(reconstructedDome.status, originalDome.status);
      expect(reconstructedDome.isConnected, originalDome.isConnected);
      expect(reconstructedDome.firmwareVersion, originalDome.firmwareVersion);
    });

    test('should create copy with updated fields', () {
      const originalDome = DomeSystem(
        id: 'copy-test',
        name: 'Original Dome',
        ipAddress: '192.168.1.200',
        port: 8080,
        type: DomeSystemType.professional,
        status: DomeSystemStatus.offline,
      );

      final updatedDome = originalDome.copyWith(
        status: DomeSystemStatus.online,
        isConnected: true,
        systemVolume: 0.7,
      );

      expect(updatedDome.id, originalDome.id);
      expect(updatedDome.name, originalDome.name);
      expect(updatedDome.status, DomeSystemStatus.online);
      expect(updatedDome.isConnected, true);
      expect(updatedDome.systemVolume, 0.7);
    });
  });

  group('ProjectorConfig', () {
    test('should create ProjectorConfig with required fields', () {
      const projector = ProjectorConfig(
        id: 'proj-test',
        name: 'Test Projector',
        type: ProjectorType.dlp,
        brightness: 85,
        contrast: 75,
        status: ProjectorStatus.standby,
      );

      expect(projector.id, 'proj-test');
      expect(projector.name, 'Test Projector');
      expect(projector.type, ProjectorType.dlp);
      expect(projector.brightness, 85);
      expect(projector.contrast, 75);
      expect(projector.status, ProjectorStatus.standby);
      expect(projector.resolutionWidth, 1920); // default
      expect(projector.resolutionHeight, 1080); // default
    });

    test('should serialize to and from JSON correctly', () {
      const originalProjector = ProjectorConfig(
        id: 'json-proj',
        name: 'JSON Projector',
        type: ProjectorType.laser,
        brightness: 90,
        contrast: 80,
        status: ProjectorStatus.active,
        x: 1.5,
        y: 2.0,
        z: 3.5,
        resolutionWidth: 3840,
        resolutionHeight: 2160,
        refreshRate: 120.0,
      );

      final json = originalProjector.toJson();
      final reconstructed = ProjectorConfig.fromJson(json);

      expect(reconstructed.id, originalProjector.id);
      expect(reconstructed.type, originalProjector.type);
      expect(reconstructed.x, originalProjector.x);
      expect(reconstructed.resolutionWidth, originalProjector.resolutionWidth);
      expect(reconstructed.refreshRate, originalProjector.refreshRate);
    });
  });

  group('AudioChannel', () {
    test('should create AudioChannel with required fields', () {
      const channel = AudioChannel(
        id: 'audio-test',
        name: 'Test Audio',
        type: AudioChannelType.stereo,
      );

      expect(channel.id, 'audio-test');
      expect(channel.name, 'Test Audio');
      expect(channel.type, AudioChannelType.stereo);
      expect(channel.volume, 0.5); // default
      expect(channel.isMuted, false); // default
    });

    test('should serialize to and from JSON correctly', () {
      const originalChannel = AudioChannel(
        id: 'json-audio',
        name: 'JSON Audio',
        type: AudioChannelType.ambisonic,
        volume: 0.8,
        isMuted: true,
        x: 1.0,
        y: 2.0,
        z: 3.0,
        delay: 0.05,
      );

      final json = originalChannel.toJson();
      final reconstructed = AudioChannel.fromJson(json);

      expect(reconstructed.id, originalChannel.id);
      expect(reconstructed.type, originalChannel.type);
      expect(reconstructed.volume, originalChannel.volume);
      expect(reconstructed.isMuted, originalChannel.isMuted);
      expect(reconstructed.x, originalChannel.x);
      expect(reconstructed.delay, originalChannel.delay);
    });
  });

  group('FreeDomeUser', () {
    test('should create FreeDomeUser with required fields', () {
      const user = FreeDomeUser(
        id: 'user-1',
        name: 'Test User',
        role: FreeDomeUserRole.admin,
        permissions: [
          FreeDomePermission.playContent,
          FreeDomePermission.calibrateAudio,
        ],
      );

      expect(user.id, 'user-1');
      expect(user.name, 'Test User');
      expect(user.role, FreeDomeUserRole.admin);
      expect(user.permissions.length, 2);
      expect(user.permissions, contains(FreeDomePermission.playContent));
    });

    test('should serialize to and from JSON correctly', () {
      final lastLogin = DateTime.now();
      final originalUser = FreeDomeUser(
        id: 'json-user',
        name: 'JSON User',
        role: FreeDomeUserRole.operator,
        permissions: FreeDomeUserRole.operator.defaultPermissions,
        email: 'test@example.com',
        lastLogin: lastLogin,
        preferences: {'theme': 'dark', 'language': 'ru'},
      );

      final json = originalUser.toJson();
      final reconstructed = FreeDomeUser.fromJson(json);

      expect(reconstructed.id, originalUser.id);
      expect(reconstructed.role, originalUser.role);
      expect(reconstructed.email, originalUser.email);
      expect(reconstructed.preferences?['theme'], 'dark');
    });
  });

  group('FreeDomeSession', () {
    test('should create FreeDomeSession with required fields', () {
      final startTime = DateTime.now();
      final session = FreeDomeSession(
        id: 'session-1',
        userId: 'user-1',
        domeId: 'dome-1',
        startTime: startTime,
      );

      expect(session.id, 'session-1');
      expect(session.userId, 'user-1');
      expect(session.domeId, 'dome-1');
      expect(session.startTime, startTime);
      expect(session.duration, Duration.zero);
    });

    test('should serialize to and from JSON correctly', () {
      final startTime = DateTime.now();
      final endTime = startTime.add(const Duration(hours: 2));
      final originalSession = FreeDomeSession(
        id: 'json-session',
        userId: 'json-user',
        domeId: 'json-dome',
        startTime: startTime,
        endTime: endTime,
        duration: const Duration(hours: 2),
        currentContentId: 'content-1',
        sessionData: {'total_content_played': 5},
      );

      final json = originalSession.toJson();
      final reconstructed = FreeDomeSession.fromJson(json);

      expect(reconstructed.id, originalSession.id);
      expect(reconstructed.endTime, originalSession.endTime);
      expect(reconstructed.currentContentId, originalSession.currentContentId);
      expect(reconstructed.sessionData?['total_content_played'], 5);
    });
  });

  group('FreeDomeUserRole Extensions', () {
    test('should provide correct display names', () {
      expect(FreeDomeUserRole.guest.displayName, 'Гость');
      expect(FreeDomeUserRole.operator.displayName, 'Оператор');
      expect(FreeDomeUserRole.admin.displayName, 'Администратор');
      expect(FreeDomeUserRole.superadmin.displayName, 'Суперадминистратор');
    });

    test('should provide correct descriptions', () {
      expect(FreeDomeUserRole.guest.description,
          'Может воспроизводить контент и изменять базовые настройки');
      expect(FreeDomeUserRole.admin.description,
          'Может выполнять калибровку и системное администрирование');
    });

    test('should provide correct default permissions', () {
      final guestPermissions = FreeDomeUserRole.guest.defaultPermissions;
      expect(guestPermissions, contains(FreeDomePermission.playContent));
      expect(guestPermissions, contains(FreeDomePermission.controlBasics));
      expect(guestPermissions.length, 2);

      final adminPermissions = FreeDomeUserRole.admin.defaultPermissions;
      expect(adminPermissions, contains(FreeDomePermission.calibrateAudio));
      expect(adminPermissions, contains(FreeDomePermission.systemManagement));
      expect(adminPermissions.length, 6);

      final superAdminPermissions =
          FreeDomeUserRole.superadmin.defaultPermissions;
      expect(superAdminPermissions.length, FreeDomePermission.values.length);
    });

    test('should correctly check permissions', () {
      expect(FreeDomeUserRole.guest.hasPermission(FreeDomePermission.playContent),
          true);
      expect(FreeDomeUserRole.guest.hasPermission(FreeDomePermission.calibrateAudio),
          false);
      expect(FreeDomeUserRole.admin.hasPermission(FreeDomePermission.calibrateAudio),
          true);
    });
  });

  group('DomeSystemType Extensions', () {
    test('should provide correct display names', () {
      expect(DomeSystemType.professional.displayName, 'Профессиональная');
      expect(DomeSystemType.mobile.displayName, 'Мобильная');
      expect(DomeSystemType.hybrid.displayName, 'Гибридная');
    });

    test('should provide correct descriptions', () {
      expect(DomeSystemType.professional.description,
          'Стационарная профессиональная система');
      expect(DomeSystemType.mobile.description,
          'Портативная мобильная система');
    });
  });

  group('DomeSystemStatus Extensions', () {
    test('should provide correct display names', () {
      expect(DomeSystemStatus.online.displayName, 'В сети');
      expect(DomeSystemStatus.offline.displayName, 'Не в сети');
      expect(DomeSystemStatus.connecting.displayName, 'Подключение...');
      expect(DomeSystemStatus.error.displayName, 'Ошибка');
      expect(DomeSystemStatus.maintenance.displayName, 'Обслуживание');
      expect(DomeSystemStatus.calibrating.displayName, 'Калибровка');
    });

    test('should correctly identify operational status', () {
      expect(DomeSystemStatus.online.isOperational, true);
      expect(DomeSystemStatus.offline.isOperational, false);
      expect(DomeSystemStatus.error.isOperational, false);
    });

    test('should correctly identify connection capability', () {
      expect(DomeSystemStatus.offline.canConnect, true);
      expect(DomeSystemStatus.online.canConnect, false);
      expect(DomeSystemStatus.connecting.canConnect, false);
    });

    test('should correctly identify attention requirements', () {
      expect(DomeSystemStatus.error.requiresAttention, true);
      expect(DomeSystemStatus.maintenance.requiresAttention, true);
      expect(DomeSystemStatus.online.requiresAttention, false);
    });
  });
}
