import 'package:flutter/material.dart';
import 'package:tubes/homelaundry.dart';

void main() {
  runApp(setelahLogin());
}

class setelahLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry Yuk',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laundry Yuk'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context, 'Pemilik');
              },
              child: Text('Masuk sebagai Pemilik'),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context, 'Pemakai Jasa');
              },
              child: Text('Masuk sebagai Pemakai Jasa'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Yakin untuk melanjutkan sebagai $role?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Lanjut'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homeLaundry()));
                _showSnackbar(
                    context, 'Anda memilih untuk melanjutkan sebagai $role');
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
