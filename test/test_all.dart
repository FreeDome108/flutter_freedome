/// Comprehensive test runner for Flutter FreeDome
///
/// This file imports and runs all test suites to ensure comprehensive coverage
/// of the Flutter FreeDome library functionality.

// Unit Tests - Models
import 'unit/models/dome_models_test.dart' as dome_models_tests;
import 'unit/models/content_models_test.dart' as content_models_tests;

// Unit Tests - Core Services
import 'unit/core/freedome_provider_test.dart' as provider_tests;
import 'unit/core/auth_service_test.dart' as auth_tests;
import 'unit/core/content_service_test.dart' as content_service_tests;
import 'unit/core/connection_service_test.dart' as connection_service_tests;

// Unit Tests - Admin Services
import 'unit/admin/calibration_service_test.dart' as calibration_service_tests;

// Widget Tests
import 'widget/freedome_status_indicator_test.dart' as status_indicator_tests;
import 'widget/freedome_connection_widget_test.dart' as connection_widget_tests;
import 'widget/freedome_content_player_test.dart' as content_player_tests;
import 'widget/freedome_detailed_status_test.dart' as detailed_status_tests;

// Integration Tests
import 'integration/flutter_freedome_integration_test.dart'
    as integration_tests;

void main() {
  // Run all unit tests - Models
  dome_models_tests.main();
  content_models_tests.main();

  // Run all unit tests - Core Services
  provider_tests.main();
  auth_tests.main();
  content_service_tests.main();
  connection_service_tests.main();

  // Run all unit tests - Admin Services
  calibration_service_tests.main();

  // Run all widget tests
  status_indicator_tests.main();
  connection_widget_tests.main();
  content_player_tests.main();
  detailed_status_tests.main();

  // Run all integration tests
  integration_tests.main();
}
