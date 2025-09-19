import 'package:flutter/material.dart';
import '../../domain/post.dart';
import 'media_grid.dart';
import '../../../../utils/formatters.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;
  const PostCard({super.key, required this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(child: Icon(Icons.person)),
                  const SizedBox(width: 8),
                  const Text('You', style: TextStyle(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Text(relativeTime(post.createdAt), style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              MediaGrid(media: post.media),
              const SizedBox(height: 8),
              Text(post.caption),
              if (post.archived)
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text('Archived', style: TextStyle(color: Colors.orange, fontSize: 12)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
