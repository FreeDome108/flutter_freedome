import 'package:flutter/material.dart';
import '../models/product.dart';

/// Enhanced product card with Material Design 3 styling
/// Optimized for tax lien marketplace with modern UI/UX
class EnhancedProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onAddToWishlist;
  final VoidCallback? onQuickView;
  final bool showActions;
  final bool showPrice;
  final bool showStockStatus;
  final bool showTaxLienInfo;
  final double? width;
  final double? height;
  final bool isWishlisted;
  final bool isInCart;

  const EnhancedProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onAddToWishlist,
    this.onQuickView,
    this.showActions = true,
    this.showPrice = true,
    this.showStockStatus = true,
    this.showTaxLienInfo = true,
    this.width,
    this.height,
    this.isWishlisted = false,
    this.isInCart = false,
  });

  @override
  State<EnhancedProductCard> createState() => _EnhancedProductCardState();
}

class _EnhancedProductCardState extends State<EnhancedProductCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Card(
            elevation: 0,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: widget.onTap,
              onTapDown: (_) => _scaleController.forward(),
              onTapUp: (_) => _scaleController.reverse(),
              onTapCancel: () => _scaleController.reverse(),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: widget.width,
                height: widget.height,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image with Overlay Actions
                    Expanded(
                      flex: 3,
                      child: _buildProductImageWithOverlay(theme, colorScheme),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Product Name
                    _buildProductName(theme),
                    
                    const SizedBox(height: 8),
                    
                    // Tax Lien Specific Info
                    if (widget.showTaxLienInfo) _buildTaxLienInfo(theme),
                    
                    const SizedBox(height: 8),
                    
                    // Price Section
                    if (widget.showPrice) _buildPriceSection(theme),
                    
                    const SizedBox(height: 8),
                    
                    // Stock Status
                    if (widget.showStockStatus) _buildStockStatus(theme),
                    
                    const SizedBox(height: 12),
                    
                    // Action Buttons
                    if (widget.showActions) _buildActionButtons(theme, colorScheme),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductImageWithOverlay(ThemeData theme, ColorScheme colorScheme) {
    return Stack(
      children: [
        // Main Product Image
        _buildProductImage(),
        
        // Overlay Actions
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quick View Button
              if (widget.onQuickView != null)
                _buildOverlayButton(
                  icon: Icons.visibility_outlined,
                  onPressed: widget.onQuickView!,
                  colorScheme: colorScheme,
                ),
              
              const SizedBox(width: 4),
              
              // Wishlist Button
              _buildOverlayButton(
                icon: widget.isWishlisted 
                    ? Icons.favorite 
                    : Icons.favorite_border,
                onPressed: widget.onAddToWishlist ?? () {},
                colorScheme: colorScheme,
                isActive: widget.isWishlisted,
              ),
            ],
          ),
        ),
        
        // Discount Badge
        if (widget.product.specialPrice != null && 
            widget.product.specialPrice! < widget.product.price)
          Positioned(
            top: 8,
            left: 8,
            child: _buildDiscountBadge(theme),
          ),
      ],
    );
  }

  Widget _buildOverlayButton({
    required IconData icon,
    required VoidCallback onPressed,
    required ColorScheme colorScheme,
    bool isActive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isActive 
            ? colorScheme.primary 
            : colorScheme.surface.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 18,
          color: isActive 
              ? colorScheme.onPrimary 
              : colorScheme.onSurface,
        ),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    String? imageUrl;
    if (widget.product.images != null && widget.product.images!.isNotEmpty) {
      imageUrl = widget.product.images!.first;
    } else if (widget.product.thumbnail != null) {
      imageUrl = widget.product.thumbnail;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[50],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageUrl != null
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildLoadingImage(loadingProgress);
                },
              )
            : _buildPlaceholderImage(),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 4),
          Text(
            'No Image',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingImage(ImageChunkEvent loadingProgress) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / 
                loadingProgress.expectedTotalBytes!
              : null,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildDiscountBadge(ThemeData theme) {
    final discount = ((widget.product.price - widget.product.specialPrice!) / 
                    widget.product.price * 100).round();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red[500],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '-$discount%',
        style: theme.textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildProductName(ThemeData theme) {
    return Text(
      widget.product.name,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTaxLienInfo(ThemeData theme) {
    // Extract tax lien specific information from custom attributes
    final customAttributes = widget.product.customAttributes ?? {};
    final propertyAddress = customAttributes['property_address'] as String?;
    final county = customAttributes['county'] as String?;
    final interestRate = customAttributes['interest_rate'] as double?;
    final riskLevel = customAttributes['risk_level'] as String?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (propertyAddress != null)
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            text: propertyAddress,
            theme: theme,
            maxLines: 1,
          ),
        if (county != null)
          _buildInfoRow(
            icon: Icons.account_balance_outlined,
            text: county,
            theme: theme,
          ),
        if (interestRate != null)
          _buildInfoRow(
            icon: Icons.trending_up_outlined,
            text: '${interestRate.toStringAsFixed(1)}% APR',
            theme: theme,
            textColor: Colors.green[700],
          ),
        if (riskLevel != null)
          _buildRiskBadge(riskLevel, theme),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    required ThemeData theme,
    int maxLines = 1,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: textColor ?? Colors.grey[700],
                fontSize: 11,
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBadge(String riskLevel, ThemeData theme) {
    Color badgeColor;
    switch (riskLevel.toLowerCase()) {
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
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: badgeColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        riskLevel.toUpperCase(),
        style: theme.textTheme.bodySmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.bold,
          fontSize: 9,
        ),
      ),
    );
  }

  Widget _buildPriceSection(ThemeData theme) {
    return Row(
      children: [
        // Current Price
        Text(
          '\$${widget.product.price.toStringAsFixed(2)}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Special Price (if different)
        if (widget.product.specialPrice != null && 
            widget.product.specialPrice! < widget.product.price)
          Text(
            '\$${widget.product.specialPrice!.toStringAsFixed(2)}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red[600],
            ),
          ),
      ],
    );
  }

  Widget _buildStockStatus(ThemeData theme) {
    final isAvailable = widget.product.isInStock ?? false;
    
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isAvailable ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          isAvailable ? 'Available' : 'Unavailable',
          style: theme.textTheme.bodySmall?.copyWith(
            color: isAvailable ? Colors.green[700] : Colors.red[700],
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
        ),
        if (widget.product.stockQuantity != null)
          Text(
            ' (${widget.product.stockQuantity})',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
              fontSize: 11,
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
          child: FilledButton.icon(
            onPressed: (widget.product.isInStock ?? false) 
                ? widget.onAddToCart 
                : null,
            icon: Icon(
              widget.isInCart ? Icons.check : Icons.shopping_cart_outlined,
              size: 16,
            ),
            label: Text(
              widget.isInCart ? 'In Cart' : 'Add to Cart',
              style: const TextStyle(fontSize: 12),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: widget.isInCart 
                  ? Colors.green 
                  : colorScheme.primary,
              foregroundColor: widget.isInCart 
                  ? Colors.white 
                  : colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
