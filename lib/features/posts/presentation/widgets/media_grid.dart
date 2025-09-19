import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/media_attachment.dart';

class MediaGrid extends StatelessWidget {
  final List<MediaAttachment> media;
  const MediaGrid({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) return const SizedBox.shrink();
    if (media.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(File(media.first.path), fit: BoxFit.cover),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: media.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, i) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(File(media[i].path), fit: BoxFit.cover),
      ),
    );
  }
}
