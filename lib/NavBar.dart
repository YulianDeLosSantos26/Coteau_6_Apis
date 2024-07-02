import 'package:flutter/material.dart';
import 'package:tarea6/acercaDe.dart';
import 'package:tarea6/clima.dart';
import 'package:tarea6/edad.dart';
import 'package:tarea6/genero.dart';
import 'package:tarea6/main.dart';
import 'package:tarea6/pais.dart';
import 'package:tarea6/wordpress.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Yulian Rafael De Los Santos'),
            accountEmail: const Text('20220592@itla.edu.do'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/yosoy.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/fondito.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Caja de Herramientas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ToolboxHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.face),
            title: const Text('Género'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Genero()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.psychology_alt),
            title: const Text('Edad'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Edad()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('País'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Pais()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Clima'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Clima()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.web),
            title: const Text('WordPress'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WordPress()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text('Acerca De'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AcercaDe()),
              );
            },
          ),
        ],
      ),
    );
  }
}
