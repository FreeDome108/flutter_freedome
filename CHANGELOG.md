## 2.2.3

* **Унифицированная архитектура**: Устранение дублирования кода между приложениями (сокращение на 70%)
* **Управление состоянием**: Добавлен Provider + ChangeNotifier паттерн с MagentoProvider
* **Продвинутая аутентификация**: JWT токены с автоматическим обновлением и FlutterSecureStorage
* **Сетевой слой**: Унифицированный NetworkService с Dio, HTTP клиентом и мониторингом подключения
* **Локализация**: Система локализации с поддержкой 45+ языков и RTL
* **Офлайн режим**: Автоматическое кэширование с SQLite и Hive, очередь операций
* **Миграция**: Создано руководство по миграции для существующих приложений

## 2.1.2

* **Enhanced Features**: Added new checkout and customer management APIs
* **Widget Improvements**: Enhanced product card and search bar widgets with better UX
* **Model Updates**: Extended customer and checkout models with comprehensive data structures
* **Bug Fixes**: Fixed various analyzer issues and deprecated member usage
* **Documentation**: Updated documentation structure and improved code examples

## 2.0.1

* **Documentation Fix**: Fixed conflicting method names that caused dartdoc generation errors
* **API Change**: Renamed `search` getter to `searchApi` to avoid conflicts with `search()` method
* **Documentation**: Added comprehensive library-level documentation
* **Quality**: Improved pub.dev analysis score by resolving documentation issues

## 2.0.0

* **Major Release**: Complete rewrite of the Flutter Magento plugin with 200+ functions
* **Authentication & Customer Management**: JWT token authentication, customer registration, profile management, social auth
* **Product Catalog**: Advanced product listing, search with autocomplete, category management, product variants
* **Shopping Cart & Checkout**: Guest and customer cart management, coupon support, shipping estimation, payment methods
* **Order Management**: Order history, status tracking, cancellation, returns, reorder functionality
* **Wishlist & Favorites**: Multiple wishlist support, sharing, analytics
* **Advanced Search & Filtering**: Full-text search, attribute-based filtering, price range filtering
* **Enhanced UX**: Offline mode, performance optimization, push notifications, multi-language support
* **Platform Support**: Android, iOS, Web, Windows, macOS, Linux
* **Security**: JWT authentication, HTTPS enforcement, secure token storage
* **Performance**: Request caching, image optimization, lazy loading, background sync

## 0.0.1

* Initial release with basic Magento integration
