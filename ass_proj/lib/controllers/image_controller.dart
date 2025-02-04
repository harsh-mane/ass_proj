import 'package:get/get.dart';
import 'package:ass_proj/models/image_model.dart';

/// Controller class for managing image-related operations using GetX.
class ImageController extends GetxController {
  /// Reactive image model.
  final Rx<ImageModel> model = ImageModel().obs;

  /// Updates the image URL in the model.
  ///
  /// [url] is the new URL to be set.
  void updateImageUrl(String url) {
    model.update((val) {
      if (val != null) val.imageUrl = url;
    });
  }
}
