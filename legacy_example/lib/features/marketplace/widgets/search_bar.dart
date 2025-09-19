import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

/// Custom search bar for marketplace
class MarketplaceSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final VoidCallback? onFilter;
  final String? hintText;
  final bool autofocus;

  const MarketplaceSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    this.onFilter,
    this.hintText,
    this.autofocus = false,
  });

  @override
  State<MarketplaceSearchBar> createState() => _MarketplaceSearchBarState();
}

class _MarketplaceSearchBarState extends State<MarketplaceSearchBar> {
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _showClearButton = widget.controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = widget.controller.text.isNotEmpty;
    });
  }

  void _onSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      widget.onSearch(value.trim());
    }
  }

  void _clearSearch() {
    widget.controller.clear();
    widget.onSearch('');
    setState(() {
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              autofocus: widget.autofocus,
              onSubmitted: _onSubmitted,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Search by address, city, or county...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                suffixIcon: _showClearButton
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        onPressed: _clearSearch,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          if (widget.onFilter != null) ...[
            Container(
              width: 1,
              height: 24,
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
            IconButton(
              icon: Icon(
                Icons.tune,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: widget.onFilter,
              tooltip: 'Filters',
            ),
          ],
        ],
      ),
    );
  }
}

/// Search suggestions widget
class SearchSuggestions extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onSuggestionTap;
  final VoidCallback? onClearHistory;

  const SearchSuggestions({
    super.key,
    required this.suggestions,
    required this.onSuggestionTap,
    this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onClearHistory != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Searches',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: onClearHistory,
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ),
          ...suggestions.map((suggestion) => ListTile(
                leading: const Icon(Icons.history),
                title: Text(suggestion),
                trailing: const Icon(Icons.north_west),
                onTap: () => onSuggestionTap(suggestion),
              )),
        ],
      ),
    );
  }
}

/// Search filters chip bar
class SearchFiltersBar extends StatelessWidget {
  final List<SearchFilter> filters;
  final Function(SearchFilter) onFilterToggle;
  final VoidCallback? onClearAll;

  const SearchFiltersBar({
    super.key,
    required this.filters,
    required this.onFilterToggle,
    this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final activeFilters = filters.where((f) => f.isActive).toList();
    
    if (activeFilters.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activeFilters.length,
              itemBuilder: (context, index) {
                final filter = activeFilters[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter.label),
                    selected: filter.isActive,
                    onSelected: (_) => onFilterToggle(filter),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => onFilterToggle(filter),
                  ),
                );
              },
            ),
          ),
          if (onClearAll != null && activeFilters.isNotEmpty)
            TextButton(
              onPressed: onClearAll,
              child: const Text('Clear All'),
            ),
        ],
      ),
    );
  }
}

/// Search filter model
class SearchFilter {
  final String id;
  final String label;
  final String value;
  final bool isActive;

  const SearchFilter({
    required this.id,
    required this.label,
    required this.value,
    required this.isActive,
  });

  SearchFilter copyWith({
    String? id,
    String? label,
    String? value,
    bool? isActive,
  }) {
    return SearchFilter(
      id: id ?? this.id,
      label: label ?? this.label,
      value: value ?? this.value,
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Quick search buttons
class QuickSearchButtons extends StatelessWidget {
  final List<QuickSearchItem> items;
  final Function(String) onQuickSearch;

  const QuickSearchButtons({
    super.key,
    required this.items,
    required this.onQuickSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Search',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return ActionChip(
                avatar: Icon(item.icon, size: 18),
                label: Text(item.label),
                onPressed: () => onQuickSearch(item.query),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Quick search item model
class QuickSearchItem {
  final String label;
  final String query;
  final IconData icon;

  const QuickSearchItem({
    required this.label,
    required this.query,
    required this.icon,
  });
}
