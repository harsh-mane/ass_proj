

import 'package:ass_proj/models/url_model.dart';

class UrlController {
  final UrlModel _urlModel = UrlModel();

  void setUrl(String newUrl) {
    _urlModel.url = newUrl;
  }

  String getUrl() {
    return _urlModel.url;
  }
}