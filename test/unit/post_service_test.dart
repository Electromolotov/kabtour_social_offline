import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kabtour_social_offline/features/posts/application/post_service.dart';
import 'package:kabtour_social_offline/features/posts/data/hive_post_repository.dart';
import 'package:kabtour_social_offline/features/posts/data/post_repository.dart';
import 'package:kabtour_social_offline/features/posts/data/local_adapters.dart';
import 'package:kabtour_social_offline/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class _FakeStorage extends StorageService {
  @override
  Future<String> saveToAppDir(XFile file) async {
    // do not actually copy in tests; just return original
    return file.path;
  }
}

void main() {
  late PostRepository repo;
  late PostService service;

  setUp(() async {
    final temp = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(temp.path);
    await registerHiveAdapters();
    repo = HivePostRepository();
    await repo.init();
    service = PostService(repo, _FakeStorage());
  });

  test('create and archive post', () async {
    final f = XFile('test_resources/sample.jpg');
    final post = await service.createFromPicker(caption: 'hello', files: [f]);
    expect((await repo.getAll()).length, 1);

    await service.archive(post.id);
    final all = await repo.getAll(includeArchived: true);
    expect(all.first.archived, true);
  });
}
