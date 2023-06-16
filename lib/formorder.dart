import 'package:flutter/material.dart';
import 'package:tubes/tempatlaundry.dart';

void main() {
  runApp(orderform());
}

class orderform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Data Diri',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FormDataDiriPage(),
    );
  }
}

class FormDataDiriPage extends StatefulWidget {
  @override
  _FormDataDiriPageState createState() => _FormDataDiriPageState();
}

class _FormDataDiriPageState extends State<FormDataDiriPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String phoneNumber = _phoneNumberController.text;
      String address = _addressController.text;

      // Lakukan sesuatu dengan data yang diisi, misalnya simpan ke database

      // Tampilkan snackbar sebagai umpan balik
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data diri berhasil disimpan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isi Data Diri anda'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Silakan masukkan nama';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Nomor Handphone'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Silakan masukkan nomor handphone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Silakan masukkan alamat';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Simpan'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => tempatlaundry()));
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
