import 'package:flutter/material.dart';
import 'package:image_search_app/ui/home_view_model.dart';
import 'package:image_search_app/ui/widget/photo_widget.dart';
import 'package:provider/provider.dart';

import '../model/photo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController(); //에딧 텍스트의 값을 얻아올 수 있는 Controller

  @override
  void dispose() {
    _controller.dispose(); //다 쓰고 나서는 해제 해줘야함
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final homeViewModel =  Provider.of<HomeViewModel>(context); //옛날 방식
    // 요즘 방식
    // -> 데이터의 변동이 있는지 여부도 확인한다. (지금은 Stream으로 데이터를 제공하고 있어서 watch가 아닌, read로 해도 된다.)
    // final homeViewModel = context.watch<HomeViewModel>();

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
                    //한번만 사용할 떄는 read를 쓰면 된다.
                    context.read<HomeViewModel>().fetch(_controller.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Consumer<HomeViewModel>(
            builder: (_, homeViewModel, child) {
              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: homeViewModel.photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 몇 열로 구성하는 지
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (buildContext, index) {
                    final Photo photo = homeViewModel.photos[index];
                    return PhotoWidget(
                      photo: photo,
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
