import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/models/tax_lien_models.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/services/analytics_service.dart';

/// Product card widget for displaying tax lien investments
class ProductCard extends ConsumerWidget {
  final TaxLien taxLien;
  final bool isListView;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.taxLien,
    this.isListView = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final isInCart = cartState.itemIds.contains(taxLien.sku);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap ?? () => _onTap(context),
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: isListView ? _buildListView(context, ref, isInCart) : _buildGridView(context, ref, isInCart),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, WidgetRef ref, bool isInCart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Property image
        Expanded(
          flex: 3,
          child: _buildImage(context),
        ),
        
        // Content
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property address (title)
                Text(
                  taxLien.property.address,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                
                // Location
                Text(
                  '${taxLien.property.city}, ${taxLien.state}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Price and interest rate
                Row(
                  children: [
                    Text(
                      '\$${taxLien.price.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Spacer(),
                    _buildRiskBadge(context),
                  ],
                ),
                
                const Spacer(),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(context, ref, isInCart),
                    ),
                    const SizedBox(width: 8),
                    _buildWishlistButton(context, ref),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListView(BuildContext context, WidgetRef ref, bool isInCart) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Property image
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            child: SizedBox(
              width: 120,
              height: 120,
              child: _buildImage(context),
            ),
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property address
                Text(
                  taxLien.property.address,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                
                // Location
                Text(
                  '${taxLien.property.city}, ${taxLien.state}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Price and details
                Row(
                  children: [
                    Text(
                      '\$${taxLien.price.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildRiskBadge(context),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Interest rate
                Text(
                  '${taxLien.interestRate}% Interest Rate',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildActionButton(context, ref, isInCart),
                    ),
                    const SizedBox(width: 8),
                    _buildWishlistButton(context, ref),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (taxLien.images.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: taxLien.images.first,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        errorWidget: (context, url, error) => _buildPlaceholderImage(context),
      );
    }
    
    return _buildPlaceholderImage(context);
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Center(
        child: Icon(
          Icons.home,
          size: 48,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildRiskBadge(BuildContext context) {
    Color badgeColor;
    switch (taxLien.risk.level.toLowerCase()) {
      case 'low':
        badgeColor = Colors.green;
        break;
      case 'medium':
        badgeColor = Colors.orange;
        break;
      case 'high':
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: Text(
        '${taxLien.risk.level} Risk',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: badgeColor,
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref, bool isInCart) {
    if (isInCart) {
      return ElevatedButton.icon(
        onPressed: () => _removeFromCart(ref),
        icon: const Icon(Icons.remove_shopping_cart, size: 16),
        label: const Text('Remove'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error,
          foregroundColor: Theme.of(context).colorScheme.onError,
          minimumSize: const Size(0, 36),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: taxLien.isAvailable ? () => _addToCart(ref) : null,
      icon: const Icon(Icons.add_shopping_cart, size: 16),
      label: Text(taxLien.isAvailable ? 'Add to Cart' : 'Unavailable'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 36),
      ),
    );
  }

  Widget _buildWishlistButton(BuildContext context, WidgetRef ref) {
    // TODO: Implement wishlist functionality
    return IconButton(
      onPressed: () => _toggleWishlist(ref),
      icon: const Icon(Icons.favorite_border),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        minimumSize: const Size(36, 36),
      ),
    );
  }

  void _onTap(BuildContext context) {
    AnalyticsService.trackProductView(
      productId: taxLien.id,
      productName: taxLien.name,
      category: taxLien.property.propertyType,
      price: taxLien.price,
    );

    // TODO: Navigate to product detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('View details for ${taxLien.property.address}'),
      ),
    );
  }

  void _addToCart(WidgetRef ref) {
    ref.read(cartProvider.notifier).addToCart(taxLien.sku, 1);
    
    AnalyticsService.trackAddToCart(
      productId: taxLien.id,
      productName: taxLien.name,
      category: taxLien.property.propertyType,
      price: taxLien.price,
      quantity: 1,
    );
  }

  void _removeFromCart(WidgetRef ref) {
    ref.read(cartProvider.notifier).removeFromCart(taxLien.sku);
    
    AnalyticsService.trackRemoveFromCart(
      productId: taxLien.id,
      productName: taxLien.name,
      category: taxLien.property.propertyType,
      price: taxLien.price,
      quantity: 1,
    );
  }

  void _toggleWishlist(WidgetRef ref) {
    // TODO: Implement wishlist functionality
    AnalyticsService.trackAddToWishlist(
      productId: taxLien.id,
      productName: taxLien.name,
      category: taxLien.property.propertyType,
      price: taxLien.price,
    );
  }
}
