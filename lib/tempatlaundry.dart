import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tubes/pewangi.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(tempatlaundry());
}

class tempatlaundry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pilihan Tempat Laundry',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LaundryListPage(),
    );
  }
}

class LaundryListPage extends StatefulWidget {
  @override
  _LaundryListPageState createState() => _LaundryListPageState();
}

class _LaundryListPageState extends State<LaundryListPage> {
  late Future<List<Laundry>> _laundryFuture;
  List<bool> _selectedLaundry = [];

  @override
  void initState() {
    super.initState();
    _laundryFuture = _fetchLaundryList();
  }

  Future<List<Laundry>> _fetchLaundryList() async {
    final response = await http.get(Uri.parse(
        'https://s3-id-jkt-1.kilatstorage.id/d3si-telu/audiansyah/tempatlaundry.json'));
    final data = jsonDecode(response.body);
    print(data);
    if (data.containsKey('TempatLaundry')) {
      final tempatLaundry = List<Laundry>.from(
          data['TempatLaundry'].map((entry) => Laundry.fromJson(entry)));

      // Initialize the selected state of tempatLaundry
      _selectedLaundry = List<bool>.filled(tempatLaundry.length, false);

      return tempatLaundry;
    } else {
      throw Exception('Vouchers data not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tempat Laundry'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pilih tempat laundry yang andalan anda!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder<List<Laundry>>(
              future: _fetchLaundryList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Text('Gagal memuat data');
                  } else if (snapshot.hasData) {
                    List<Laundry> tempatLaundry = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Alamat')),
                          DataColumn(label: Text('Kontak')),
                          DataColumn(label: Text('Pilih')),
                        ],
                        rows: tempatLaundry.asMap().entries.map((entry) {
                          final index = entry.key;
                          final Laundry laundry = entry.value;
                          return DataRow(cells: [
                            DataCell(Text(laundry.Nama)),
                            DataCell(Text(laundry.Alamat)),
                            DataCell(Text(laundry.Kontak)),
                            DataCell(
                              Checkbox(
                                value: _selectedLaundry[index],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedLaundry[index] = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    );
                  } else {
                    return Text('Tidak ada data tempat laundry');
                  }
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pewangi()),
                  );
                },
                child: Text('Next'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Laundry {
  final String Nama;
  final String Alamat;
  final String Kontak;

  Laundry({
    required this.Nama,
    required this.Alamat,
    required this.Kontak,
  });

  factory Laundry.fromJson(Map<String, dynamic> json) {
    return Laundry(
      Nama: json['Nama'],
      Alamat: json['Alamat'],
      Kontak: json['Kontak'],
    );
  }
}
