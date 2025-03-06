import 'package:app_flutter/pages/home/transaction.dart';
import 'package:app_flutter/pages/settings/setting.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), // Ganti dengan konten Home Anda
    const TransactionPage(), // Ganti dengan konten Likes Anda
    const Center(child: Text("Search")), // Ganti dengan konten Search Anda
    const SettingsPage(), // Halaman Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('Google Bottom Bar'),
      //   automaticallyImplyLeading: false,
      // ),
      body: _pages[_selectedIndex], // Tampilkan halaman berdasarkan indeks
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.input_sharp),
    title: const Text("Transaction"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text("Search"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.teal,
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari penerbangan, hotel, dll.',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),

            // Promosi (Horizontal Scroll)
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Contoh jumlah promosi
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200], // Placeholder color
                    ),
                    child: Center(
                      child: Text('Promosi ${index + 1}'),
                    ),
                  );
                },
              ),
            ),

            // Kategori Utama (Grid)
            ResponsiveAnimatedGridView(),

            // Tambahkan elemen lain seperti rekomendasi, dll.
          ],
        ),
      ),
    );
  }
}

class ResponsiveAnimatedGridView extends StatefulWidget {
  @override
  _ResponsiveAnimatedGridViewState createState() =>
      _ResponsiveAnimatedGridViewState();
}

class _ResponsiveAnimatedGridViewState
    extends State<ResponsiveAnimatedGridView> {
  final List<CategoryItem> _categoryItems = [
    CategoryItem(Icons.flight, 'Penerbangan'),
    CategoryItem(Icons.hotel, 'Hotel'),
    CategoryItem(Icons.train, 'Kereta Api'),
    CategoryItem(Icons.directions_car, 'Sewa Mobil'),
    CategoryItem(Icons.attractions, 'Atraksi'),
    CategoryItem(Icons.event, 'Event'),
    CategoryItem(Icons.restaurant, 'Kuliner'),
    CategoryItem(Icons.more_horiz, 'Lainnya'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 150).floor();
    crossAxisCount = crossAxisCount < 1 ? 1 : crossAxisCount;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      itemCount: _categoryItems.length,
      itemBuilder: (context, index) {
        return _buildAnimatedCategoryItem(_categoryItems[index]);
      },
    );
  }

  Widget _buildAnimatedCategoryItem(CategoryItem item) {
    return AnimatedCategoryItem(item: item);
  }
}

class CategoryItem {
  final IconData icon;
  final String label;

  CategoryItem(this.icon, this.label);
}

class AnimatedCategoryItem extends StatefulWidget {
  final CategoryItem item;

  AnimatedCategoryItem({required this.item});

  @override
  _AnimatedCategoryItemState createState() => _AnimatedCategoryItemState();
}

class _AnimatedCategoryItemState extends State<AnimatedCategoryItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {
          // Tambahkan logika navigasi ke kategori yang dipilih
          print('Kategori ${widget.item.label} diklik');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.grey[200] : Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(widget.item.icon, size: 30),
              const SizedBox(height: 8),
              Text(widget.item.label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
