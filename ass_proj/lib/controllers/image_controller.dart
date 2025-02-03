
import 'package:ass_proj/models/image_model.dart';

class ImageController {
  final ImageModel model;

  ImageController(this.model);

  void updateImageUrl(String url) {
    model.imageUrl = url;
  }
}