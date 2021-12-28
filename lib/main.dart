import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _jsonPost = [];

  Future fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _jsonPost = jsonData;
      });
    } catch (err) {
      print('this the $err error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Flutter'),
          ),
          body: Column(
            children: [
              ListView.builder(
                  itemCount: _jsonPost.length,
                  itemBuilder: (context, index) {
                    final post = _jsonPost[index];
                    return Text(
                        "Title: ${post['title']}\n body: ${post['body']}\n \n");
                  }),
            ],
          )),
    );
  }
}
