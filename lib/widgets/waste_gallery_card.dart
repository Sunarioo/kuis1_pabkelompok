
import 'package:flutter/material.dart';
import '../models/waste_data.dart';

class WasteGalleryCard extends StatelessWidget {
  final WasteData waste;
  final bool selected;
  final VoidCallback onTap;

  const WasteGalleryCard({
    super.key,
    required this.waste,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 112,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected
              ? waste.color.withOpacity(0.13)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? waste.color
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 64,
              width: double.infinity,
              decoration: BoxDecoration(
                color: waste.color.withOpacity(0.16),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                waste.icon,
                color: waste.color,
                size: 34,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              waste.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '${waste.pointsPerKg} poin/kg',
              style: TextStyle(
                fontSize: 11,
                color: waste.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
