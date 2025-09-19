import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import '../models/app_models.dart';

/// Network connectivity service
class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  
  final StreamController<NetworkStatus> _networkStatusController = 
      StreamController<NetworkStatus>.broadcast();

  NetworkStatus _currentStatus = const NetworkStatus();

  /// Stream of network status changes
  Stream<NetworkStatus> get networkStatusStream => _networkStatusController.stream;

  /// Current network status
  NetworkStatus get currentStatus => _currentStatus;

  /// Initialize network monitoring
  Future<void> initialize() async {
    // Get initial connectivity status
    await _updateNetworkStatus();

    // Listen for connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        await _updateNetworkStatus();
      },
    );

    if (kDebugMode) {
      print('📡 Network Service initialized');
      print('📡 Initial status: ${_currentStatus.isConnected ? 'Connected' : 'Disconnected'}');
    }
  }

  /// Update network status
  Future<void> _updateNetworkStatus() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final status = _mapConnectivityResult(connectivityResult);
      
      if (_currentStatus != status) {
        _currentStatus = status;
        _networkStatusController.add(status);
        
        if (kDebugMode) {
          print('📡 Network status changed: ${status.connectionType}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error updating network status: $e');
      }
    }
  }

  /// Map connectivity result to network status
  NetworkStatus _mapConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return const NetworkStatus(
          isConnected: true,
          isWiFi: true,
          isMobile: false,
          connectionType: 'WiFi',
        );
      case ConnectivityResult.mobile:
        return const NetworkStatus(
          isConnected: true,
          isWiFi: false,
          isMobile: true,
          connectionType: 'Mobile',
        );
      case ConnectivityResult.ethernet:
        return const NetworkStatus(
          isConnected: true,
          isWiFi: false,
          isMobile: false,
          connectionType: 'Ethernet',
        );
      case ConnectivityResult.vpn:
        return const NetworkStatus(
          isConnected: true,
          isWiFi: false,
          isMobile: false,
          connectionType: 'VPN',
        );
      case ConnectivityResult.bluetooth:
        return const NetworkStatus(
          isConnected: true,
          isWiFi: false,
          isMobile: false,
          connectionType: 'Bluetooth',
        );
      case ConnectivityResult.other:
        return const NetworkStatus(
          isConnected: true,
          isWiFi: false,
          isMobile: false,
          connectionType: 'Other',
        );
      case ConnectivityResult.none:
      default:
        return const NetworkStatus(
          isConnected: false,
          isWiFi: false,
          isMobile: false,
          connectionType: 'None',
        );
    }
  }

  /// Check if device is connected to internet
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error checking connectivity: $e');
      }
      return false;
    }
  }

  /// Check if device is connected to WiFi
  Future<bool> isWiFiConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result == ConnectivityResult.wifi;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error checking WiFi connectivity: $e');
      }
      return false;
    }
  }

  /// Check if device is connected to mobile data
  Future<bool> isMobileConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result == ConnectivityResult.mobile;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error checking mobile connectivity: $e');
      }
      return false;
    }
  }

  /// Get connection type as string
  Future<String> getConnectionType() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return _mapConnectivityResult(result).connectionType ?? 'Unknown';
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting connection type: $e');
      }
      return 'Unknown';
    }
  }

  /// Wait for internet connection
  Future<void> waitForConnection({Duration? timeout}) async {
    if (await isConnected()) return;

    final completer = Completer<void>();
    StreamSubscription<NetworkStatus>? subscription;

    subscription = networkStatusStream.listen((status) {
      if (status.isConnected) {
        subscription?.cancel();
        if (!completer.isCompleted) {
          completer.complete();
        }
      }
    });

    // Set timeout if provided
    if (timeout != null) {
      Timer(timeout, () {
        subscription?.cancel();
        if (!completer.isCompleted) {
          completer.completeError(TimeoutException('Connection timeout', timeout));
        }
      });
    }

    return completer.future;
  }

  /// Test internet connectivity by making a simple request
  Future<bool> testInternetConnection() async {
    try {
      // Simple connectivity test - you can replace with your server
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      }

      // Additional test could be made here to ping a server
      // For now, we'll rely on the connectivity result
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Internet connection test failed: $e');
      }
      return false;
    }
  }

  /// Get network quality estimation based on connection type
  NetworkQuality getNetworkQuality() {
    switch (_currentStatus.connectionType) {
      case 'WiFi':
      case 'Ethernet':
        return NetworkQuality.excellent;
      case 'Mobile':
        return NetworkQuality.good; // Could be enhanced with actual speed test
      case 'VPN':
        return NetworkQuality.fair;
      case 'Bluetooth':
        return NetworkQuality.poor;
      default:
        return NetworkQuality.none;
    }
  }

  /// Check if connection is suitable for heavy operations
  bool isSuitableForHeavyOperations() {
    final quality = getNetworkQuality();
    return quality == NetworkQuality.excellent || quality == NetworkQuality.good;
  }

  /// Check if connection is metered (mobile data)
  bool isMeteredConnection() {
    return _currentStatus.isMobile;
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _networkStatusController.close();
  }
}

/// Network quality levels
enum NetworkQuality {
  none,
  poor,
  fair,
  good,
  excellent,
}

/// Timeout exception for network operations
class TimeoutException implements Exception {
  final String message;
  final Duration? duration;

  const TimeoutException(this.message, [this.duration]);

  @override
  String toString() {
    if (duration != null) {
      return 'TimeoutException: $message (${duration!.inSeconds}s)';
    }
    return 'TimeoutException: $message';
  }
}
