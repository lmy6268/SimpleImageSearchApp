import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_search_app/ui/widget/photo_widget.dart';
import '../model/Photo.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController(); //에딧 텍스트의 값을 얻아올 수 있는 Controller
  List<Photo> _photos = [];

  @override
  void dispose() {
    _controller.dispose(); //다 쓰고 나서는 해제 해줘야함
    super.dispose();
  }

  Future<List<Photo>> fetch(String query) async {
    final String url =
        'https://pixabay.com/api/?key=17159641-1bf10cc7b7513d39c89bb809d&q=$query&image_type=photo&pretty=true';
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits']; //아직은 Map 형태
    return hits.map((e) => Photo.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, //가운데 정렬
        title: const Text("이미지 검색앱", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    final photos = await fetch(_controller.text);
                    setState(() {
                      _photos = photos;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 몇 열로 구성하는 지
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (buildContext, index) {
                final Photo photo = _photos[index];
                return PhotoWidget(
                  photo: photo,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
