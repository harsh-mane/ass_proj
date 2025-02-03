import 'package:ass_proj/controllers/image_controller.dart';
import 'package:ass_proj/controllers/url_controller.dart';
import 'package:ass_proj/models/image_model.dart';
import 'package:flutter/material.dart';
import 'image_view.dart';



class UrlInputView extends StatefulWidget {
  const UrlInputView({super.key});

  @override
  UrlInputViewState createState() => UrlInputViewState();
}

class UrlInputViewState extends State<UrlInputView> {
  final TextEditingController _urlController = TextEditingController();
  final UrlController _urlControllerInstance = UrlController();

  void _onSubmit() {
    String url = _urlController.text.trim();
    if (url.isNotEmpty) {
      _urlControllerInstance.setUrl(url);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageView(
            controller: ImageController(ImageModel(imageUrl: url)),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid URL")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("URL Input (MVC)")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: "Enter URL",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
