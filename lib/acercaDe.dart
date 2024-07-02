import 'package:flutter/material.dart';

class AcercaDe extends StatelessWidget {
  const AcercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Datos Personales',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 109, 56, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/yosoy.jpg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Yulian Rafael De Los Santos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            _buildInfoRow('Nombres:', 'Yulian Rafael'),
            _buildInfoRow('Apellido:', 'De Los Santos'),
            _buildInfoRow('Carrera:', 'Desarrollo de Software'),
            _buildInfoRow('Teléfono:', '809-989-6132'),
            _buildInfoRow('Correo:', '20220592@itla.edu.do'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            content,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
