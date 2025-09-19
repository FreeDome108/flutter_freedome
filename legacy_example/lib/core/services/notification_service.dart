import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Initialize local notifications
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions
    await _requestPermissions();

    // Handle Firebase messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
  }

  static Future<void> _requestPermissions() async {
    // Local notifications
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    // Firebase messaging
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        await _saveToken(token);
      }
    }
  }

  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
    // TODO: Send token to backend
  }

  static void _handleForegroundMessage(RemoteMessage message) {
    _showLocalNotification(
      title: message.notification?.title ?? 'Новый налоговый залог',
      body: message.notification?.body ?? 'Проверьте новые предложения',
      payload: message.data.toString(),
    );
  }

  static void _handleBackgroundMessage(RemoteMessage message) {
    // Handle when app is opened from notification
    print('App opened from notification: ${message.data}');
  }

  static void _onNotificationTapped(NotificationResponse response) {
    // Handle local notification tap
    print('Local notification tapped: ${response.payload}');
  }

  static Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'taxlien_channel',
      'TaxLien Notifications',
      channelDescription: 'Уведомления о новых налоговых залогах',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
      payload: payload,
    );
  }

  static Future<void> showTaxLienNotification({
    required String propertyAddress,
    required double taxAmount,
    required double interestRate,
  }) async {
    await _showLocalNotification(
      title: 'Новый налоговый залог',
      body: '$propertyAddress\nСумма: \$${taxAmount.toStringAsFixed(2)}\nПроцент: ${interestRate.toStringAsFixed(2)}%',
      payload: 'tax_lien_new',
    );
  }

  static Future<void> showBidNotification({
    required String propertyAddress,
    required double bidAmount,
  }) async {
    await _showLocalNotification(
      title: 'Новая ставка',
      body: '$propertyAddress\nСтавка: \$${bidAmount.toStringAsFixed(2)}',
      payload: 'bid_new',
    );
  }

  static Future<void> showAuctionNotification({
    required String propertyAddress,
    required DateTime auctionTime,
  }) async {
    await _showLocalNotification(
      title: 'Аукцион скоро начнется',
      body: '$propertyAddress\nВремя: ${auctionTime.toString().substring(0, 16)}',
      payload: 'auction_soon',
    );
  }
}

class NotificationNotifier extends StateNotifier<bool> {
  NotificationNotifier() : super(false) {
    _loadNotificationSettings();
  }

  static const String _notificationsEnabledKey = 'notifications_enabled';

  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  Future<void> toggleNotifications() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, state);
  }

  Future<void> enableNotifications() async {
    state = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, true);
  }

  Future<void> disableNotifications() async {
    state = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, false);
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, bool>((ref) {
  return NotificationNotifier();
});
