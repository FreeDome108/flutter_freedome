import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_magento/flutter_magento.dart';
import 'providers/magento_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'widgets/auth_wrapper.dart';
import 'config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Magento
  final magento = FlutterMagento();
  final success = await magento.initialize(
    baseUrl: AppConfig.magentoBaseUrl,
    headers: AppConfig.defaultHeaders,
    connectionTimeout: AppConfig.connectionTimeout,
    receiveTimeout: AppConfig.receiveTimeout,
  );
  
  if (!success) {
    print('Failed to initialize Flutter Magento');
    return;
  }
  
  runApp(MyApp(magento: magento));
}

class MyApp extends StatelessWidget {
  final FlutterMagento magento;
  
  const MyApp({super.key, required this.magento});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MagentoProvider(magento)),
        ChangeNotifierProvider(create: (_) => AuthProvider(magento)),
        ChangeNotifierProvider(create: (_) => CartProvider(magento)),
        ChangeNotifierProvider(create: (_) => WishlistProvider(magento)),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


