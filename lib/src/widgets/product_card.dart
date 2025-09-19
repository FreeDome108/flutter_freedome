import 'package:flutter/material.dart';
import '../models/product_models.dart';

/// Enhanced product card widget for Magento products
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onAddToWishlist;
  final bool showActions;
  final bool showPrice;
  final bool showStockStatus;
  final double? width;
  final double? height;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onAddToWishlist,
    this.showActions = true,
    this.showPrice = true,
    this.showStockStatus = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                child: _buildProductImage(),
              ),
              
              const SizedBox(height: 8),
              
              // Product Name
              _buildProductName(theme),
              
              const SizedBox(height: 4),
              
              // Price Section
              if (showPrice) _buildPriceSection(theme),
              
              const SizedBox(height: 4),
              
              // Stock Status
              if (showStockStatus) _buildStockStatus(theme),
              
              const SizedBox(height: 8),
              
              // Action Buttons
              if (showActions) _buildActionButtons(theme, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    String? imageUrl;
    if (product.mediaGalleryEntries != null && 
        product.mediaGalleryEntries!.isNotEmpty) {
      imageUrl = product.mediaGalleryEntries!.first.file;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildLoadingImage(loadingProgress);
                },
              ),
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 48,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildLoadingImage(AsyncSnapshotWidgetBuilder<ImageChunkEvent> loadingProgress) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / 
                loadingProgress.expectedTotalBytes!
              : null,
        ),
      ),
    );
  }

  Widget _buildProductName(ThemeData theme) {
    return Text(
      product.name,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceSection(ThemeData theme) {
    return Row(
      children: [
        // Current Price
        Text(
          '\$${product.currentPrice.toStringAsFixed(2)}',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Original Price (if different)
        if (product.hasSpecialPrice)
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey[600],
            ),
          ),
        
        const Spacer(),
        
        // Discount Badge
        if (product.hasSpecialPrice)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '-${product.discountPercentage.toStringAsFixed(0)}%',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStockStatus(ThemeData theme) {
    final isAvailable = product.isAvailable;
    
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isAvailable ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          isAvailable ? 'In Stock' : 'Out of Stock',
          style: theme.textTheme.bodySmall?.copyWith(
            color: isAvailable ? Colors.green[700] : Colors.red[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        // Add to Cart Button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: product.isAvailable ? onAddToCart : null,
            icon: const Icon(Icons.shopping_cart_outlined, size: 18),
            label: const Text('Add to Cart'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Wishlist Button
        IconButton(
          onPressed: onAddToWishlist,
          icon: const Icon(Icons.favorite_border),
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surfaceVariant,
            foregroundColor: colorScheme.onSurfaceVariant,
            padding: const EdgeInsets.all(8),
          ),
        ),
      ],
    );
  }
}

