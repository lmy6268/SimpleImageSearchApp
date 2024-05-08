import 'package:flutter/material.dart';
import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/repository/photo_api_repository_impl.dart';
import 'package:image_search_app/domain/use_case/get_photos_use_case.dart';
import 'package:image_search_app/presentation/home/home_screen.dart';
import 'package:image_search_app/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PhotoApiRepositoryImpl impl = PhotoApiRepositoryImpl(
      PixabayApi(http.Client()),
    );
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ChangeNotifierProvider(
          //생성 -> 생성 으로 연결되어야 각각의 객체를 테스트하기 편하다.
          create: (_) => HomeViewModel(GetPhotosUseCase(impl)),
          child: const HomeScreen(),
        ));
  }
}
