import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea6/NavBar.dart';

class Edad extends StatefulWidget {
  const Edad({Key? key}) : super(key: key);

  @override
  _EdadState createState() => _EdadState();
}

class _EdadState extends State<Edad> {
  String nombre = '';
  int? edad;
  String estado = '';

  Future<void> obtenerEdad(String nombre) async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$nombre'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        edad = data['age'];
        if (edad! <= 25) {
          estado = 'Joven';
        } else if (edad! <= 50) {
          estado = 'Adulto';
        } else {
          estado = 'Anciano';
        }
      });
    } else {
      throw Exception('Failed to load data');
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
            'Edad',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 109, 56, 255),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Digite un nombre',
                  style: TextStyle(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        nombre = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    obtenerEdad(nombre);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text('Obtener Rango de edad',
                      style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                if (edad != null)
                  Column(
                    children: [
                      Text(
                        'Edad: $edad',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Estado: $estado',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      if (estado == 'Joven')
                        Image.asset(
                          'assets/joven.jpg',
                          width: 200,
                          height: 200,
                        ),
                      if (estado == 'Adulto')
                        Image.asset(
                          'assets/adulto.jpg',
                          width: 200,
                          height: 200,
                        ),
                      if (estado == 'Anciano')
                        Image.asset(
                          'assets/anciano.jpg',
                          width: 200,
                          height: 200,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
