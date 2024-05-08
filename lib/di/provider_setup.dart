import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/repository/photo_api_repository_impl.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';
import 'package:image_search_app/domain/use_case/get_photos_use_case.dart';
import 'package:image_search_app/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;

//1. Provider 전체 import
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

//2. 다른 클래스에 의존하지 않는 데이터 모델들
List<SingleChildWidget> independentModels = [
  Provider<http.Client>(
    create: (context) => http.Client(),
  ),
];

//3. 다른 클래스에 의존하는 데이터 모델들
List<SingleChildWidget> dependentModels = [
  ProxyProvider<http.Client, PixabayApi>(
    update: (context, client, _) => PixabayApi(client),
  ), // PixabayAPI 객체
  ProxyProvider<PixabayApi, PhotoApiRepository>(
    update: (context, api, _) => PhotoApiRepositoryImpl(api),
  ),
  ProxyProvider<PhotoApiRepository, GetPhotosUseCase>(
    update: (context, repo, _) => GetPhotosUseCase(repo),
  ),
];

//4. ViewModel
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(context.read<GetPhotosUseCase>()),
  ),
];
