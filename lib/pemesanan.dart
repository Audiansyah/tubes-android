import 'package:flutter/material.dart';
import 'package:tubes/bayar.dart';

class LaundryOrderPage extends StatefulWidget {
  @override
  _LaundryOrderPageState createState() => _LaundryOrderPageState();
}

class _LaundryOrderPageState extends State<LaundryOrderPage> {
  int _shirtQuantity = 0;
  int _pantsQuantity = 0;
  int _blanketQuantity = 0;
  double _shirtPrice = 10.0;
  double _pantsPrice = 15.0;
  double _blanketPrice = 20.0;

  void _incrementShirtQuantity() {
    setState(() {
      _shirtQuantity++;
    });
  }

  void _decrementShirtQuantity() {
    if (_shirtQuantity > 0) {
      setState(() {
        _shirtQuantity--;
      });
    }
  }

  void _incrementPantsQuantity() {
    setState(() {
      _pantsQuantity++;
    });
  }

  void _decrementPantsQuantity() {
    if (_pantsQuantity > 0) {
      setState(() {
        _pantsQuantity--;
      });
    }
  }

  void _incrementBlanketQuantity() {
    setState(() {
      _blanketQuantity++;
    });
  }

  void _decrementBlanketQuantity() {
    if (_blanketQuantity > 0) {
      setState(() {
        _blanketQuantity--;
      });
    }
  }

  double _calculateTotalPrice() {
    double total = (_shirtQuantity * _shirtPrice) +
        (_pantsQuantity * _pantsPrice) +
        (_blanketQuantity * _blanketPrice);
    return total;
  }

  void _submitOrder() {
    double totalPrice = _calculateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Laundry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pilih Jumlah:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Baju:',
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementShirtQuantity,
                ),
                Text(
                  '$_shirtQuantity',
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementShirtQuantity,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Celana:',
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementPantsQuantity,
                ),
                Text(
                  '$_pantsQuantity',
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementPantsQuantity,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Selimut:',
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementBlanketQuantity,
                ),
                Text(
                  '$_blanketQuantity',
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementBlanketQuantity,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Total Harga: \$${_calculateTotalPrice()}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage()),
                    );
                  },
                  child: Text('Membuat Order Laundry'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LaundryOrderPage(),
  ));
}
