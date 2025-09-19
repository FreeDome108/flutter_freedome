import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/widgets/loading_screen.dart';
import '../../../core/models/tax_lien_models.dart';
import '../widgets/product_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/sort_bottom_sheet.dart';
import '../widgets/search_bar.dart';

/// Marketplace screen showing tax lien investments
class MarketplaceScreen extends ConsumerStatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  ConsumerState<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends ConsumerState<MarketplaceScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(marketplaceProvider.notifier).loadTaxLiens();
    });

    // Setup infinite scroll
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = ref.read(marketplaceProvider);
      if (!state.isLoading && state.taxLiens?.hasNextPage == true) {
        ref.read(marketplaceProvider.notifier).loadNextPage();
      }
    }
  }

  void _onSearch(String query) {
    ref.read(marketplaceProvider.notifier).search(query);
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        currentFilters: ref.read(marketplaceProvider).searchCriteria,
        onApplyFilters: (criteria) {
          ref.read(marketplaceProvider.notifier).applyFilters(criteria);
        },
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SortBottomSheet(
        currentSort: ref.read(marketplaceProvider).searchCriteria,
        onApplySort: (criteria) {
          ref.read(marketplaceProvider.notifier).applyFilters(criteria);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceState = ref.watch(marketplaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: MarketplaceSearchBar(
              controller: _searchController,
              onSearch: _onSearch,
              onFilter: _showFilters,
            ),
          ),

          // Active filters
          if (_hasActiveFilters(marketplaceState.searchCriteria))
            _buildActiveFilters(marketplaceState.searchCriteria),

          // Results count
          if (marketplaceState.taxLiens != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${marketplaceState.taxLiens!.totalCount} investments found',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _showSortOptions,
                    icon: const Icon(Icons.sort, size: 16),
                    label: Text(_getSortLabel(marketplaceState.searchCriteria)),
                  ),
                ],
              ),
            ),

          // Products grid/list
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await ref.read(marketplaceProvider.notifier).loadTaxLiens();
              },
              child: _buildProductsList(marketplaceState),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList(MarketplaceState state) {
    if (state.isLoading && (state.taxLiens?.items.isEmpty ?? true)) {
      return const Center(child: LoadingWidget(message: 'Loading investments...'));
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading investments',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.error!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(marketplaceProvider.notifier).loadTaxLiens();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.taxLiens?.items.isEmpty ?? true) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No investments found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    final items = state.taxLiens!.items;

    if (_isGridView) {
      return GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length + (state.isLoading ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return const SkeletonCard();
          }
          return ProductCard(taxLien: items[index]);
        },
      );
    } else {
      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        itemCount: items.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: LoadingWidget(),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ProductCard(
              taxLien: items[index],
              isListView: true,
            ),
          );
        },
      );
    }
  }

  Widget _buildActiveFilters(SearchCriteria criteria) {
    final activeFilters = <Widget>[];

    if (criteria.state != null) {
      activeFilters.add(_buildFilterChip('State: ${criteria.state}', () {
        _removeFilter('state');
      }));
    }

    if (criteria.county != null) {
      activeFilters.add(_buildFilterChip('County: ${criteria.county}', () {
        _removeFilter('county');
      }));
    }

    if (criteria.propertyType != null) {
      activeFilters.add(_buildFilterChip('Type: ${criteria.propertyType}', () {
        _removeFilter('propertyType');
      }));
    }

    if (criteria.minPrice != null || criteria.maxPrice != null) {
      final priceRange = '${criteria.minPrice?.toStringAsFixed(0) ?? '0'} - ${criteria.maxPrice?.toStringAsFixed(0) ?? '∞'}';
      activeFilters.add(_buildFilterChip('Price: \$$priceRange', () {
        _removeFilter('price');
      }));
    }

    if (criteria.riskLevel != null) {
      activeFilters.add(_buildFilterChip('Risk: ${criteria.riskLevel}', () {
        _removeFilter('riskLevel');
      }));
    }

    if (activeFilters.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: activeFilters,
            ),
          ),
          TextButton(
            onPressed: _clearAllFilters,
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: onRemove,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  bool _hasActiveFilters(SearchCriteria criteria) {
    return criteria.state != null ||
        criteria.county != null ||
        criteria.propertyType != null ||
        criteria.minPrice != null ||
        criteria.maxPrice != null ||
        criteria.riskLevel != null;
  }

  String _getSortLabel(SearchCriteria criteria) {
    if (criteria.sortBy == null) return 'Sort';
    
    final direction = criteria.sortOrder == 'DESC' ? '↓' : '↑';
    switch (criteria.sortBy) {
      case 'price':
        return 'Price $direction';
      case 'interestRate':
        return 'Interest $direction';
      case 'auctionDate':
        return 'Auction Date $direction';
      default:
        return 'Sort';
    }
  }

  void _removeFilter(String filterType) {
    final currentCriteria = ref.read(marketplaceProvider).searchCriteria;
    SearchCriteria newCriteria;

    switch (filterType) {
      case 'state':
        newCriteria = currentCriteria.copyWith(state: null);
        break;
      case 'county':
        newCriteria = currentCriteria.copyWith(county: null);
        break;
      case 'propertyType':
        newCriteria = currentCriteria.copyWith(propertyType: null);
        break;
      case 'price':
        newCriteria = currentCriteria.copyWith(minPrice: null, maxPrice: null);
        break;
      case 'riskLevel':
        newCriteria = currentCriteria.copyWith(riskLevel: null);
        break;
      default:
        return;
    }

    ref.read(marketplaceProvider.notifier).applyFilters(newCriteria);
  }

  void _clearAllFilters() {
    final currentCriteria = ref.read(marketplaceProvider).searchCriteria;
    final clearedCriteria = SearchCriteria(
      query: currentCriteria.query,
      sortBy: currentCriteria.sortBy,
      sortOrder: currentCriteria.sortOrder,
      page: 1,
      pageSize: currentCriteria.pageSize,
    );
    ref.read(marketplaceProvider.notifier).applyFilters(clearedCriteria);
  }
}
