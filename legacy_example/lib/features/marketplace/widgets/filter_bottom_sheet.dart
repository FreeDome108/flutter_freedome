import 'package:flutter/material.dart';
import '../../../core/models/tax_lien_models.dart';

class FilterBottomSheet extends StatelessWidget {
  final SearchCriteria currentFilters;
  final Function(SearchCriteria) onApplyFilters;

  const FilterBottomSheet({
    super.key,
    required this.currentFilters,
    required this.onApplyFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Filter Bottom Sheet - Coming Soon'),
      ),
    );
  }
}
