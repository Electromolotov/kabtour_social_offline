import 'package:get_it/get_it.dart';
import 'package:kabtour_social_offline/features/posts/data/hive_post_repository.dart';
import 'package:kabtour_social_offline/features/posts/data/post_repository.dart';
import 'package:kabtour_social_offline/features/posts/application/post_service.dart';
import 'package:kabtour_social_offline/services/storage_service.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Services
  sl.registerLazySingleton<StorageService>(() => StorageService());

  // Repositories
  sl.registerLazySingleton<PostRepository>(() => HivePostRepository());

  // Use cases / Application services
  sl.registerLazySingleton<PostService>(() => PostService(sl<PostRepository>(), sl<StorageService>()));
}
