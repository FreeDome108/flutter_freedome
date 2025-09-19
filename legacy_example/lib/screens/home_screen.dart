import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../core/providers/app_providers.dart';
import '../core/widgets/loading_screen.dart';
import '../features/marketplace/widgets/product_card.dart';
import '../features/marketplace/widgets/category_section.dart';

/// Home screen showing featured products and categories
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(marketplaceProvider.notifier).loadTaxLiens();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceState = ref.watch(marketplaceProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.account_balance,
                size: 20,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Text(AppConstants.appName),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(marketplaceProvider.notifier).loadTaxLiens();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Welcome section
            SliverToBoxAdapter(
              child: _buildWelcomeSection(context, authState),
            ),
            
            // Quick stats
            SliverToBoxAdapter(
              child: _buildQuickStats(context),
            ),
            
            // Categories section
            SliverToBoxAdapter(
              child: _buildCategoriesSection(context),
            ),
            
            // Featured investments
            SliverToBoxAdapter(
              child: _buildFeaturedSection(context, marketplaceState),
            ),
            
            // Recent listings
            if (marketplaceState.taxLiens != null && marketplaceState.taxLiens!.items.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final taxLien = marketplaceState.taxLiens!.items[index];
                      return ProductCard(taxLien: taxLien);
                    },
                    childCount: marketplaceState.taxLiens!.items.length.clamp(0, 6),
                  ),
                ),
              ),
            
            // Loading state
            if (marketplaceState.isLoading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppConstants.defaultPadding),
                  child: LoadingWidget(message: 'Loading investments...'),
                ),
              ),
            
            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, AuthState authState) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            authState.isAuthenticated 
                ? 'Welcome back, ${authState.customer?.firstname ?? 'Investor'}!'
                : 'Welcome to TaxLien.online',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover profitable tax lien investment opportunities',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to marketplace
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Explore Investments'),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  // TODO: Navigate to learning resources
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Learn More'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.trending_up,
              title: 'Avg. Return',
              value: '12.5%',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.timer,
              title: 'Avg. Duration',
              value: '18 months',
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.show_chart,
              title: 'Success Rate',
              value: '85%',
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final categories = [
      {
        'title': 'Residential',
        'icon': Icons.home,
        'color': Colors.blue,
        'count': '1,234',
      },
      {
        'title': 'Commercial',
        'icon': Icons.business,
        'color': Colors.green,
        'count': '567',
      },
      {
        'title': 'Land',
        'icon': Icons.terrain,
        'color': Colors.orange,
        'count': '890',
      },
      {
        'title': 'Industrial',
        'icon': Icons.factory,
        'color': Colors.purple,
        'count': '234',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Investment Categories',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all categories
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 16),
                child: CategoryCard(
                  title: category['title'] as String,
                  icon: category['icon'] as IconData,
                  color: category['color'] as Color,
                  count: category['count'] as String,
                  onTap: () {
                    // TODO: Navigate to category
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSection(BuildContext context, MarketplaceState marketplaceState) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Investments',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to marketplace
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (marketplaceState.taxLiens != null && marketplaceState.taxLiens!.items.isNotEmpty)
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: marketplaceState.taxLiens!.items.length.clamp(0, 5),
                itemBuilder: (context, index) {
                  final taxLien = marketplaceState.taxLiens!.items[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 16),
                    child: ProductCard(taxLien: taxLien),
                  );
                },
              ),
            )
          else if (marketplaceState.isLoading)
            const LoadingWidget(message: 'Loading featured investments...')
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No investments available',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Check back later for new opportunities',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
