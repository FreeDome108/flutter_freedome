import 'package:flutter/material.dart';

/// Enhanced search bar with Material Design 3 styling
/// Includes advanced filtering options for tax lien marketplace
class EnhancedSearchBar extends StatefulWidget {
  final String? initialQuery;
  final Function(String)? onSearchChanged;
  final Function(String)? onSearchSubmitted;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSortTap;
  final bool showFilters;
  final bool showSort;
  final int? activeFilterCount;
  final String? currentSortOption;

  const EnhancedSearchBar({
    super.key,
    this.initialQuery,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onFilterTap,
    this.onSortTap,
    this.showFilters = true,
    this.showSort = true,
    this.activeFilterCount,
    this.currentSortOption,
  });

  @override
  State<EnhancedSearchBar> createState() => _EnhancedSearchBarState();
}

class _EnhancedSearchBarState extends State<EnhancedSearchBar>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _searchFocusNode = FocusNode();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isSearchFocused = _searchFocusNode.hasFocus;
    });

    if (_isSearchFocused) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
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
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withValues(0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Main Search Row
                Row(
                  children: [
                    // Search Field
                    Expanded(
                      child: _buildSearchField(theme, colorScheme),
                    ),

                    const SizedBox(width: 12),

                    // Filter Button
                    if (widget.showFilters)
                      _buildFilterButton(theme, colorScheme),

                    const SizedBox(width: 8),

                    // Sort Button
                    if (widget.showSort) _buildSortButton(theme, colorScheme),
                  ],
                ),

                // Quick Filters (when search is focused)
                if (_isSearchFocused) ...[
                  const SizedBox(height: 12),
                  _buildQuickFilters(theme, colorScheme),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isSearchFocused
              ? colorScheme.primary
              : colorScheme.outline.withValues(0.3),
          width: _isSearchFocused ? 2 : 1,
        ),
        color: colorScheme.surface,
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        onChanged: widget.onSearchChanged,
        onSubmitted: widget.onSearchSubmitted,
        decoration: InputDecoration(
          hintText: 'Search tax liens, properties, counties...',
          hintStyle: TextStyle(
            color: colorScheme.onSurface.withValues(0.6),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: _isSearchFocused
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(0.6),
            size: 20,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    widget.onSearchChanged?.call('');
                  },
                  icon: Icon(
                    Icons.clear,
                    color: colorScheme.onSurface.withValues(0.6),
                    size: 18,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildFilterButton(ThemeData theme, ColorScheme colorScheme) {
    final hasActiveFilters =
        widget.activeFilterCount != null && widget.activeFilterCount! > 0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasActiveFilters
              ? colorScheme.primary
              : colorScheme.outline.withValues(0.3),
          width: hasActiveFilters ? 2 : 1,
        ),
        color: hasActiveFilters
            ? colorScheme.primaryContainer
            : colorScheme.surface,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onFilterTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                Icon(
                  Icons.tune,
                  color: hasActiveFilters
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface.withValues(0.7),
                  size: 20,
                ),
                if (hasActiveFilters)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          widget.activeFilterCount.toString(),
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortButton(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(0.3),
          width: 1,
        ),
        color: colorScheme.surface,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onSortTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.sort,
              color: colorScheme.onSurface.withValues(0.7),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickFilters(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildQuickFilterChip(
            label: 'Low Risk',
            color: Colors.green,
            theme: theme,
            colorScheme: colorScheme,
          ),
          const SizedBox(width: 8),
          _buildQuickFilterChip(
            label: 'High Interest',
            color: Colors.orange,
            theme: theme,
            colorScheme: colorScheme,
          ),
          const SizedBox(width: 8),
          _buildQuickFilterChip(
            label: 'Near Me',
            color: Colors.blue,
            theme: theme,
            colorScheme: colorScheme,
          ),
          const SizedBox(width: 8),
          _buildQuickFilterChip(
            label: 'Under \$10K',
            color: Colors.purple,
            theme: theme,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilterChip({
    required String label,
    required Color color,
    required ThemeData theme,
    required ColorScheme colorScheme,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(0.3),
          width: 1,
        ),
        color: color.withValues(0.1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle quick filter tap
            _searchController.text = label;
            widget.onSearchChanged?.call(label);
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: color,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Advanced filter dialog for tax lien marketplace
class TaxLienFilterDialog extends StatefulWidget {
  final Map<String, dynamic>? initialFilters;
  final Function(Map<String, dynamic>) onFiltersChanged;

  const TaxLienFilterDialog({
    super.key,
    this.initialFilters,
    required this.onFiltersChanged,
  });

  @override
  State<TaxLienFilterDialog> createState() => _TaxLienFilterDialogState();
}

class _TaxLienFilterDialogState extends State<TaxLienFilterDialog> {
  late Map<String, dynamic> _filters;
  late RangeValues _priceRange;
  late RangeValues _interestRange;
  String? _selectedRiskLevel;
  String? _selectedCounty;
  bool _inStockOnly = false;

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.initialFilters ?? {});
    _priceRange = RangeValues(
      _filters['min_price']?.toDouble() ?? 0,
      _filters['max_price']?.toDouble() ?? 100000,
    );
    _interestRange = RangeValues(
      _filters['min_interest']?.toDouble() ?? 0,
      _filters['max_interest']?.toDouble() ?? 25,
    );
    _selectedRiskLevel = _filters['risk_level'];
    _selectedCounty = _filters['county'];
    _inStockOnly = _filters['in_stock_only'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Filter Tax Liens',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            // Filter Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Range
                    _buildPriceRangeFilter(theme, colorScheme),

                    const SizedBox(height: 24),

                    // Interest Rate Range
                    _buildInterestRangeFilter(theme, colorScheme),

                    const SizedBox(height: 24),

                    // Risk Level
                    _buildRiskLevelFilter(theme, colorScheme),

                    const SizedBox(height: 24),

                    // County
                    _buildCountyFilter(theme, colorScheme),

                    const SizedBox(height: 24),

                    // Stock Status
                    _buildStockStatusFilter(theme, colorScheme),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline.withValues(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: _clearFilters,
                    child: const Text('Clear All'),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _applyFilters,
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRangeFilter(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 100000,
          divisions: 20,
          labels: RangeLabels(
            '\$${_priceRange.start.round()}',
            '\$${_priceRange.end.round()}',
          ),
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${_priceRange.start.round()}',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              '\$${_priceRange.end.round()}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInterestRangeFilter(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interest Rate Range',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        RangeSlider(
          values: _interestRange,
          min: 0,
          max: 25,
          divisions: 25,
          labels: RangeLabels(
            '${_interestRange.start.toStringAsFixed(1)}%',
            '${_interestRange.end.toStringAsFixed(1)}%',
          ),
          onChanged: (values) {
            setState(() {
              _interestRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_interestRange.start.toStringAsFixed(1)}%',
              style: theme.textTheme.bodySmall,
            ),
            Text(
              '${_interestRange.end.toStringAsFixed(1)}%',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRiskLevelFilter(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Risk Level',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['Low', 'Medium', 'High'].map((risk) {
            final isSelected = _selectedRiskLevel == risk;
            return FilterChip(
              label: Text(risk),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedRiskLevel = selected ? risk : null;
                });
              },
              selectedColor: _getRiskColor(risk).withValues(0.2),
              checkmarkColor: _getRiskColor(risk),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCountyFilter(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'County',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _selectedCounty,
          decoration: InputDecoration(
            hintText: 'Select County',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items:
              ['Miami-Dade', 'Broward', 'Palm Beach', 'Orange', 'Hillsborough']
                  .map((county) => DropdownMenuItem(
                        value: county,
                        child: Text(county),
                      ))
                  .toList(),
          onChanged: (value) {
            setState(() {
              _selectedCounty = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildStockStatusFilter(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Checkbox(
          value: _inStockOnly,
          onChanged: (value) {
            setState(() {
              _inStockOnly = value ?? false;
            });
          },
        ),
        const SizedBox(width: 8),
        Text(
          'Show only available tax liens',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Color _getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _clearFilters() {
    setState(() {
      _filters.clear();
      _priceRange = const RangeValues(0, 100000);
      _interestRange = const RangeValues(0, 25);
      _selectedRiskLevel = null;
      _selectedCounty = null;
      _inStockOnly = false;
    });
  }

  void _applyFilters() {
    final newFilters = <String, dynamic>{
      'min_price': _priceRange.start,
      'max_price': _priceRange.end,
      'min_interest': _interestRange.start,
      'max_interest': _interestRange.end,
      'in_stock_only': _inStockOnly,
    };

    if (_selectedRiskLevel != null) {
      newFilters['risk_level'] = _selectedRiskLevel;
    }

    if (_selectedCounty != null) {
      newFilters['county'] = _selectedCounty;
    }

    widget.onFiltersChanged(newFilters);
    Navigator.of(context).pop();
  }
}
