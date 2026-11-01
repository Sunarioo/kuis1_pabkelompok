
import 'package:flutter/material.dart';

import '../models/waste_data.dart';
import '../models/activity_data.dart';
import '../widgets/eco_points_card.dart';
import '../widgets/waste_gallery_card.dart';
import '../widgets/section_title.dart';

class EcoPointScreen extends StatefulWidget {
  const EcoPointScreen({super.key});

  @override
  State<EcoPointScreen> createState() => _EcoPointScreenState();
}

class _EcoPointScreenState extends State<EcoPointScreen> {
  int points = 2500;
  int selectedWasteIndex = 0;
  bool isFavorite = false;

  final List<ActivityData> activities = [
    const ActivityData(
      title: 'Setor Sampah Plastik',
      subtitle: 'Berhasil disetorkan',
      points: 200,
      isCredit: true,
    ),
    const ActivityData(
      title: 'Tukar Voucher Minuman',
      subtitle: 'Penukaran hadiah',
      points: 500,
      isCredit: false,
    ),
  ];

  WasteData get selectedWaste =>
      wasteCategories[selectedWasteIndex];

  // FORM PENYETORAN SAMPAH
  void showPickupForm() {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final weightController = TextEditingController();

    int categoryIndex = selectedWasteIndex;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                22,
                20,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ajukan Setoran Sampah',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: addressController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Alamat Penjemputan',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<int>(
                      value: categoryIndex,
                      decoration: const InputDecoration(
                        labelText: 'Kategori Sampah',
                        border: OutlineInputBorder(),
                      ),
                      items: List.generate(
                        wasteCategories.length,
                        (index) {
                          return DropdownMenuItem(
                            value: index,
                            child: Text(
                              wasteCategories[index].name,
                            ),
                          );
                        },
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            categoryIndex = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: weightController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Berat Sampah (kg)',
                        prefixIcon: Icon(Icons.scale),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Nilai: ${wasteCategories[categoryIndex].pointsPerKg} poin/kg',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final name =
                              nameController.text.trim();

                          final address =
                              addressController.text.trim();

                          final weight = double.tryParse(
                            weightController.text
                                .trim()
                                .replaceAll(',', '.'),
                          );

                          if (name.isEmpty ||
                              address.isEmpty ||
                              weight == null ||
                              weight <= 0) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Mohon lengkapi semua data dengan benar!',
                                ),
                              ),
                            );
                            return;
                          }

                          final waste =
                              wasteCategories[categoryIndex];

                          final earned =
                              (weight * waste.pointsPerKg).round();

                          setState(() {
                            points += earned;

                            activities.insert(
                              0,
                              ActivityData(
                                title: 'Setor ${waste.name}',
                                subtitle:
                                    '$name • $weight kg • Pengajuan simulasi',
                                points: earned,
                                isCredit: true,
                              ),
                            );

                            selectedWasteIndex = categoryIndex;
                          });

                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(this.context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                'Pengajuan berhasil! Estimasi +$earned poin.',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        icon: const Icon(Icons.send),
                        label: const Text(
                          'Kirim Pengajuan',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      nameController.dispose();
      addressController.dispose();
      weightController.dispose();
    });
  }

  // FITUR PENUKARAN HADIAH
  void showRewards() {
    final rewards = [
      {
        'name': 'Voucher Rp5.000',
        'cost': 500,
        'icon': Icons.local_cafe,
      },
      {
        'name': 'Voucher Rp10.000',
        'cost': 1000,
        'icon': Icons.shopping_bag,
      },
      {
        'name': 'Paket Kebutuhan Harian',
        'cost': 2000,
        'icon': Icons.inventory_2,
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tukar Eco-Points',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Saldo kamu: $points poin',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ...rewards.map((reward) {
                    final cost = reward['cost'] as int;

                    return Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.card_giftcard),
                        ),
                        title: Text(
                          reward['name'] as String,
                        ),
                        subtitle: Text('$cost poin'),
                        trailing: ElevatedButton(
                          onPressed: points >= cost
                              ? () {
                                  setState(() {
                                    points -= cost;

                                    activities.insert(
                                      0,
                                      ActivityData(
                                        title:
                                            'Tukar ${reward['name']}',
                                        subtitle:
                                            'Hadiah berhasil ditukar',
                                        points: cost,
                                        isCredit: false,
                                      ),
                                    );
                                  });

                                  setSheetState(() {});

                                  ScaffoldMessenger.of(
                                    this.context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Hadiah berhasil ditukarkan!',
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: const Text('Tukar'),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.eco,
              color: Colors.green,
            ),
            SizedBox(width: 8),
            Text(
              'EcoPoint',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Belum ada notifikasi baru.'),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // HEADER
          const Text(
            'Halo, Sahabat Bumi! 👋',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Sampah terpilah, jadi lebih bernilai.',
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 18),

          // ECO POINTS
          EcoPointsCard(
            points: points,
            onTap: showRewards,
          ),

          const SizedBox(height: 22),

          // GALERI KATEGORI
          const SectionTitle(
            title: 'Pilih Kategori Sampah',
          ),

          const Text(
            'Klik kategori untuk melihat informasi sampah.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 132,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: wasteCategories.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return WasteGalleryCard(
                  waste: wasteCategories[index],
                  selected: selectedWasteIndex == index,
                  onTap: () {
                    setState(() {
                      selectedWasteIndex = index;
                      isFavorite = false;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 18),

          // DETAIL KATEGORI
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Container(
              key: ValueKey(selectedWaste.name),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 125,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: selectedWaste.color.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      selectedWaste.icon,
                      color: selectedWaste.color,
                      size: 70,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedWaste.name,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  Text(selectedWaste.description),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.stars,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${selectedWaste.pointsPerKg} Eco-Points / kg',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Contoh material: ${selectedWaste.name}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // TOMBOL SETOR
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: showPickupForm,
              icon: const Icon(Icons.local_shipping),
              label: const Text('Setor / Jemput Sampah'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // RIWAYAT
          SectionTitle(
            title: 'Riwayat Aktivitas',
            actionLabel: 'Tukar Poin',
            onAction: showRewards,
          ),

          ...activities.take(5).map((activity) {
            return Card(
              color: Colors.white,
              elevation: 0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(
                    activity.isCredit
                        ? Icons.recycling
                        : Icons.card_giftcard,
                    color: Colors.green,
                  ),
                ),
                title: Text(activity.title),
                subtitle: Text(
                  activity.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  '${activity.isCredit ? '+' : '-'}${activity.points}',
                  style: TextStyle(
                    color: activity.isCredit
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
