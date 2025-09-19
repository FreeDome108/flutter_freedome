import 'package:flutter/material.dart';
import 'package:flutter_freedome/flutter_freedome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FreeDomeExampleApp());
}

class FreeDomeExampleApp extends StatelessWidget {
  const FreeDomeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FreeDomeProvider(),
      child: MaterialApp(
        title: 'Flutter FreeDome Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const FreeDomeHomePage(),
      ),
    );
  }
}

class FreeDomeHomePage extends StatefulWidget {
  const FreeDomeHomePage({super.key});

  @override
  State<FreeDomeHomePage> createState() => _FreeDomeHomePageState();
}

class _FreeDomeHomePageState extends State<FreeDomeHomePage> {
  int _selectedIndex = 0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFreeDome();
  }

  Future<void> _initializeFreeDome() async {
    final freedome = context.read<FreeDomeProvider>();
    await freedome.initialize();
    setState(() => _isInitialized = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter FreeDome Example'),
        actions: [
          FreeDomeStatusIndicator(
            showDetails: true,
            onTap: () => _showStatusDialog(context),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : IndexedStack(
              index: _selectedIndex,
              children: const [
                _GuestModeTab(),
                _ContentLibraryTab(),
                _AdminModeTab(),
                _SettingsTab(),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: 'Гостевой режим',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Библиотека',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Администратор',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }

  void _showStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: FreeDomeDetailedStatus(),
      ),
    );
  }
}

/// Вкладка гостевого режима
class _GuestModeTab extends StatelessWidget {
  const _GuestModeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Гостевой режим',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Воспроизводите контент на купольных экранах',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),

          // Виджет подключения
          FreeDomeConnectionWidget(
            onConnected: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Подключен к FreeDome!')),
              );
            },
          ),

          const SizedBox(height: 24),

          // Плеер контента
          const FreeDomeContentPlayer(),

          const SizedBox(height: 24),

          // Быстрые действия
          _buildQuickActions(context),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Быстрые действия',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _QuickActionButton(
                  icon: Icons.star,
                  label: 'Звездное небо',
                  onPressed: () => _playStarrySkr(context),
                ),
                _QuickActionButton(
                  icon: Icons.public,
                  label: 'Планеты',
                  onPressed: () => _playPlanets(context),
                ),
                _QuickActionButton(
                  icon: Icons.self_improvement,
                  label: 'Медитация',
                  onPressed: () => _playMeditation(context),
                ),
                _QuickActionButton(
                  icon: Icons.games,
                  label: 'Игра',
                  onPressed: () => _playGame(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _playStarrySkr(BuildContext context) async {
    final freedome = context.read<FreeDomeProvider>();

    final success = await freedome.playAppContent(
      appName: 'StarrySkr',
      contentName: 'Звездное небо',
      appData: {
        'type': 'starfield',
        'constellation': 'all',
        'time': DateTime.now().toIso8601String(),
      },
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось запустить звездное небо')),
      );
    }
  }

  Future<void> _playPlanets(BuildContext context) async {
    final freedome = context.read<FreeDomeProvider>();

    final success = await freedome.playAppContent(
      appName: 'SolarSystem',
      contentName: 'Солнечная система',
      appData: {
        'type': 'solar_system',
        'showOrbits': true,
        'speed': 1.0,
      },
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось запустить планетарий')),
      );
    }
  }

  Future<void> _playMeditation(BuildContext context) async {
    final freedome = context.read<FreeDomeProvider>();

    final success = await freedome.playAppContent(
      appName: 'MeditationApp',
      contentName: 'Медитация',
      appData: {
        'type': 'meditation',
        'duration': 300, // 5 минут
        'background': 'nature',
        'mantra': 'OM',
      },
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось запустить медитацию')),
      );
    }
  }

  Future<void> _playGame(BuildContext context) async {
    final freedome = context.read<FreeDomeProvider>();

    final success = await freedome.playAppContent(
      appName: 'DomeGame',
      contentName: 'Космическая игра',
      appData: {
        'type': 'space_game',
        'difficulty': 'medium',
        'players': 1,
      },
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось запустить игру')),
      );
    }
  }
}

/// Кнопка быстрого действия
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

/// Вкладка библиотеки контента
class _ContentLibraryTab extends StatelessWidget {
  const _ContentLibraryTab();

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDomeProvider>(
      builder: (context, freedome, child) {
        final content = freedome.content.contentLibrary;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Библиотека контента',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              if (content.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('Библиотека контента пуста'),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: content.length,
                    itemBuilder: (context, index) {
                      final item = content[index];
                      return _ContentTile(content: item);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Элемент списка контента
class _ContentTile extends StatelessWidget {
  final ProjectionContent content;

  const _ContentTile({required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: _buildContentIcon(),
        title: Text(content.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (content.description != null) Text(content.description!),
            const SizedBox(height: 4),
            Text(
              '${content.type.name} • ${_formatDuration(content.duration)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: Consumer<FreeDomeProvider>(
          builder: (context, freedome, child) {
            return IconButton(
              onPressed: freedome.isConnected
                  ? () => freedome.playContent(content)
                  : null,
              icon: const Icon(Icons.play_arrow),
              tooltip: 'Воспроизвести',
            );
          },
        ),
        isThreeLine: content.description != null,
      ),
    );
  }

  Widget _buildContentIcon() {
    switch (content.type) {
      case ContentType.video:
        return const Icon(Icons.movie, color: Colors.blue);
      case ContentType.image:
        return const Icon(Icons.image, color: Colors.green);
      case ContentType.interactive:
        return const Icon(Icons.touch_app, color: Colors.purple);
      case ContentType.audio:
        return const Icon(Icons.audiotrack, color: Colors.orange);
      default:
        return const Icon(Icons.file_present, color: Colors.grey);
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

/// Вкладка режима администратора
class _AdminModeTab extends StatelessWidget {
  const _AdminModeTab();

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDomeProvider>(
      builder: (context, freedome, child) {
        if (!freedome.hasRole(FreeDomeUserRole.admin)) {
          return _buildAuthenticationUI(context, freedome);
        }

        return _buildAdminUI(context, freedome);
      },
    );
  }

  Widget _buildAuthenticationUI(
      BuildContext context, FreeDomeProvider freedome) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.admin_panel_settings,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            'Режим администратора',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Для доступа к функциям калибровки и системного управления требуется аутентификация',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _showAdminLogin(context, freedome),
            icon: const Icon(Icons.login),
            label: const Text('Войти как администратор'),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminUI(BuildContext context, FreeDomeProvider freedome) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Панель администратора',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => freedome.logout(),
                icon: const Icon(Icons.logout),
                label: const Text('Выйти'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _AdminActionCard(
                  icon: Icons.tune,
                  title: 'Калибровка аудио',
                  description: 'Настройка звуковой системы',
                  onTap: () => _startAudioCalibration(context, freedome),
                ),
                _AdminActionCard(
                  icon: Icons.video_settings,
                  title: 'Калибровка проекторов',
                  description: 'Настройка проекционной системы',
                  onTap: () => _startProjectorCalibration(context, freedome),
                ),
                _AdminActionCard(
                  icon: Icons.monitor,
                  title: 'Мониторинг системы',
                  description: 'Состояние и метрики',
                  onTap: () => _showSystemMonitoring(context, freedome),
                ),
                _AdminActionCard(
                  icon: Icons.extension,
                  title: 'Управление вендорами',
                  description: 'Адаптеры и совместимость',
                  onTap: () => _showVendorManagement(context, freedome),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAdminLogin(BuildContext context, FreeDomeProvider freedome) {
    showDialog(
      context: context,
      builder: (context) => _AdminLoginDialog(freedome: freedome),
    );
  }

  Future<void> _startAudioCalibration(
      BuildContext context, FreeDomeProvider freedome) async {
    final calibrationService = freedome.calibration;
    if (calibrationService == null) return;

    final calibrationId = await calibrationService.startAudioCalibration();

    if (calibrationId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Калибровка аудио запущена')),
      );
    }
  }

  Future<void> _startProjectorCalibration(
      BuildContext context, FreeDomeProvider freedome) async {
    final calibrationService = freedome.calibration;
    if (calibrationService == null) return;

    final calibrationId = await calibrationService.startProjectorCalibration();

    if (calibrationId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Калибровка проекторов запущена')),
      );
    }
  }

  void _showSystemMonitoring(BuildContext context, FreeDomeProvider freedome) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Мониторинг системы'),
        content: const Text(
            'Функция мониторинга будет доступна в следующей версии.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _showVendorManagement(BuildContext context, FreeDomeProvider freedome) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Управление вендорами'),
        content: const Text(
            'Функция управления вендорами будет доступна в следующей версии.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}

/// Карточка действия администратора
class _AdminActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _AdminActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Диалог входа администратора
class _AdminLoginDialog extends StatefulWidget {
  final FreeDomeProvider freedome;

  const _AdminLoginDialog({required this.freedome});

  @override
  State<_AdminLoginDialog> createState() => _AdminLoginDialogState();
}

class _AdminLoginDialogState extends State<_AdminLoginDialog> {
  final _usernameController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: 'admin123');
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Вход администратора'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Имя пользователя',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Пароль',
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _login,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Войти'),
        ),
      ],
    );
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);

    try {
      final success = await widget.freedome.authenticateAsAdmin(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Добро пожаловать, администратор!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Неверные учетные данные'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

/// Вкладка настроек
class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Настройки',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'О библиотеке Flutter FreeDome',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Text('Версия: ${FlutterFreeDome.version}'),
                  const SizedBox(height: 8),
                  Text('Автор: NativeMind Team'),
                  const SizedBox(height: 8),
                  Text('Лицензия: NativeMindNONC'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
