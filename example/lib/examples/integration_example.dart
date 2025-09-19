import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_magento/flutter_magento.dart';

/// Example of integrating Flutter Magento library with Riverpod state management
class MagentoIntegrationExample extends ConsumerStatefulWidget {
  const MagentoIntegrationExample({super.key});

  @override
  ConsumerState<MagentoIntegrationExample> createState() => _MagentoIntegrationExampleState();
}

class _MagentoIntegrationExampleState extends ConsumerState<MagentoIntegrationExample> {
  final FlutterMagento _magento = FlutterMagento();
  bool _isInitialized = false;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeMagento();
  }

  Future<void> _initializeMagento() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final success = await _magento.initialize(
        baseUrl: 'https://your-magento-store.com',
        headers: {
          'User-Agent': 'FlutterMagentoExample/1.0.0',
        },
      );

      setState(() {
        _isInitialized = success;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magento Integration Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Initializing Magento...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error', style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeMagento,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (!_isInitialized) {
      return const Center(
        child: Text('Failed to initialize Magento'),
      );
    }

    return _buildMainContent();
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatusCard(),
          const SizedBox(height: 16),
          _buildAuthenticationSection(),
          const SizedBox(height: 16),
          _buildProductSection(),
          const SizedBox(height: 16),
          _buildCartSection(),
          const SizedBox(height: 16),
          _buildOrderSection(),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Library Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  _magento.isInitialized ? Icons.check_circle : Icons.error,
                  color: _magento.isInitialized ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text('Initialized: ${_magento.isInitialized}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  _magento.isAuthenticated ? Icons.person : Icons.person_outline,
                  color: _magento.isAuthenticated ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text('Authenticated: ${_magento.isAuthenticated}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.shopping_cart, color: Colors.blue),
                const SizedBox(width: 8),
                Text('Cart Items: ${_magento.cartItemsCount}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.green),
                const SizedBox(width: 8),
                Text('Cart Total: \$${_magento.cartTotal.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthenticationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Authentication',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_magento.isAuthenticated) ...[
              _buildCustomerInfo(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
            ] else ...[
              _buildLoginForm(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfo() {
    final customer = _magento.currentCustomer;
    if (customer == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome, ${customer.firstname} ${customer.lastname}!'),
        Text('Email: ${customer.email}'),
        if (customer.telephone != null) Text('Phone: ${customer.telephone}'),
      ],
    );
  }

  Widget _buildLoginForm() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _login(emailController.text, passwordController.text),
                child: const Text('Login'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showRegistrationDialog(),
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _browseProducts,
                    child: const Text('Browse Products'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _showSearchDialog,
                    child: const Text('Search Products'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shopping Cart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _viewCart,
                    child: const Text('View Cart'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addSampleProduct,
                    child: const Text('Add Sample Product'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_magento.cartItemsCount > 0) ...[
              ElevatedButton(
                onPressed: _clearCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Clear Cart'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _viewOrders,
                    child: const Text('View Orders'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _showWishlist,
                    child: const Text('Wishlist'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Action methods
  Future<void> _login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please enter email and password');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _magento.authenticateCustomer(
        email: email,
        password: password,
      );
      setState(() {});
      _showSnackBar('Login successful!');
    } catch (e) {
      _showSnackBar('Login failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    setState(() => _isLoading = true);

    try {
      await _magento.logout();
      setState(() {});
      _showSnackBar('Logout successful!');
    } catch (e) {
      _showSnackBar('Logout failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      builder: (context) => const RegistrationDialog(),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => const ProductSearchDialog(),
    );
  }

  Future<void> _browseProducts() async {
    try {
      final products = await _magento.getProducts(page: 1, pageSize: 10);
      _showSnackBar('Found ${products['total_count']} products');
    } catch (e) {
      _showSnackBar('Failed to get products: $e');
    }
  }

  Future<void> _viewCart() async {
    try {
      final cart = await _magento.getCart();
      _showSnackBar('Cart loaded with ${cart.items.length} items');
    } catch (e) {
      _showSnackBar('Failed to load cart: $e');
    }
  }

  Future<void> _addSampleProduct() async {
    try {
      // First create cart if needed
      if (_magento.isCartEmpty) {
        await _magento.createCart();
      }

      final added = await _magento.addToCart(
        sku: 'SAMPLE-PRODUCT',
        quantity: 1,
      );

      if (added) {
        setState(() {});
        _showSnackBar('Sample product added to cart!');
      } else {
        _showSnackBar('Failed to add sample product');
      }
    } catch (e) {
      _showSnackBar('Failed to add product: $e');
    }
  }

  Future<void> _clearCart() async {
    try {
      final cleared = await _magento.clearCart();
      if (cleared) {
        setState(() {});
        _showSnackBar('Cart cleared!');
      } else {
        _showSnackBar('Failed to clear cart');
      }
    } catch (e) {
      _showSnackBar('Failed to clear cart: $e');
    }
  }

  Future<void> _viewOrders() async {
    try {
      final orders = await _magento.getCustomerOrders();
      _showSnackBar('Found ${orders.length} orders');
    } catch (e) {
      _showSnackBar('Failed to get orders: $e');
    }
  }

  Future<void> _showWishlist() async {
    try {
      final wishlist = await _magento.getWishlist();
      _showSnackBar('Wishlist loaded');
    } catch (e) {
      _showSnackBar('Failed to load wishlist: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

/// Registration dialog widget
class RegistrationDialog extends StatefulWidget {
  const RegistrationDialog({super.key});

  @override
  State<RegistrationDialog> createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Account'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              validator: (value) => value?.isEmpty == true ? 'Required' : null,
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              validator: (value) => value?.isEmpty == true ? 'Required' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value?.isEmpty == true ? 'Required' : null,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) => value?.isEmpty == true ? 'Required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _register,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Register'),
        ),
      ],
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final magento = FlutterMagento();
      await magento.createCustomer(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

/// Product search dialog widget
class ProductSearchDialog extends StatefulWidget {
  const ProductSearchDialog({super.key});

  @override
  State<ProductSearchDialog> createState() => _ProductSearchDialogState();
}

class _ProductSearchDialogState extends State<ProductSearchDialog> {
  final _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search Products'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search Query',
              hintText: 'Enter product name, category, etc.',
            ),
            onSubmitted: (_) => _search(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _search,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Search'),
        ),
      ],
    );
  }

  Future<void> _search() async {
    if (_searchController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final magento = FlutterMagento();
      final results = await magento.searchProducts(
        _searchController.text,
        page: 1,
        pageSize: 10,
      );

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Found ${results['total_count']} products')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Search failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
