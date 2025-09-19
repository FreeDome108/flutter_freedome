import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_magento/flutter_magento.dart';

void main() {
  group('FlutterMagento', () {
    late FlutterMagento magento;

    setUp(() {
      magento = FlutterMagento();
    });

    tearDown(() {
      magento.reset();
    });

    group('Initialization', () {
      test('should initialize successfully with valid base URL', () async {
        final success = await magento.initialize(
          baseUrl: 'https://test-store.magento.com',
        );

        expect(success, isTrue);
        expect(magento.isInitialized, isTrue);
        expect(magento.baseUrl, equals('https://test-store.magento.com'));
      });

      test('should fail initialization with invalid base URL', () async {
        final success = await magento.initialize(
          baseUrl: 'invalid-url',
        );

        expect(success, isFalse);
        expect(magento.isInitialized, isFalse);
      });

      test('should handle initialization with custom headers', () async {
        final success = await magento.initialize(
          baseUrl: 'https://test-store.magento.com',
          headers: {
            'User-Agent': 'TestApp/1.0.0',
            'X-Custom-Header': 'test-value',
          },
        );

        expect(success, isTrue);
      });

      test('should handle initialization with custom timeouts', () async {
        final success = await magento.initialize(
          baseUrl: 'https://test-store.magento.com',
          connectionTimeout: 60000,
          receiveTimeout: 60000,
        );

        expect(success, isTrue);
      });
    });

    group('Authentication', () {
      setUp(() async {
        await magento.initialize(baseUrl: 'https://test-store.magento.com');
      });

      test('should not be authenticated initially', () {
        expect(magento.isAuthenticated, isFalse);
        expect(magento.currentCustomer, isNull);
        expect(magento.customerToken, isNull);
      });

      test('should handle authentication errors gracefully', () async {
        try {
          await magento.authenticateCustomer(
            email: 'invalid@email.com',
            password: 'wrongpassword',
          );
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });
    });

    group('Product Management', () {
      setUp(() async {
        await magento.initialize(baseUrl: 'https://test-store.magento.com');
      });

      test('should handle product retrieval errors gracefully', () async {
        try {
          await magento.getProducts();
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle product search errors gracefully', () async {
        try {
          await magento.searchProducts('test query');
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle single product retrieval errors gracefully', () async {
        try {
          await magento.getProduct('INVALID-SKU');
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });
    });

    group('Cart Operations', () {
      setUp(() async {
        await magento.initialize(baseUrl: 'https://test-store.magento.com');
      });

      test('should handle cart creation errors gracefully', () async {
        try {
          await magento.createCart();
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle cart retrieval errors gracefully', () async {
        try {
          await magento.getCart();
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle add to cart errors gracefully', () async {
        try {
          await magento.addToCart(
            sku: 'TEST-SKU',
            quantity: 1,
          );
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });
    });

    group('Order Management', () {
      setUp(() async {
        await magento.initialize(baseUrl: 'https://test-store.magento.com');
      });

      test('should handle order retrieval errors gracefully', () async {
        try {
          await magento.getCustomerOrders();
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle single order retrieval errors gracefully', () async {
        try {
          await magento.getOrder('INVALID-ORDER-ID');
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });
    });

    group('Wishlist Operations', () {
      setUp(() async {
        await magento.initialize(baseUrl: 'https://test-store.magento.com');
      });

      test('should handle wishlist retrieval errors gracefully', () async {
        try {
          await magento.getWishlist();
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle add to wishlist errors gracefully', () async {
        try {
          await magento.addToWishlist('INVALID-SKU');
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle remove from wishlist errors gracefully', () async {
        try {
          await magento.removeFromWishlist(999);
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });
    });

    group('Checkout Process', () {
      setUp(() async {
        await magento.initialize(baseUrl: 'https://test-store.magento.com');
      });

      test('should handle shipping estimation errors gracefully', () async {
        try {
          await magento.estimateShipping({
            'country_id': 'US',
            'postcode': '12345',
          });
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle payment methods retrieval errors gracefully', () async {
        try {
          await magento.getPaymentMethods();
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });

      test('should handle order placement errors gracefully', () async {
        try {
          await magento.placeOrder({
            'paymentMethod': {'method': 'test'},
            'billing_address': {},
            'shipping_address': {},
          });
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<MagentoException>());
        }
      });
    });

    group('Utility Methods', () {
      setUp(() async {
        await magento.initialize(baseUrl: 'https://test-store.magento.com');
      });

      test('should return correct version', () {
        expect(magento.version, equals('1.0.0'));
      });

      test('should return correct description', () {
        expect(magento.description, contains('Magento e-commerce platform'));
      });

      test('should handle cart state queries', () {
        expect(magento.isCartEmpty, isTrue);
        expect(magento.cartItemsCount, equals(0));
        expect(magento.cartTotal, equals(0.0));
      });

      test('should handle product in cart queries', () {
        expect(magento.isProductInCart('TEST-SKU'), isFalse);
        expect(magento.getProductQuantityInCart('TEST-SKU'), equals(0));
      });
    });

    group('Error Handling', () {
      test('should throw exception when using uninitialized library', () {
        expect(
          () => magento.isAuthenticated,
          throwsA(isA<MagentoException>()),
        );

        expect(
          () => magento.currentCustomer,
          throwsA(isA<MagentoException>()),
        );

        expect(
          () => magento.customerToken,
          throwsA(isA<MagentoException>()),
        );
      });

      test('should throw exception when calling methods on uninitialized library', () async {
        expect(
          () => magento.getProducts(),
          throwsA(isA<MagentoException>()),
        );

        expect(
          () => magento.authenticateCustomer(
            email: 'test@example.com',
            password: 'password',
          ),
          throwsA(isA<MagentoException>()),
        );

        expect(
          () => magento.createCart(),
          throwsA(isA<MagentoException>()),
        );
      });
    });

    group('Library State', () {
      test('should reset library state correctly', () async {
        await magento.initialize(baseUrl: 'https://test-store.magento.com');
        expect(magento.isInitialized, isTrue);

        magento.reset();
        expect(magento.isInitialized, isFalse);
        expect(magento.baseUrl, isNull);
      });

      test('should handle multiple initializations', () async {
        await magento.initialize(baseUrl: 'https://store1.magento.com');
        expect(magento.baseUrl, equals('https://store1.magento.com'));

        await magento.initialize(baseUrl: 'https://store2.magento.com');
        expect(magento.baseUrl, equals('https://store2.magento.com'));
      });
    });
  });
}
