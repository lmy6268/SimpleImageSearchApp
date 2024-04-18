import 'package:flutter/material.dart';
import 'package:image_search_app/data/api.dart';
import '../../model/Photo.dart';

class PhotoWidget extends StatelessWidget {
  final PixabayAPI api;
  const PhotoWidget({
    super.key,
    required this.photo,
    required this.api
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(photo.previewURL), //이미지 주소가 들어갈 공간
        ),
      ),
    );
  }
}
