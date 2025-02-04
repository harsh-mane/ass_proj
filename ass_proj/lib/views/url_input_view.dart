import 'package:ass_proj/controllers/image_controller.dart';
import 'package:ass_proj/controllers/url_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'image_view.dart';

/// A widget for inputting image URLs.
class UrlInputView extends StatelessWidget {
  final TextEditingController _urlController = TextEditingController();
  final ImageController imageController = Get.put(ImageController());
  final UrlController urlController = Get.put(UrlController());

  UrlInputView({super.key});

  /// Handles URL submission and navigates to [ImageView].
  void _onSubmit(BuildContext context) {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      urlController.setUrl(url);
      imageController.updateImageUrl(url);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImageView()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid URL")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("URL Input (MVC)")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: "Enter URL",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _onSubmit(context),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
