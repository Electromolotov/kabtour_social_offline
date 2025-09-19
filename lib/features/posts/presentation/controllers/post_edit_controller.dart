import 'package:flutter/foundation.dart';
import '../../application/post_service.dart';

class PostEditController extends ChangeNotifier {
  final PostService _service;
  PostEditController(this._service);

  Future<void> updateCaption(String id, String caption) => _service.updateCaption(id, caption);
  Future<void> archive(String id) => _service.archive(id);
  Future<void> unarchive(String id) => _service.unarchive(id);
  Future<void> delete(String id) => _service.delete(id);
}
