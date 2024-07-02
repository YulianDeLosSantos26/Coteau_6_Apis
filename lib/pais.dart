import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tarea6/NavBar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Pais extends StatefulWidget {
  const Pais({Key? key}) : super(key: key);

  @override
  _PaisState createState() => _PaisState();
}

class _PaisState extends State<Pais> {
  TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];

  Future<void> _getUniversities(String country) async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      setState(() {
        _universities = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load universities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitar el debug banner
      home: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text(
            'País',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 109, 56, 255),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _countryController,
                decoration: InputDecoration(
                  labelText: 'Ingrese el país',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _getUniversities(_countryController.text);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                child: const Text('Buscar Universidades',
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              if (_universities.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _universities.map((university) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          university['name'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dominio: ${university['domains']}'),
                            TextButton(
                              onPressed: () async {
                                String url = university['web_pages'][0];
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'No se pudo abrir la URL: $url';
                                }
                              },
                              child: const Text('Página Web'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
