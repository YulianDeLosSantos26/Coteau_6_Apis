import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tarea6/NavBar.dart';

class Genero extends StatefulWidget {
  const Genero({Key? key}) : super(key: key);

  @override
  _GeneroState createState() => _GeneroState();
}

class _GeneroState extends State<Genero> {
  String nombre = '';
  String genero = '';
  Color? color;

  Future<void> predecirGenero() async {
    var response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$nombre'));
    var data = json.decode(response.body);
    setState(() {
      if (data['gender'] == 'male') {
        genero = 'Hombre';
        color = Colors.blue;
      } else if (data['gender'] == 'female') {
        genero = 'Mujer';
        color = Colors.pink;
      } else {
        genero = 'Desconocido';
        color = Colors.grey;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitar el debug banner
      home: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text(
            'Género',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 109, 56, 255),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ingresa un nombre:',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      nombre = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  predecirGenero();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text('Predecir Género',
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 50),
              genero.isNotEmpty
                  ? Text(
                      'El género es: $genero',
                      style: TextStyle(fontSize: 20, color: color),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
