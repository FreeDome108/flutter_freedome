import 'package:flutter/material.dart';
import 'package:flutter_magento/flutter_magento.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MagentoProvider(),
      child: MaterialApp(
        title: 'Flutter Magento Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _initializeMagento();
  }

  Future<void> _initializeMagento() async {
    final magento = context.read<MagentoProvider>();
    await magento.initialize(
      baseUrl: 'https://demo.magento.com',
      supportedLanguages: ['en', 'ru', 'de', 'fr', 'es'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Magento Example'),
      ),
      body: Consumer<MagentoProvider>(
        builder: (context, magento, child) {
          if (!magento.isInitialized) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Flutter Magento Plugin 2.0',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Унифицированная библиотека для интеграции с Magento',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                Text(
                  '✅ Управление состоянием',
                ),
                Text(
                  '✅ Аутентификация с JWT',
                ),
                Text(
                  '✅ Сетевой слой с Dio',
                ),
                Text(
                  '✅ Локализация 45+ языков',
                ),
                Text(
                  '✅ Офлайн режим',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
