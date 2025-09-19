import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/di/locator.dart';
import '../../../posts/application/post_service.dart';
import '../../domain/post.dart';
import '../widgets/media_grid.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  Post? post;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final service = sl<PostService>();
    final all = await service.watchAll(includeArchived: true).first; // initial snapshot
    setState(() {
      post = all.firstWhere((p) => p.id == widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = post;
    if (p == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: const Text('Content Detail')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          MediaGrid(media: p.media),
          const SizedBox(height: 12),
          Text(p.caption, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Text('Created: ${p.createdAt}'),
          if (p.media.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('First file path:'),
            Text(p.media.first.path, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            ElevatedButton.icon(
              onPressed: () => File(p.media.first.path).exists().then((exists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(exists ? 'File exists locally' : 'File not found')),
                );
              }),
              icon: const Icon(Icons.check_circle),
              label: const Text('Verify local file'),
            )
          ],
        ],
      ),
    );
  }
}
