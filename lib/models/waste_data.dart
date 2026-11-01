
import 'package:flutter/material.dart';

class WasteData {
  final String name;
  final String description;
  final int pointsPerKg;
  final IconData icon;
  final Color color;

  const WasteData({
    required this.name,
    required this.description,
    required this.pointsPerKg,
    required this.icon,
    required this.color,
  });
}

const List<WasteData> wasteCategories = [
  WasteData(
    name: 'Plastik',
    description: 'Botol dan kemasan plastik.',
    pointsPerKg: 100,
    icon: Icons.local_drink,
    color: Colors.green,
  ),
  WasteData(
    name: 'Kertas',
    description: 'Kardus, koran, dan kertas bekas.',
    pointsPerKg: 80,
    icon: Icons.description,
    color: Colors.orange,
  ),
  WasteData(
    name: 'Kaca',
    description: 'Botol dan wadah kaca.',
    pointsPerKg: 120,
    icon: Icons.wine_bar,
    color: Colors.blue,
  ),
  WasteData(
    name: 'Logam',
    description: 'Kaleng dan logam bekas.',
    pointsPerKg: 150,
    icon: Icons.build,
    color: Colors.grey,
  ),
];
