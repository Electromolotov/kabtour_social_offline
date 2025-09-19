import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/post_service.dart';
import '../controllers/post_list_controller.dart';
import '../controllers/post_edit_controller.dart';
import '../../../../core/di/locator.dart';

class ContentManagerScreen extends StatelessWidget {
  const ContentManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = context.watch<PostListController>().posts;
    final edit = PostEditController(sl<PostService>());
    return Scaffold(
      appBar: AppBar(title: const Text('Content Manager')),
      body: list.isEmpty
          ? const Center(child: Text('No content yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: list.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final p = list[i];
                return ListTile(
                  title: Text(p.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(p.archived ? 'Archived' : 'Active'),
                  trailing: PopupMenuButton<String>(
                    onSelected: (v) async {
                      if (v == 'edit') {
                        final newCap = await _showEditDialog(context, p.caption);
                        if (newCap != null) await edit.updateCaption(p.id, newCap);
                      } else if (v == 'archive') {
                        await edit.archive(p.id);
                      } else if (v == 'unarchive') {
                        await edit.unarchive(p.id);
                      } else if (v == 'delete') {
                        await edit.delete(p.id);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit Caption')),
                      if (!p.archived)
                        const PopupMenuItem(value: 'archive', child: Text('Archive'))
                      else
                        const PopupMenuItem(value: 'unarchive', child: Text('Unarchive')),
                      const PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<String?> _showEditDialog(BuildContext context, String current) async {
    final controller = TextEditingController(text: current);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Caption'),
        content: TextField(controller: controller, maxLines: 3),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: const Text('Save')),
        ],
      ),
    );
  }
}
