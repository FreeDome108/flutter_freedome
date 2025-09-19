import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

/// Category card widget for displaying property categories
class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String count;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                count,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Horizontal scrollable category section
class CategorySection extends StatelessWidget {
  final List<CategoryData> categories;
  final Function(String) onCategorySelected;

  const CategorySection({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Property Categories',
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
          height: 140,
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
                  title: category.title,
                  icon: category.icon,
                  color: category.color,
                  count: category.count,
                  onTap: () => onCategorySelected(category.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Category data model
class CategoryData {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final String count;

  const CategoryData({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.count,
  });
}

/// Grid view of categories
class CategoryGrid extends StatelessWidget {
  final List<CategoryData> categories;
  final Function(String) onCategorySelected;
  final int crossAxisCount;

  const CategoryGrid({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryCard(
          title: category.title,
          icon: category.icon,
          color: category.color,
          count: category.count,
          onTap: () => onCategorySelected(category.id),
        );
      },
    );
  }
}

/// Expandable category list item
class ExpandableCategoryItem extends StatefulWidget {
  final CategoryData category;
  final List<CategoryData> subcategories;
  final Function(String) onCategorySelected;

  const ExpandableCategoryItem({
    super.key,
    required this.category,
    required this.subcategories,
    required this.onCategorySelected,
  });

  @override
  State<ExpandableCategoryItem> createState() => _ExpandableCategoryItemState();
}

class _ExpandableCategoryItemState extends State<ExpandableCategoryItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 4,
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.category.icon,
                color: widget.category.color,
                size: 24,
              ),
            ),
            title: Text(
              widget.category.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text('${widget.category.count} properties'),
            trailing: widget.subcategories.isNotEmpty
                ? AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value * 3.14159,
                        child: const Icon(Icons.expand_more),
                      );
                    },
                  )
                : null,
            onTap: widget.subcategories.isNotEmpty
                ? _toggleExpanded
                : () => widget.onCategorySelected(widget.category.id),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _isExpanded ? widget.subcategories.length * 56.0 : 0,
            child: _isExpanded
                ? Column(
                    children: widget.subcategories.map((subcategory) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(left: 72, right: 16),
                        title: Text(subcategory.title),
                        subtitle: Text('${subcategory.count} properties'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => widget.onCategorySelected(subcategory.id),
                      );
                    }).toList(),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
