import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tubes/pemesanan.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(pewangi());
}

class pewangi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Pewangi Pakaian',
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
  late Future<List<Pewangi>> _laundryFuture;
  List<bool> _selectedPewangi = [];

  @override
  void initState() {
    super.initState();
    _laundryFuture = _fetchLaundryList();
  }

  Future<List<Pewangi>> _fetchLaundryList() async {
    final response = await http.get(Uri.parse(
        'https://s3-id-jkt-1.kilatstorage.id/d3si-telu/audiansyah/pewangi.json'));
    final data = jsonDecode(response.body);
    print(data);
    if (data.containsKey('pewangi_pakaian')) {
      final pewangi_pakaian = List<Pewangi>.from(
          data['pewangi_pakaian'].map((entry) => Pewangi.fromJson(entry)));

      // Initialize the selected state of pewangi
      _selectedPewangi = List<bool>.filled(pewangi_pakaian.length, false);

      return pewangi_pakaian;
    } else {
      throw Exception('Vouchers data not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilihan Pewangi'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pilih pewangi sesuai selera anda!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder<List<Pewangi>>(
              future: _fetchLaundryList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Text('Gagal memuat data');
                  } else if (snapshot.hasData) {
                    List<Pewangi> pewangi_pakaian = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Merek')),
                          DataColumn(label: Text('Pilih')),
                        ],
                        rows: pewangi_pakaian.asMap().entries.map((entry) {
                          final index = entry.key;
                          final Pewangi pewangi = entry.value;
                          return DataRow(cells: [
                            DataCell(Text(pewangi.nama)),
                            DataCell(Text(pewangi.merek)),
                            DataCell(
                              Checkbox(
                                value: _selectedPewangi[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _selectedPewangi[index] = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    );
                  } else {
                    return Text('Tidak ada data pewangi');
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
                    MaterialPageRoute(builder: (context) => LaundryOrderPage()),
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

class Pewangi {
  final String nama;
  final String merek;

  Pewangi({
    required this.nama,
    required this.merek,
  });

  factory Pewangi.fromJson(Map<String, dynamic> json) {
    return Pewangi(
      nama: json['nama'],
      merek: json['merek'],
    );
  }
}
