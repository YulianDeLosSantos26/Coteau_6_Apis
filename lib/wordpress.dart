import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:url_launcher/url_launcher.dart';

class WordPress extends StatefulWidget {
  const WordPress({Key? key}) : super(key: key);

  @override
  _WordPressState createState() => _WordPressState();
}

class _WordPressState extends State<WordPress> {
  final String siteUrl = 'https://crackmagazine.net';
  final String apiUrl = '/wp-json/wp/v2/posts';

  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('$siteUrl$apiUrl'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        posts = data;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  String stripHtml(String htmlString) {
    var document = parse(htmlString);
    return parse(document.body!.text).documentElement!.text;
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crackmagazine',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 109, 56, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.asset(
                'assets/logo.jpg',
                width: 180,
                height: 180,
              ),
            ),
            const SizedBox(height: 20),
            if (posts.isNotEmpty)
              Column(
                children: posts.take(3).map((post) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(8),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            post['title']['rendered'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(stripHtml(post['excerpt']['rendered'])),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _launchInBrowser(post['link']);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: const Color(0xFF9479C1),
                            ),
                            child: const Text(
                              'Visitar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
