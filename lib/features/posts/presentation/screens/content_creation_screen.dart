import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/di/locator.dart';
import '../../application/post_service.dart';

class ContentCreationScreen extends StatefulWidget {
  const ContentCreationScreen({super.key});

  @override
  State<ContentCreationScreen> createState() => _ContentCreationScreenState();
}

class _ContentCreationScreenState extends State<ContentCreationScreen> {
  final _captionCtrl = TextEditingController();
  final _picker = ImagePicker();
  List<XFile> files = [];
  bool posting = false;

  Future<void> _pickFromGallery() async {
    final res = await _picker.pickMultiImage(imageQuality: 85);
    if (res.isNotEmpty) setState(() => files = res);
  }

  Future<void> _takeFromCamera() async {
    final res = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (res != null) setState(() => files = [res]);
  }

  Future<void> _publish() async {
    if (files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add media.')));
      return;
    }
    setState(() => posting = true);
    try {
      await sl<PostService>().createFromPicker(caption: _captionCtrl.text.trim(), files: files);
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => posting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Content')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(
            controller: _captionCtrl,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Caption', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: [
            ElevatedButton.icon(onPressed: _pickFromGallery, icon: const Icon(Icons.photo_library), label: const Text('From Gallery')),
            ElevatedButton.icon(onPressed: _takeFromCamera, icon: const Icon(Icons.camera_alt), label: const Text('Take Photo')),
          ]),
          const SizedBox(height: 12),
          if (files.isNotEmpty)
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: files.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(files[i].path), width: 120, height: 120, fit: BoxFit.cover),
                ),
              ),
            ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: posting ? null : _publish,
            icon: posting ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.cloud_upload),
            label: const Text('Publish'),
          ),
        ],
      ),
    );
  }
}
