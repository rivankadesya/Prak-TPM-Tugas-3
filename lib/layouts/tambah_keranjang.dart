import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/keranjang.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print('Form validated');
    } else {
      print('Form not validated');
      return;
    }
  }

  late List<List<String>> items = [];
  late String title;
  late String description;
  bool? _isFirstItemSelected = false;
  bool? _isSecondItemSelected = false;
  String titleItem1 = "Soto";
  String titleItem2 = "Nasi Goreng";
  String titleItem3 = "Bubur Ayam";
  String price1 = "Rp10.000";
  String price2 = "Rp13.0000";
  String price3 = "Rp11.000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheckboxListTile(
                  title: Text(titleItem1),
                  subtitle: Text(price1),
                  value: _isFirstItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFirstItemSelected = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(titleItem2),
                  subtitle: Text(price2),
                  value: _isSecondItemSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSecondItemSelected = value;
                    });
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                    onPressed: () {
                      validated();
                    },
                    child: const Text('Tambah ke Keranjang'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Item> todobox = Hive.box<Item>('items');
    if (_isFirstItemSelected == true) {
      items.add([titleItem1, price1]);
      _isFirstItemSelected = false;
    }
    if (_isSecondItemSelected == true) {
      items.add([titleItem2, price2]);
      _isSecondItemSelected = false;
    }
    items.forEach((item) {
      todobox.add(Item(title: item[0], description: item[1]));
    });
    SnackBar snackBar = const SnackBar(content: Text("Ditambahkan ke Keranjang"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(todobox);
  }
}
