import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../data/post_repository.dart';
import '../domain/media_attachment.dart';
import '../domain/post.dart';
import '../../../services/storage_service.dart';

class PostService {
  final PostRepository _repo;
  final StorageService _storage;
  final _uuid = const Uuid();

  PostService(this._repo, this._storage);

  Future<void> ensureInitialized() async => _repo.init();

  Future<Post> createFromPicker({required String caption, required List<XFile> files}) async {
    final attachments = <MediaAttachment>[];
    for (final f in files) {
      final savedPath = await _storage.saveToAppDir(f);
      attachments.add(MediaAttachment(
        id: _uuid.v4(),
        type: MediaType.image,
        path: savedPath,
        createdAt: DateTime.now(),
      ));
    }
    final post = Post(
      id: _uuid.v4(),
      caption: caption,
      media: attachments,
      createdAt: DateTime.now(),
    );
    await _repo.create(post);
    return post;
  }

  Future<void> updateCaption(String id, String caption) async {
    final all = await _repo.getAll(includeArchived: true);
    final p = all.firstWhere((e) => e.id == id);
    await _repo.update(p.copyWith(caption: caption));
  }

  Future<void> archive(String id) => _repo.setArchived(id, true);
  Future<void> unarchive(String id) => _repo.setArchived(id, false);
  Future<void> delete(String id) => _repo.delete(id);

  Stream<List<Post>> watchAll({bool includeArchived = false}) => _repo.watchAll(includeArchived: includeArchived);
}
