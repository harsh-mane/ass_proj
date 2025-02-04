import 'package:get/get.dart';
import 'package:ass_proj/models/url_model.dart';

/// Controller class for managing URL-related operations using GetX.
class UrlController extends GetxController {
  /// Reactive URL model.
  final Rx<UrlModel> urlModel = UrlModel().obs;

  /// Sets the URL in the model.
  void setUrl(String newUrl) {
    urlModel.update((val) {
      if (val != null) val.url = newUrl;
    });
  }

  /// Retrieves the current URL.
  String getUrl() {
    return urlModel.value.url;
  }
}
