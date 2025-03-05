import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings androidInitialization =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitialization,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onSelectNotification(response);
      },
    );
  }

  void _showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel_id',
      'Default Channel',
      channelDescription: 'This is the default notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'DANA',
      'Ada notifikasi baru untuk Anda!',
      notificationDetails,
      payload: 'DANA_Notification_Payload',
    );
  }

  Future<void> _onSelectNotification(NotificationResponse response) async {
    if (response.payload != null) {
      debugPrint('Notifikasi dibuka dengan payload: ${response.payload}');
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Notifikasi Diterima"),
        content: Text("Ini adalah notifikasi yang Anda pilih."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Tutup"),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    TransactionsScreen(),
    ActivityScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hilangkan tanda panah back
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Padding di sekitar logo
          child: Container(
            width: 40, // Lebar logo
            height: 40, // Tinggi logo
            child: Image.asset(
              'images/avatar.png', // Path ke logo aplikasi
              fit: BoxFit.contain, // Sesuaikan logo dengan ukuran container
            ),
          ),
        ),
        title: Text("DANA"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _showNotification,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Warna saat aktif
        unselectedItemColor: Colors.black, // Warna saat tidak aktif
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Activitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Saldo
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Saldo Anda",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Rp 1.000.000",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(Icons.arrow_upward, "Transfer"),
                    _buildActionButton(Icons.arrow_downward, "Top Up"),
                    _buildActionButton(Icons.qr_code, "QRIS"),
                    _buildActionButton(Icons.more_horiz, "Lainnya"),
                  ],
                ),
              ],
            ),
          ),
          // Bagian Promo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Promo",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Banner Promo",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bagian Menu Cepat
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Menu Cepat",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          // Fungsi untuk menu
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_balance_wallet, size: 40),
                            Text("Menu ${index + 1}")
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Bagian Transaksi Terbaru
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transaksi Terbaru",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.account_balance_wallet),
                      title: Text("Transaksi ${index + 1}"),
                      subtitle: Text("Deskripsi transaksi ${index + 1}"),
                      trailing: Text("Rp 100.000"),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class TransactionsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transaction = [
    {
      'type': 'transfer',
      'title': 'Transfer ke John Doe',
      'amount': '-Rp 500.000',
      'date': '12 Okt 2023',
      'icon': Icons.arrow_upward,
      'color': Colors.red,
    },
    {
      'type': 'topup',
      'title': 'Top Up Saldo',
      'amount': '+Rp 1.000.000',
      'date': '11 Okt 2023',
      'icon': Icons.arrow_downward,
      'color': Colors.green,
    },
    {
      'type': 'purchase',
      'title': 'Pembelian di Toko ABC',
      'amount': '-Rp 200.000',
      'date': '10 Okt 2023',
      'icon': Icons.shopping_cart,
      'color': Colors.orange,
    },
    {
      'type': 'reward',
      'title': 'Hadiah dari DANA',
      'amount': '+Rp 50.000',
      'date': '9 Okt 2023',
      'icon': Icons.card_giftcard,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header dengan filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Aktivitas",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // Aksi saat filter dipilih
                    print("Filter dipilih: $value");
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'all',
                      child: Text("Semua Aktivitas"),
                    ),
                    PopupMenuItem(
                      value: 'income',
                      child: Text("Pemasukan"),
                    ),
                    PopupMenuItem(
                      value: 'expense',
                      child: Text("Pengeluaran"),
                    ),
                  ],
                  child: Icon(Icons.filter_list),
                ),
              ],
            ),
          ),
          // Daftar aktivitas
          Expanded(
            child: ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (context, index) {
                final activity = transaction[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      activity['icon'],
                      color: activity['color'],
                    ),
                    title: Text(activity['title']),
                    subtitle: Text(activity['date']),
                    trailing: Text(
                      activity['amount'],
                      style: TextStyle(
                        color: activity['color'],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  // Dummy data untuk aktivitas
  final List<Map<String, dynamic>> activities = [
    {
      'type': 'transfer',
      'title': 'Transfer ke John Doe',
      'amount': '-Rp 500.000',
      'date': '12 Okt 2023',
      'icon': Icons.arrow_upward,
      'color': Colors.red,
    },
    {
      'type': 'topup',
      'title': 'Top Up Saldo',
      'amount': '+Rp 1.000.000',
      'date': '11 Okt 2023',
      'icon': Icons.arrow_downward,
      'color': Colors.green,
    },
    {
      'type': 'purchase',
      'title': 'Pembelian di Toko ABC',
      'amount': '-Rp 200.000',
      'date': '10 Okt 2023',
      'icon': Icons.shopping_cart,
      'color': Colors.orange,
    },
    {
      'type': 'reward',
      'title': 'Hadiah dari DANA',
      'amount': '+Rp 50.000',
      'date': '9 Okt 2023',
      'icon': Icons.card_giftcard,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header dengan filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Aktivitas",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // Aksi saat filter dipilih
                    print("Filter dipilih: $value");
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'all',
                      child: Text("Semua Aktivitas"),
                    ),
                    PopupMenuItem(
                      value: 'income',
                      child: Text("Pemasukan"),
                    ),
                    PopupMenuItem(
                      value: 'expense',
                      child: Text("Pengeluaran"),
                    ),
                  ],
                  child: Icon(Icons.filter_list),
                ),
              ],
            ),
          ),
          // Daftar aktivitas
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      activity['icon'],
                      color: activity['color'],
                    ),
                    title: Text(activity['title']),
                    subtitle: Text(activity['date']),
                    trailing: Text(
                      activity['amount'],
                      style: TextStyle(
                        color: activity['color'],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hilangkan tanda panah back
        title: Text("Pengaturan"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Bagian Profil
          Card(
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text("Profil Saya"),
              subtitle: Text("Kelola informasi profil Anda"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman profil
                print("Profil Saya diklik");
              },
            ),
          ),
          SizedBox(height: 16),

          // Bagian Keamanan
          Card(
            child: ListTile(
              leading: Icon(Icons.security, color: Colors.green),
              title: Text("Keamanan"),
              subtitle: Text("Atur keamanan akun Anda"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman keamanan
                print("Keamanan diklik");
              },
            ),
          ),
          SizedBox(height: 16),

          // Bagian Notifikasi
          Card(
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.orange),
              title: Text("Notifikasi"),
              subtitle: Text("Kelola notifikasi aplikasi"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman notifikasi
                print("Notifikasi diklik");
              },
            ),
          ),
          SizedBox(height: 16),

          // Bagian Bahasa
          Card(
            child: ListTile(
              leading: Icon(Icons.language, color: Colors.purple),
              title: Text("Bahasa"),
              subtitle: Text("Pilih bahasa aplikasi"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman bahasa
                print("Bahasa diklik");
              },
            ),
          ),
          SizedBox(height: 16),

          // Bagian Bantuan
          Card(
            child: ListTile(
              leading: Icon(Icons.help, color: Colors.red),
              title: Text("Bantuan"),
              subtitle: Text("Dapatkan bantuan dan dukungan"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman bantuan
                print("Bantuan diklik");
              },
            ),
          ),
          SizedBox(height: 16),

          // Bagian Tentang Aplikasi
          Card(
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.blueGrey),
              title: Text("Tentang Aplikasi"),
              subtitle: Text("Versi 1.0.0"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman tentang aplikasi
                print("Tentang Aplikasi diklik");
              },
            ),
          ),
          SizedBox(height: 16),

          // Tombol Logout
          Card(
            color: Colors.red[50], // Warna latar belakang
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Keluar", style: TextStyle(color: Colors.red)),
              onTap: () {
                // Tampilkan dialog konfirmasi logout
                _showLogoutDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Keluar dari Aplikasi"),
        content: Text("Apakah Anda yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              // Logika logout
              Navigator.pushReplacementNamed(context, '/');
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   '/',
              //   (route) => false, // Hapus semua halaman sebelumnya
              // );
              Navigator.of(context).pop();
            },
            child: Text(
              "Keluar",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
