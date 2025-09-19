import 'package:flutter/material.dart';
import 'package:kabtour_social_offline/features/posts/presentation/screens/content_creation_screen.dart';
import 'package:kabtour_social_offline/features/posts/presentation/screens/content_manager_screen.dart';
import 'package:kabtour_social_offline/features/posts/presentation/screens/main_feed_screen.dart';
import 'package:kabtour_social_offline/features/posts/presentation/screens/post_detail_screen.dart';

class AppRoutes {
  static const feed = '/';
  static const create = '/create';
  static const manage = '/manage';
  static const detail = '/detail';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.feed:
      return MaterialPageRoute(builder: (_) => const MainFeedScreen());
    case AppRoutes.create:
      return MaterialPageRoute(builder: (_) => const ContentCreationScreen());
    case AppRoutes.manage:
      return MaterialPageRoute(builder: (_) => const ContentManagerScreen());
    case AppRoutes.detail:
      final id = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => PostDetailScreen(postId: id));
    default:
      return MaterialPageRoute(builder: (_) => const MainFeedScreen());
  }
}
