import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Simple Tests', () {
    test('should pass basic test', () {
      expect(1 + 1, equals(2));
    });

    test('should handle strings', () {
      final greeting = 'Hello, FreeDome!';
      expect(greeting, contains('FreeDome'));
    });

    test('should handle lists', () {
      final items = ['item1', 'item2', 'item3'];
      expect(items.length, equals(3));
      expect(items.first, equals('item1'));
    });

    test('should handle maps', () {
      final config = {
        'name': 'FreeDome',
        'version': '2.2.2',
        'enabled': true,
      };

      expect(config['name'], equals('FreeDome'));
      expect(config['version'], equals('2.2.2'));
      expect(config['enabled'], isTrue);
    });

    test('should handle async operations', () async {
      final future =
          Future.delayed(Duration(milliseconds: 100), () => 'completed');
      final result = await future;
      expect(result, equals('completed'));
    });
  });
}
