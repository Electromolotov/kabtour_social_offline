import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kabtour_social_offline/features/posts/data/post_repository.dart';
import 'package:kabtour_social_offline/features/posts/domain/post.dart';

class HivePostRepository implements PostRepository {
  static const _boxName = 'posts_box';
  Box<Post>? _box;
  final _controller = StreamController<List<Post>>.broadcast();

  @override
  Future<void> init() async {
    _box ??= await Hive.openBox<Post>(_boxName);
    _emit();
    _box!.watch().listen((_) => _emit());
  }

  void _emit() {
    final items = _box!.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _controller.add(items);
  }

  @override
  Stream<List<Post>> watchAll({bool includeArchived = false}) =>
      _controller.stream.map((items) => includeArchived ? items : items.where((e) => !e.archived).toList());

  @override
  Future<List<Post>> getAll({bool includeArchived = false}) async {
    final v = _box!.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return includeArchived ? v : v.where((e) => !e.archived).toList();
  }

  @override
  Future<Post?> getById(String id) async => _box!.get(id);

  @override
  Future<void> create(Post post) async => _box!.put(post.id, post);

  @override
  Future<void> update(Post post) async => _box!.put(post.id, post);

  @override
  Future<void> delete(String id) async => _box!.delete(id);

  @override
  Future<void> setArchived(String id, bool archived) async {
    final p = _box!.get(id);
    if (p == null) return;
    await _box!.put(id, p.copyWith(archived: archived));
  }
}
