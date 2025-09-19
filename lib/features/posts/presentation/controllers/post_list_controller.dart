import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../application/post_service.dart';
import '../../domain/post.dart';

class PostListController extends ChangeNotifier {
  final PostService _service;
  StreamSubscription? _sub;
  List<Post> posts = [];
  bool includeArchived;

  PostListController(this._service, {this.includeArchived = false});

  Future<void> init() async {
    await _service.ensureInitialized();
    _sub = _service.watchAll(includeArchived: includeArchived).listen((data) {
      posts = data;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
