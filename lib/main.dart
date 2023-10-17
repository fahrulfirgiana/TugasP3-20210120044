import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final String apiUrl = "http://10.20.30.184/tugasp3/api/data.php";

  Future<List<dynamic>> _fecthData() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/arvl.png', // Replace with your logo image path
          width: 100, // Adjust the width as needed
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.only(
                top: 10, // Margin atas
                right: 10, // Margin kanan
                left: 10, // Margin kiri
                bottom: 470, // Margin bawah, awalnya 10 (dihapus)
              ),
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 255, 255, 255), // Warna latar belakang Container
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Warna shadow
                    blurRadius: 5, // Besar shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(snapshot.data[index]['avatar']),
                    ),
                    title: Text(snapshot.data[index]['first_name'] +
                        " " +
                        snapshot.data[index]['last_name']),
                    subtitle: Text(snapshot.data[index]['produk']),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
