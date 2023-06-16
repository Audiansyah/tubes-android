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

  @override
  void initState() {
    super.initState();
    _laundryFuture = _fetchLaundryList();
  }

  Future<List<Laundry>> _fetchLaundryList() async {
    try {
      final response = await http.get(Uri.parse(
          'https://s3-id-jkt-1.kilatstorage.id/d3si-telu/audiansyah/tempatlaundry.json'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => Laundry.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal memuat data: $e');
    }
  }

  void _onLaundrySelected(Laundry selectedLaundry) {
    print('Tempat Laundry Terpilih:');
    print('Nama: ${selectedLaundry.nama}');
    print('Alamat: ${selectedLaundry.alamat}');
    print('Kontak: ${selectedLaundry.kontak}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilihan Tempat Laundry'),
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
          FutureBuilder<List<Laundry>>(
            future: _laundryFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Gagal memuat data');
              } else if (snapshot.hasData) {
                List<Laundry> laundryList = snapshot.data!;
                if (laundryList.isEmpty) {
                  return Text('Tidak ada data tempat laundry');
                }
                return ListView.builder(
                  itemCount: laundryList.length,
                  itemBuilder: (context, index) {
                    Laundry laundry = laundryList[index];
                    return ListTile(
                      title: Text(laundry.nama),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(laundry.alamat),
                          Text(laundry.kontak),
                        ],
                      ),
                      onTap: () {
                        _onLaundrySelected(laundry);
                      },
                    );
                  },
                );
              } else {
                return Text('Tidak ada data tempat laundry');
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
  final String nama;
  final String alamat;
  final String kontak;

  Laundry({
    required this.nama,
    required this.alamat,
    required this.kontak,
  });

  factory Laundry.fromJson(Map<String, dynamic> json) {
    return Laundry(
      nama: json['Nama'],
      alamat: json['Alamat'],
      kontak: json['Kontak'],
    );
  }
}
