import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/di/locator.dart';
import 'features/posts/application/post_service.dart';
import 'features/posts/presentation/controllers/post_list_controller.dart';

class KabtourApp extends StatelessWidget {
  const KabtourApp({super.key});

  @override
  Widget build(BuildContext context) {
    final postService = sl<PostService>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostListController(postService)..init()),
      ],
      child: MaterialApp(
        title: 'Kabtour Social (Offline)',
        theme: buildTheme(),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
