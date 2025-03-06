import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String? _pickPoint;
  String? _arrivalPoint;
  DateTime _departureDate = DateTime.now();

  final List<String> _locations = [
    'Jakarta',
    'Bandung',
    'Surabaya',
    'Yogyakarta',
    'Bali',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _departureDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _departureDate) {
      setState(() {
        _departureDate = picked;
      });
    }
  }

  void _search() {
    // Implementasi logika pencarian di sini
    print('Pick Point: $_pickPoint');
    print('Arrival Point: $_arrivalPoint');
    print('Departure Date: ${DateFormat('yyyy-MM-dd').format(_departureDate)}');

    // Contoh: Menampilkan dialog hasil pencarian
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hasil Pencarian'),
          content: Text(
              'Pencarian dari $_pickPoint ke $_arrivalPoint pada ${DateFormat('yyyy-MM-dd').format(_departureDate)}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _pickPoint,
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _pickPoint = newValue;
                });
              },
              decoration:
                  const InputDecoration(
                    labelText: 'Titik Keberangkatan',
                    border: OutlineInputBorder(),
                    ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _arrivalPoint,
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _arrivalPoint = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Titik Tujuan',
                border: OutlineInputBorder(),
                ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Keberangkatan',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(DateFormat('yyyy-MM-dd').format(_departureDate)),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _search,
              child: const Text('Cari'),
            ),
          ],
        ),
      ),
    );
  }
}
