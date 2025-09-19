
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_magento/src/api/auth_api.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group('AuthApi', () {
    test('customerLogin returns token on success', () async {
      final client = MockClient();
      final authApi = AuthApi('https://magento.instance.com', client);

      when(client.post(
        Uri.parse('https://magento.instance.com/rest/V1/integration/customer/token'),
        headers: {'Content-Type': 'application/json'},
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('"mock_token"', 200));

      final token = await authApi.customerLogin('test@example.com', 'password');

      expect(token, 'mock_token');
    });
  });
}
