import 'package:ass_proj/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js; 


class ImageView extends StatefulWidget {
  final ImageController controller;

  const ImageView({super.key, required this.controller});

  @override
  ImageViewState createState() => ImageViewState();
}

class ImageViewState extends State<ImageView> {
  bool _isFullscreen = false;

  // JavaScript function to toggle fullscreen mode
  void _toggleFullscreen(String imageUrl) {
    if (_isFullscreen) {
      js.context.callMethod('exitFullscreen'); // Exit fullscreen
    } else {
      js.context.callMethod('toggleFullscreen', [imageUrl]); // Enter fullscreen
    }
    setState(() {
      _isFullscreen = !_isFullscreen; // Toggle fullscreen state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            if (_isFullscreen) {
              _toggleFullscreen(widget.controller.model.imageUrl); // Exit fullscreen
            } else {
              Navigator.pop(context); // Navigate back to the previous screen
            }
          },
        ),
      ),
      body: Center(
        child: widget.controller.model.imageUrl.isNotEmpty
            ? GestureDetector(
                onDoubleTap: () => _toggleFullscreen(widget.controller.model.imageUrl),
                child: Image.network(
                  widget.controller.model.imageUrl,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Text('Failed to load image');
                  },
                ),
              )
            : Text('No Image Loaded'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContextMenu(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox; // Get the button's render object
    final Offset buttonOffset = button.localToGlobal(Offset.zero); // Get the button's position
    final RelativeRect position = RelativeRect.fromLTRB(
      buttonOffset.dx, // Left
      buttonOffset.dy - 100, // Top (adjust this value to position the menu above the button)
      buttonOffset.dx + button.size.width, // Right
      buttonOffset.dy + button.size.height, // Bottom
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          value: 'enter_fullscreen',
          child: Text('Enter fullscreen'),
        ),
        PopupMenuItem(
          value: 'exit_fullscreen',
          child: Text('Exit fullscreen'),
        ),
      ],
    ).then((value) {
      if (value == 'enter_fullscreen') {
        _toggleFullscreen(widget.controller.model.imageUrl);
      } else if (value == 'exit_fullscreen') {
        _toggleFullscreen(widget.controller.model.imageUrl); // Exit fullscreen
      }
    });
  }
}