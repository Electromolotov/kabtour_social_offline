import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/app_router.dart';
import '../controllers/post_list_controller.dart';
import '../widgets/post_card.dart';

class MainFeedScreen extends StatelessWidget {
  const MainFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PostListController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kabtour Social'),
        actions: [
          IconButton(
            key: const Key('manageButton'),
            icon: const Icon(Icons.dashboard_rounded),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.manage),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('fabCreate'),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.create),
        icon: const Icon(Icons.add_a_photo),
        label: const Text('Create'),
      ),
      body: vm.posts.isEmpty
          ? const Center(child: Text('No posts yet. Tap Create to add one.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: vm.posts.length,
              itemBuilder: (context, i) => PostCard(
                post: vm.posts[i],
                onTap: () => Navigator.pushNamed(context, AppRoutes.detail, arguments: vm.posts[i].id),
              ),
            ),
    );
  }
}
