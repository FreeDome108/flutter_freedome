import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  bool _isSearching = false;
  String _selectedCounty = 'Все округа';
  String _selectedPriceRange = 'Любая цена';
  String _selectedInterestRate = 'Любой процент';
  String _selectedPropertyType = 'Любой тип';
  
  final List<String> _counties = [
    'Все округа',
    'Miami-Dade',
    'Broward',
    'Palm Beach',
    'Orange',
    'Hillsborough',
    'Pinellas',
    'Duval',
    'Lee',
    'Polk',
    'Brevard',
  ];

  final List<String> _priceRanges = [
    'Любая цена',
    'До \$1,000',
    '\$1,000 - \$5,000',
    '\$5,000 - \$10,000',
    '\$10,000 - \$25,000',
    '\$25,000 - \$50,000',
    'Более \$50,000',
  ];

  final List<String> _interestRates = [
    'Любой процент',
    'До 5%',
    '5% - 10%',
    '10% - 15%',
    '15% - 20%',
    'Более 20%',
  ];

  final List<String> _propertyTypes = [
    'Любой тип',
    'Жилой дом',
    'Коммерческая недвижимость',
    'Земельный участок',
    'Многоквартирный дом',
    'Промышленная недвижимость',
  ];

  final List<String> _recentSearches = [
    'Miami Beach',
    'Downtown Miami',
    'Coral Gables',
    'Brickell',
    'South Beach',
  ];

  final List<String> _popularSearches = [
    'Beachfront property',
    'Downtown office',
    'Residential home',
    'Commercial space',
    'Investment property',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Поиск',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          
          // Active Filters
          if (_hasActiveFilters()) _buildActiveFilters(),
          
          // Search Results or Suggestions
          Expanded(
            child: _isSearching 
                ? _buildSearchResults()
                : _buildSearchSuggestions(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        onChanged: _onSearchChanged,
        onSubmitted: _onSearchSubmitted,
        decoration: InputDecoration(
          hintText: 'Поиск по адресу, округу или описанию...',
          hintStyle: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.qr_code_scanner,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _scanQRCode,
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        style: GoogleFonts.poppins(
          fontSize: 16,
        ),
      ),
    ).animate().fadeIn().slideY(begin: -0.3);
  }

  Widget _buildActiveFilters() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (_selectedCounty != 'Все округа')
            _buildFilterChip('Округ: $_selectedCounty', () {
              setState(() {
                _selectedCounty = 'Все округа';
              });
            }),
          if (_selectedPriceRange != 'Любая цена')
            _buildFilterChip('Цена: $_selectedPriceRange', () {
              setState(() {
                _selectedPriceRange = 'Любая цена';
              });
            }),
          if (_selectedInterestRate != 'Любой процент')
            _buildFilterChip('Процент: $_selectedInterestRate', () {
              setState(() {
                _selectedInterestRate = 'Любой процент';
              });
            }),
          if (_selectedPropertyType != 'Любой тип')
            _buildFilterChip('Тип: $_selectedPropertyType', () {
              setState(() {
                _selectedPropertyType = 'Любой тип';
              });
            }),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2);
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.close,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            _buildSectionHeader('Недавние поиски'),
            const SizedBox(height: 12),
            _buildSearchList(_recentSearches, Icons.history),
            const SizedBox(height: 24),
          ],

          // Popular Searches
          _buildSectionHeader('Популярные поиски'),
          const SizedBox(height: 12),
          _buildSearchList(_popularSearches, Icons.trending_up),

          const SizedBox(height: 24),

          // Quick Filters
          _buildSectionHeader('Быстрые фильтры'),
          const SizedBox(height: 12),
          _buildQuickFilters(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ).animate().fadeIn().slideX(begin: -0.3);
  }

  Widget _buildSearchList(List<String> searches, IconData icon) {
    return Column(
      children: searches.map((search) {
        return ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          title: Text(
            search,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          onTap: () {
            _searchController.text = search;
            _onSearchSubmitted(search);
          },
        );
      }).toList(),
    );
  }

  Widget _buildQuickFilters() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: [
        _buildQuickFilterCard(
          'Beachfront',
          Icons.beach_access,
          Colors.blue,
          () => _applyQuickFilter('Beachfront'),
        ),
        _buildQuickFilterCard(
          'Downtown',
          Icons.location_city,
          Colors.orange,
          () => _applyQuickFilter('Downtown'),
        ),
        _buildQuickFilterCard(
          'Residential',
          Icons.home,
          Colors.green,
          () => _applyQuickFilter('Residential'),
        ),
        _buildQuickFilterCard(
          'Commercial',
          Icons.business,
          Colors.purple,
          () => _applyQuickFilter('Commercial'),
        ),
      ],
    );
  }

  Widget _buildQuickFilterCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    // Mock search results
    final results = List.generate(10, (index) => {
      'address': '${1234 + index} Main St, Miami, FL',
      'county': 'Miami-Dade',
      'taxAmount': 2500.0 + (index * 500),
      'interestRate': 12.0 + (index * 0.5),
      'propertyType': index % 2 == 0 ? 'Residential' : 'Commercial',
      'image': 'https://picsum.photos/200/150?random=$index',
    });

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return _buildSearchResultCard(result, index);
      },
    );
  }

  Widget _buildSearchResultCard(Map<String, dynamic> result, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to property details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Property Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  result['image'],
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 60,
                      color: Theme.of(context).colorScheme.surface,
                      child: Icon(
                        Icons.home,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              
              // Property Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result['address'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result['county'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildPropertyInfo(
                          '\$${result['taxAmount'].toStringAsFixed(0)}',
                          Icons.attach_money,
                        ),
                        const SizedBox(width: 16),
                        _buildPropertyInfo(
                          '${result['interestRate'].toStringAsFixed(1)}%',
                          Icons.percent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Action Button
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  // TODO: Add to favorites
                },
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.3);
  }

  Widget _buildPropertyInfo(String text, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      _isSearching = value.isNotEmpty;
    });
  }

  void _onSearchSubmitted(String value) {
    if (value.trim().isEmpty) return;
    
    setState(() {
      _isSearching = true;
    });
    
    // TODO: Implement actual search
    print('Searching for: $value');
  }

  void _scanQRCode() {
    // TODO: Implement QR code scanning
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'QR сканер будет добавлен в следующем обновлении',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }

  void _applyQuickFilter(String filter) {
    _searchController.text = filter;
    _onSearchSubmitted(filter);
  }

  bool _hasActiveFilters() {
    return _selectedCounty != 'Все округа' ||
           _selectedPriceRange != 'Любая цена' ||
           _selectedInterestRate != 'Любой процент' ||
           _selectedPropertyType != 'Любой тип';
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFilterBottomSheet(),
    );
  }

  Widget _buildFilterBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Фильтры',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCounty = 'Все округа';
                      _selectedPriceRange = 'Любая цена';
                      _selectedInterestRate = 'Любой процент';
                      _selectedPropertyType = 'Любой тип';
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Сбросить',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Options
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection('Округ', _counties, _selectedCounty, (value) {
                    setState(() {
                      _selectedCounty = value;
                    });
                  }),
                  const SizedBox(height: 24),
                  _buildFilterSection('Ценовой диапазон', _priceRanges, _selectedPriceRange, (value) {
                    setState(() {
                      _selectedPriceRange = value;
                    });
                  }),
                  const SizedBox(height: 24),
                  _buildFilterSection('Процентная ставка', _interestRates, _selectedInterestRate, (value) {
                    setState(() {
                      _selectedInterestRate = value;
                    });
                  }),
                  const SizedBox(height: 24),
                  _buildFilterSection('Тип недвижимости', _propertyTypes, _selectedPropertyType, (value) {
                    setState(() {
                      _selectedPropertyType = value;
                    });
                  }),
                ],
              ),
            ),
          ),
          
          // Apply Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _onSearchSubmitted(_searchController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Применить фильтры',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    String selectedValue,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...options.map((option) => RadioListTile<String>(
          title: Text(
            option,
            style: GoogleFonts.poppins(),
          ),
          value: option,
          groupValue: selectedValue,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          activeColor: Theme.of(context).colorScheme.primary,
        )),
      ],
    );
  }
}
