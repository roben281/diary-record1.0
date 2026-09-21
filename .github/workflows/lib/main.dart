import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const DiaryRecordApp());
}

class DiaryRecordApp extends StatelessWidget {
  const DiaryRecordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diary Record',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0F3F8),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// 1. HALAMAN LOGIN
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_month_rounded, size: 70, color: Colors.redAccent),
                const SizedBox(height: 10),
                const Text('Diary Record', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black80)),
                const Text('PLAN • TRACK • GROW', style: TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 2)),
                const SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: const Icon(Icons.visibility_off_outlined),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainHomeScreen()));
                    },
                    child: const Text('LOGIN ➔', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainHomeScreen()));
                  },
                  child: const Text('Continue as Guest', style: TextStyle(color: Colors.black54)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 2. HALAMAN UTAMA (KALENDER & TIMELINE)
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.calendar_month, color: Colors.redAccent),
            SizedBox(width: 8),
            Text('Diary Record', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.black)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hari yang terencana, hidup yang lebih baik.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            // Card Tanggal
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('MMMM yyyy').format(selectedDate), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),
                        ],
                      )
                    ],
                  ),
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.redAccent, child: Icon(Icons.event, color: Colors.white)),
                    title: Text(DateFormat('EEEE, d MMMM yyyy').format(selectedDate)),
                    subtitle: const Text('4 Kegiatan Tercatat'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Timeline Hari Ini', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // List Timeline
            _buildTimelineItem('07:00', 'Antar anak', 'Sekolah', Colors.redAccent),
            _buildTimelineItem('08:00', 'Makan sarapan', 'Beli pake QRIS BCA (- Rp 5.000)', Colors.green),
            _buildTimelineItem('11:00', 'Bayar order baju', 'Dari SeaBank (- Rp 2.000.000)', Colors.blue),
            _buildTimelineItem('15:30', 'Cek bahan kain', 'Ke pasar', Colors.purple),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNoteScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Kalender'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Keuangan'),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt_outlined), label: 'Catatan'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String time, String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(width: 15),
          CircleAvatar(radius: 5, backgroundColor: color),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}

// 3. HALAMAN TULIS CATATAN (DENGAN EDIT JAM & TANGGAL)
class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  DateTime selectedDateTime = DateTime.now();
  final TextEditingController noteController = TextEditingController();

  // Pick Date
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year, picked.month, picked.day,
          selectedDateTime.hour, selectedDateTime.minute,
        );
      });
    }
  }

  // Pick Time (Bisa ubah jam kegiatan sesuka hati)
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year, selectedDateTime.month, selectedDateTime.day,
          picked.hour, picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tulis Catatan', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.redAccent),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tombol Ubah Tanggal & Jam
            Row(
              children: [
                ActionChip(
                  avatar: const Icon(Icons.calendar_today, size: 16),
                  label: Text(DateFormat('dd MMM yyyy').format(selectedDateTime)),
                  onPressed: _pickDate,
                ),
                const SizedBox(width: 8),
                ActionChip(
                  avatar: const Icon(Icons.access_time, size: 16),
                  label: Text(DateFormat('HH:mm').format(selectedDateTime)),
                  onPressed: _pickTime,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  controller: noteController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Tulis catatan atau transaksi di sini...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Simpan Catatan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

