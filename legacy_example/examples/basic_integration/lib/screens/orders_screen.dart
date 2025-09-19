import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_magento/flutter_magento.dart';
import '../providers/auth_provider.dart';

class Order {
  final String id;
  final String status;
  final double total;
  final DateTime createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id']?.toString() ?? '',
      status: json['status'] ?? 'Unknown',
      total: (json['total'] ?? 0.0).toDouble(),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ?? [],
    );
  }
}

class OrderItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String? image;

  OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.image,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown Product',
      quantity: json['quantity'] ?? 1,
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'],
    );
  }
}

class OrdersProvider extends ChangeNotifier {
  final FlutterMagento? _magento;
  
  OrdersProvider(this._magento);
  
  // Orders
  List<Order> _orders = [];
  List<Order> get orders => _orders;
  
  // Loading states
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  // Error handling
  String? _error;
  String? get error => _error;
  
  /// Load customer orders
  Future<void> loadOrders() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      // TODO: Implement actual Magento orders API call
      // For now, we'll use mock data
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      _orders = _getMockOrders();
      
      _error = null;
    } catch (e) {
      _error = 'Failed to load orders: $e';
      if (kDebugMode) {
        print('Load orders error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Get order by ID
  Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }
  
  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
  
  /// Mock orders data - replace with actual API call
  List<Order> _getMockOrders() {
    return [
      Order(
        id: '1',
        status: 'Complete',
        total: 129.99,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        items: [
          OrderItem(
            id: '1',
            name: 'Sample Product 1',
            quantity: 2,
            price: 49.99,
            image: 'https://via.placeholder.com/100',
          ),
          OrderItem(
            id: '2',
            name: 'Sample Product 2',
            quantity: 1,
            price: 29.99,
            image: 'https://via.placeholder.com/100',
          ),
        ],
      ),
      Order(
        id: '2',
        status: 'Processing',
        total: 79.99,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        items: [
          OrderItem(
            id: '3',
            name: 'Sample Product 3',
            quantity: 1,
            price: 79.99,
            image: 'https://via.placeholder.com/100',
          ),
        ],
      ),
      Order(
        id: '3',
        status: 'Shipped',
        total: 199.99,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        items: [
          OrderItem(
            id: '4',
            name: 'Sample Product 4',
            quantity: 1,
            price: 199.99,
            image: 'https://via.placeholder.com/100',
          ),
        ],
      ),
    ];
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrdersProvider _ordersProvider;

  @override
  void initState() {
    super.initState();
    // We'll need to pass the magento instance differently
    // For now, we'll create a mock provider
    _ordersProvider = OrdersProvider(null as dynamic);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ordersProvider.loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _ordersProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Consumer<OrdersProvider>(
          builder: (context, ordersProvider, child) {
            if (ordersProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (ordersProvider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading orders',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ordersProvider.error!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: ordersProvider.clearError,
                      child: const Text('Dismiss'),
                    ),
                  ],
                ),
              );
            }

            if (ordersProvider.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No orders found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your order history will appear here',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Continue Shopping'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: ordersProvider.loadOrders,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ordersProvider.orders.length,
                itemBuilder: (context, index) {
                  final order = ordersProvider.orders[index];
                  return _OrderCard(order: order);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          _showOrderDetails(context, order);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.id}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order.status,
                      style: TextStyle(
                        color: _getStatusColor(order.status),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Order Date
              Text(
                'Ordered on ${_formatDate(order.createdAt)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Order Items Preview
              ...order.items.take(2).map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.shade100,
                      ),
                      child: item.image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                item.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.image_not_supported,
                                    size: 20,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            )
                          : const Icon(
                              Icons.image_not_supported,
                              size: 20,
                              color: Colors.grey,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Qty: ${item.quantity}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              )),
              
              if (order.items.length > 2) ...[
                const SizedBox(height: 4),
                Text(
                  'and ${order.items.length - 2} more item(s)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              
              const SizedBox(height: 12),
              
              // Order Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'complete':
        return Colors.green;
      case 'processing':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Order Details Header
              Text(
                'Order #${order.id}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ordered on ${_formatDate(order.createdAt)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              
              // Order Items
              Text(
                'Items (${order.items.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: order.items.length,
                  itemBuilder: (context, index) {
                    final item = order.items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade100,
                              ),
                              child: item.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item.image!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.image_not_supported,
                                            size: 24,
                                            color: Colors.grey,
                                          );
                                        },
                                      ),
                                    )
                                  : const Icon(
                                      Icons.image_not_supported,
                                      size: 24,
                                      color: Colors.grey,
                                    ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: Theme.of(context).textTheme.titleSmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Quantity: ${item.quantity}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Order Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '\$${order.total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${order.total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
