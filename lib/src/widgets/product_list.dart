import 'package:flutter/material.dart';
import '../models/product_models.dart';
import 'product_card.dart';

/// Product list widget with pagination support
class ProductList extends StatefulWidget {
  final List<Product> products;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback? onLoadMore;
  final VoidCallback? onRefresh;
  final Function(Product)? onProductTap;
  final Function(Product)? onAddToCart;
  final Function(Product)? onAddToWishlist;
  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const ProductList({
    super.key,
    required this.products,
    this.isLoading = false,
    this.hasMore = false,
    this.onLoadMore,
    this.onRefresh,
    this.onProductTap,
    this.onAddToCart,
    this.onAddToWishlist,
    this.scrollController,
    this.padding,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.75,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.hasMore && !_isLoadingMore && widget.onLoadMore != null) {
        setState(() {
          _isLoadingMore = true;
        });
        widget.onLoadMore!();
        // Reset loading state after a delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _isLoadingMore = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty && !widget.isLoading) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        widget.onRefresh?.call();
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: widget.padding ?? const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                childAspectRatio: widget.childAspectRatio,
                mainAxisSpacing: widget.mainAxisSpacing,
                crossAxisSpacing: widget.crossAxisSpacing,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= widget.products.length) {
                    return _buildLoadMoreIndicator();
                  }
                  return _buildProductCard(widget.products[index]);
                },
                childCount: widget.products.length + (widget.hasMore ? 1 : 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return ProductCard(
      product: product,
      onTap: () => widget.onProductTap?.call(product),
      onAddToCart: () => widget.onAddToCart?.call(product),
      onAddToWishlist: () => widget.onAddToWishlist?.call(product),
    );
  }

  Widget _buildLoadMoreIndicator() {
    if (!widget.hasMore) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

/// Product list with search and filter capabilities
class ProductListWithFilters extends StatefulWidget {
  final Future<ProductListResponse> Function({
    int page,
    int pageSize,
    String? searchQuery,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
    double? minPrice,
    double? maxPrice,
    bool? inStock,
  }) onLoadProducts;
  
  final VoidCallback? onProductTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onAddToWishlist;
  final String? initialSearchQuery;
  final String? initialCategoryId;
  final Map<String, dynamic>? initialFilters;

  const ProductListWithFilters({
    super.key,
    required this.onLoadProducts,
    this.onProductTap,
    this.onAddToCart,
    this.onAddToWishlist,
    this.initialSearchQuery,
    this.initialCategoryId,
    this.initialFilters,
  });

  @override
  State<ProductListWithFilters> createState() => _ProductListWithFiltersState();
}

class _ProductListWithFiltersState extends State<ProductListWithFilters> {
  final List<Product> _products = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int _pageSize = 20;
  
  String? _searchQuery;
  String? _categoryId;
  Map<String, dynamic>? _filters;
  String? _sortBy;
  String? _sortOrder;

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.initialSearchQuery;
    _categoryId = widget.initialCategoryId;
    _filters = widget.initialFilters;
    _loadProducts(reset: true);
  }

  Future<void> _loadProducts({bool reset = false}) async {
    if (reset) {
      setState(() {
        _products.clear();
        _currentPage = 1;
        _hasMore = true;
      });
    }

    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await widget.onLoadProducts(
        page: _currentPage,
        pageSize: _pageSize,
        searchQuery: _searchQuery,
        categoryId: _categoryId,
        sortBy: _sortBy,
        sortOrder: _sortOrder,
        filters: _filters,
      );

      setState(() {
        if (reset) {
          _products.clear();
        }
        _products.addAll(response.items);
        _hasMore = response.currentPage < response.totalPages;
        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load products: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _updateFilters({
    String? searchQuery,
    String? categoryId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    setState(() {
      _searchQuery = searchQuery ?? _searchQuery;
      _categoryId = categoryId ?? _categoryId;
      _filters = filters ?? _filters;
      _sortBy = sortBy ?? _sortBy;
      _sortOrder = sortOrder ?? _sortOrder;
    });
    
    _loadProducts(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and Filter Bar (can be customized)
        _buildFilterBar(),
        
        // Product List
        Expanded(
          child: ProductList(
            products: _products,
            isLoading: _isLoading,
            hasMore: _hasMore,
            onLoadMore: () => _loadProducts(),
            onRefresh: () => _loadProducts(reset: true),
            onProductTap: widget.onProductTap,
            onAddToCart: widget.onAddToCart,
            onAddToWishlist: widget.onAddToWishlist,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (query) {
                _updateFilters(searchQuery: query.isEmpty ? null : query);
              },
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Filter Button
          IconButton(
            onPressed: () {
              // Show filter dialog
              _showFilterDialog();
            },
            icon: const Icon(Icons.filter_list),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Sort Button
          IconButton(
            onPressed: () {
              // Show sort dialog
              _showSortDialog();
            },
            icon: const Icon(Icons.sort),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    // Implement filter dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filters'),
        content: const Text('Filter options will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _updateFilters(filters: {});
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showSortDialog() {
    // Implement sort dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sort By'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Name A-Z'),
              onTap: () {
                Navigator.of(context).pop();
                _updateFilters(sortBy: 'name', sortOrder: 'ASC');
              },
            ),
            ListTile(
              title: const Text('Name Z-A'),
              onTap: () {
                Navigator.of(context).pop();
                _updateFilters(sortBy: 'name', sortOrder: 'DESC');
              },
            ),
            ListTile(
              title: const Text('Price Low to High'),
              onTap: () {
                Navigator.of(context).pop();
                _updateFilters(sortBy: 'price', sortOrder: 'ASC');
              },
            ),
            ListTile(
              title: const Text('Price High to Low'),
              onTap: () {
                Navigator.of(context).pop();
                _updateFilters(sortBy: 'price', sortOrder: 'DESC');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

