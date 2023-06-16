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
      home: PewangiListPage(),
    );
  }
}

class PewangiListPage extends StatefulWidget {
  @override
  _PewangiListPageState createState() => _PewangiListPageState();
}

class _PewangiListPageState extends State<PewangiListPage> {
  late Future<List<Pewangi>> _pewangiFuture;

  @override
  void initState() {
    super.initState();
    _pewangiFuture = _fetchPewangiList();
  }

  Future<List<Pewangi>> _fetchPewangiList() async {
    try {
      final response = await http.get(Uri.parse(
          'https://s3-id-jkt-1.kilatstorage.id/d3si-telu/audiansyah/pewangi.json'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((item) => Pewangi(
                  name: item['nama'],
                  brand: item['merek'],
                ))
            .toList();
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      throw Exception('Gagal memuat data');
    }
  }

  void _onPewangiSelected(Pewangi selectedPewangi) {
    // Lakukan sesuatu dengan pewangi yang dipilih
    // Misalnya, simpan pewangi terpilih ke dalam variabel atau lakukan navigasi ke halaman berikutnya
    print('Pewangi Terpilih:');
    print('Nama: ${selectedPewangi.name}');
    print('Merek: ${selectedPewangi.brand}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pewangi Pakaian'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Silahkan pilih pewangi sesuai selera anda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<List<Pewangi>>(
            future: _pewangiFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Gagal memuat data');
              } else if (snapshot.hasData) {
                List<Pewangi> pewangiList = snapshot.data!;
                return ListView.builder(
                  itemCount: pewangiList.length,
                  itemBuilder: (context, index) {
                    Pewangi pewangi = pewangiList[index];
                    return ListTile(
                      title: Text(pewangi.name),
                      subtitle: Text(pewangi.brand),
                      onTap: () {
                        _onPewangiSelected(pewangi);
                      },
                    );
                  },
                );
              } else {
                return Text('Tidak ada data pewangi pakaian');
              }
            },
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
  final String name;
  final String brand;

  Pewangi({
    required this.name,
    required this.brand,
  });
}
