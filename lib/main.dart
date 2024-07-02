import 'package:flutter/material.dart';
import 'package:tarea6/NavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarea 6 (Couteau)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToolboxHomePage(),
    );
  }
}

class ToolboxHomePage extends StatelessWidget {
  const ToolboxHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tarea 6',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 109, 56, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Ir a herramientas'),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: GestureDetector(
                // onTap: () {
                //   Scaffold.of(context).openDrawer();
                // },
                child: Image.asset(
                  'assets/herramientas.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavBar(),
    );
  }
}
