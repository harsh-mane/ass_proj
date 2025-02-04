import 'package:ass_proj/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:js' as js;
import 'dart:html' as html; // Required for keyboard event handling

/// A widget for displaying an image with fullscreen capabilities.
class ImageView extends StatelessWidget {
  final ImageController controller = Get.find();
  final RxBool isFullscreen = false.obs; // Moved to class level for better access
  final RxBool isMenuOpen = false.obs;

  ImageView({super.key}) {
    // Add keyboard event listener for Esc key
    html.window.addEventListener('keydown', (event) {
      if (event is html.KeyboardEvent && event.key == 'Escape' && isFullscreen.value) {
        _toggleFullscreen(controller.model.value.imageUrl);
      }
    });
  }

  /// Toggles fullscreen mode for the image.
  void _toggleFullscreen(String imageUrl) {
    if (isFullscreen.value) {
      js.context.callMethod('exitFullscreen');
    } else {
      js.context.callMethod('toggleFullscreen', [imageUrl]);
    }
    isFullscreen.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isFullscreen.value) {
              _toggleFullscreen(controller.model.value.imageUrl);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Obx(() => controller.model.value.imageUrl.isNotEmpty
                ? GestureDetector(
                    onDoubleTap: () => _toggleFullscreen(controller.model.value.imageUrl),
                    child: Image.network(
                      controller.model.value.imageUrl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, exception, stackTrace) =>
                          const Text('Failed to load image'),
                    ),
                  )
                : const Text('No Image Loaded')),
          ),
          Obx(() => isMenuOpen.value
              ? GestureDetector(
                  onTap: () => isMenuOpen.value = false,
                  child: Container(
                    color: Colors.black54,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : const SizedBox.shrink()),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                Obx(() => isMenuOpen.value
                    ? Card(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                _toggleFullscreen(controller.model.value.imageUrl);
                                isMenuOpen.value = false;
                              },
                              child: Text(isFullscreen.value ? 'Exit Fullscreen' : 'Enter Fullscreen'),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink()),
                FloatingActionButton(
                  onPressed: () => isMenuOpen.value = !isMenuOpen.value,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
