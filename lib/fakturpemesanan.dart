import 'package:flutter/material.dart';
import 'package:tubes/homelaundry.dart';

void main() {
  runApp(MaterialApp(
    title: 'Electronic Invoice',
    home: ElectronicInvoice(),
  ));
}

class ElectronicInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electronic Invoice'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Laundry Yuk!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Pelanggan Yth,',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Audi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nomor Nota:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '1231233',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Detail pesanan:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Siap Diambil',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Detail biaya :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Total tagihan : Rp33.250',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Layanan express : Rp0',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Grand total : Rp33.250',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Nominal Bayar : Rp33.250',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Kembalian : Rp0',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Sisa Tagihan : Rp0',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Status: lunas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Syarat & ketentuan:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Pembayaran laundry dibayar di awal',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '2. Dengan menerima nota ini customer dinyatakan menyetujui ketentuan Laundry Yuk',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '3. Order, kritik dan saran hubungi : 0821 1212 1123',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Terimakasih',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => homeLaundry()),
                    );
                  },
                  child: Text('Home'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
