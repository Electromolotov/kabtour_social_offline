import 'package:hive/hive.dart';
import '../domain/media_attachment.dart';
import '../domain/post.dart';

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(10)) Hive.registerAdapter(MediaTypeAdapter());
  if (!Hive.isAdapterRegistered(11)) Hive.registerAdapter(MediaAttachmentAdapter());
  if (!Hive.isAdapterRegistered(12)) Hive.registerAdapter(PostAdapter());
}
