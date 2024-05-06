import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/home/home_view_model.dart';
import 'package:image_search_app/presentation/home/components/photo_widget.dart';
import 'package:provider/provider.dart';

import '../../domain/model/photo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController(); //에딧 텍스트의 값을 얻아올 수 있는 Controller
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _controller.dispose(); //다 쓰고 나서는 해제 해줘야함
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// [Future.microtask()]
    /// StatefulWidget에서 뷰모델을 가져오는데 약간의 시간이 필요해서, 일정시간의 대기를 가지고 블록 내부의 구문을 실행함.
    Future.microtask(() {
      final viewModel = context.read<HomeViewModel>(); //단발성이라 watch대신 read사용
      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(
          showSnackBar: (message) {
            final snackBar = SnackBar(
              content: Text(message),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar); //스낵바 띄우기
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final homeViewModel =  Provider.of<HomeViewModel>(context); //옛날 방식
    // 요즘 방식
    // -> 데이터의 변동이 있는지 여부도 확인한다. (지금은 Stream으로 데이터를 제공하고 있어서 watch가 아닌, read로 해도 된다.)
    final homeViewModel = context.watch<HomeViewModel>();
    final state = homeViewModel.state;


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
                    homeViewModel.fetch(_controller.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          state.isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 몇 열로 구성하는 지
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (buildContext, index) {
                      final Photo photo = state.photos[index];
                      return PhotoWidget(
                        photo: photo,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
