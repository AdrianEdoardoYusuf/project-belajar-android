import 'package:flutter/material.dart';
import '../services/gallery_service.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<XFile> _images = [];
  bool _loading = false;
  String? _error;

  Future<void> _pickImages() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final images = await GalleryService.pickImages();
      setState(() {
        _images = images;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galeri Gambar')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : _images.isEmpty
                  ? Center(
                      child: ElevatedButton.icon(
                        onPressed: _pickImages,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Ambil Gambar dari Galeri'),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                            ),
                            itemCount: _images.length,
                            itemBuilder: (context, i) {
                              return Image.file(
                                File(_images[i].path),
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: _pickImages,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Ambil Lagi'),
                          ),
                        ),
                      ],
                    ),
    );
  }
} 