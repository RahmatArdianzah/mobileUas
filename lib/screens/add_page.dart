import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

//menambahkan data
class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController tittleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //TextEditingController AlamatController = TextEditingController();
  //TextEditingController NimController = TextEditingController();
  bool isView = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isView = true;
      final title = todo['title'];
      tittleController.text = title;
      final description = todo['description'];
      descriptionController.text = description;
      //final alamat = todo['alamat'];
      //AlamatController.text = alamat;
      //final nim = todo['nim'];
      //NimController.text = nim;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isView ? 'View Todo' : 'Tambah Data'),
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          //SizedBox(height: 20),
          TextField(
            controller: tittleController,
            decoration: InputDecoration(hintText: 'Nama'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Kelas'),
            //keyboardType: TextInputType.multiline,
            //minLines: 5,
            //maxLines: 10,
          ),
          //TextField(
          //  controller: NimController,
          //  decoration: InputDecoration(hintText: 'Masukkan Nim'),
          //),
          //TextField(
          //  controller: AlamatController,
          //  decoration: InputDecoration(hintText: 'Tuliskan Alamat'),
          //),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: submitData,
            child: Text('Tambah'),
          )
        ],
      ),
    );
  }

  Future<void> submitData() async {
    //ambil data dari form
    final title = tittleController.text;
    final description = descriptionController.text;
    //final nim = NimController.text;
    //final alamat = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      //"nim": nim,
      //"alamat": alamat,
      "is_completed": false,
    };
    //submit data ke server
    var url = 'https://api.nstack.in/v1/todos';
    var uri = Uri.parse(url);
    var response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    //http.post('https://api.nstack.in/v1/todos');
    //menampilkan status sukses atau tidak
    if (response.statusCode == 201) {
      tittleController.text = '';
      descriptionController.text = '';
      //AlamatController.text = '';
      //NimController.text = '';
      showSuccesMessage('Berhasil Menambahkan');
      //print('Berhasil ditambahkan');
    } else {
      showErrorMessage('Gagal Menambahkan');
    }
  }

  void showSuccesMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
