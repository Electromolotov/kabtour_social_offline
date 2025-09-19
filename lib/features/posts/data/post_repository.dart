import 'package:kabtour_social_offline/features/posts/domain/post.dart';

abstract class PostRepository {
  Future<void> init();

  Stream<List<Post>> watchAll({bool includeArchived = false});
  Future<List<Post>> getAll({bool includeArchived = false});
  Future<Post?> getById(String id);

  Future<void> create(Post post);
  Future<void> update(Post post);
  Future<void> delete(String id);
  Future<void> setArchived(String id, bool archived);
}
