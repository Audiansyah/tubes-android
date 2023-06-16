import 'package:flutter/material.dart';
import 'package:tubes/setelahbayar.dart';

void main() {
  runApp(PaymentPage());
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metode Pembayaran'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Payment Method:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text('Bank Transfer'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Pilih Bank'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('Bank Mandiri'),
                            onTap: () {
                              setState(() {
                                selectedPaymentMethod = 'bank_mandiri';
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                          ListTile(
                            title: Text('Bank BRI'),
                            onTap: () {
                              setState(() {
                                selectedPaymentMethod = 'bank_bri';
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                          ListTile(
                            title: Text('Bank BNI'),
                            onTap: () {
                              setState(() {
                                selectedPaymentMethod = 'bank_bni';
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('Cash on Delivery'),
              onTap: () {
                setState(() {
                  selectedPaymentMethod = 'cash_on_delivery';
                });
              },
            ),
            ListTile(
              title: Text('Other Payment Method'),
              onTap: () {
                setState(() {
                  selectedPaymentMethod = 'other_payment';
                });
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
                      MaterialPageRoute(builder: (context) => LaundryApp()),
                    );
                  },
                  child: Text('Konfirmasi Pembayaran'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
