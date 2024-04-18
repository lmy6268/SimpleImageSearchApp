import 'package:flutter/material.dart';
import 'package:image_search_app/data/api.dart';
import 'package:image_search_app/data/photo_provider.dart';
import 'package:image_search_app/ui/widget/photo_widget.dart';
import '../model/Photo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final api = PixabayAPI(); //바람직 하지 않은 방식

  final _controller = TextEditingController(); //에딧 텍스트의 값을 얻아올 수 있는 Controller
  List<Photo> _photos = [];

  @override
  void dispose() {
    _controller.dispose(); //다 쓰고 나서는 해제 해줘야함
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PixabayAPI api = PhotoProvider.of(context).api;
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
                    final photos = await api.fetch(_controller.text);
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
              padding: const EdgeInsets.all(16),
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
                  api: api,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
