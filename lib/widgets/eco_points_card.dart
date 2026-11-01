
import 'package:flutter/material.dart';

class EcoPointsCard extends StatelessWidget {
  final int points;
  final VoidCallback onTap;

  const EcoPointsCard({
    super.key,
    required this.points,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF238A5B),
            Color(0xFF145D40),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.eco, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'TOTAL ECO-POINTS',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            points.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            'Poin tersedia',
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onTap,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.card_giftcard),
              label: const Text('Tukar Hadiah'),
            ),
          ),
        ],
      ),
    );
  }
}
