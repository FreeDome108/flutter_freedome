import 'package:flutter/material.dart';
import '../../../core/models/tax_lien_models.dart';

class SortBottomSheet extends StatelessWidget {
  final SearchCriteria currentSort;
  final Function(SearchCriteria) onApplySort;

  const SortBottomSheet({
    super.key,
    required this.currentSort,
    required this.onApplySort,
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
        child: Text('Sort Bottom Sheet - Coming Soon'),
      ),
    );
  }
}
