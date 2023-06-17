import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tubes/fakturpemesanan.dart';
import 'package:tubes/formorder.dart';
import 'package:http/http.dart' as http;

Future<List<Voucher>> fetchVouchers() async {
  final response = await http.get(Uri.parse(
      'https://s3-id-jkt-1.kilatstorage.id/d3si-telu/audiansyah/voucher.json'));
  final data = jsonDecode(response.body);
  print(data);
  if (data.containsKey('voucher')) {
    final vouchers = List<Voucher>.from(
        data['voucher'].map((entry) => Voucher.fromJson(entry)));
    return vouchers;
    //var data = json.decode(response.body);
    //List jsonResponse = data["voucher"] as List;
    //return jsonResponse.map((entry) => new Voucher.fromJson(entry)).toList();
  } else {
    throw Exception('Vouchers data not found');
  }
}

class Voucher {
  final String diskon;
  final String besar;
  final String minimalLaundry;

  const Voucher({
    required this.diskon,
    required this.besar,
    required this.minimalLaundry,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      diskon: json['diskon'] ?? '',
      besar: json['Besar'] ?? '',
      minimalLaundry: json['minimallaundry'] ?? '',
    );
  }
}

void main() {
  runApp(homeLaundry());
}

class homeLaundry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry Yuk',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Voucher>> _vouchersFuture;

  @override
  void initState() {
    super.initState();
    _vouchersFuture = fetchVouchers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laundry Yuk'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Selamat Datang di Laundry Yuk',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Kotak(image: 'lib/assets/katcuci.jpg'),
                  Kotak(image: 'lib/assets/pewangi.jpg'),
                  Kotak(image: 'lib/assets/foto.jpg'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Pesanan anda',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ElectronicInvoice()),
                    );
                  },
                  child: Text(
                    'Pesanan No.1231233 Siap Diambil',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => orderform()),
                    );
                  },
                  child: Text('Membuat Order Laundry'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: FutureBuilder<List<Voucher>>(
                future: _vouchersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return Text('Gagal memuat data');
                    } else if (snapshot.hasData) {
                      List<Voucher> vouchers = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Diskon')),
                            DataColumn(label: Text('Besar Diskon')),
                            DataColumn(label: Text('Minimal Laundry')),
                          ],
                          rows: vouchers.map((voucher) {
                            return DataRow(cells: [
                              DataCell(Text(voucher.diskon)),
                              DataCell(Text(voucher.besar)),
                              DataCell(Text(voucher.minimalLaundry)),
                            ]);
                          }).toList(),
                        ),
                      );
                    } else {
                      return Text('Tidak ada data voucher');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Kotak extends StatelessWidget {
  final String image;

  Kotak({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
