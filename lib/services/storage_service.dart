import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final _uuid = const Uuid();

  /// Saves an [XFile] into app documents directory and returns the new file path.
  Future<String> saveToAppDir(XFile file) async {
    final dir = await getApplicationDocumentsDirectory();
    final mediaDir = Directory('${dir.path}/media');
    if (!await mediaDir.exists()) {
      await mediaDir.create(recursive: true);
    }
    final ext = file.name.split('.').last;
    final newPath = '${mediaDir.path}/${_uuid.v4()}.$ext';
    final newFile = await File(file.path).copy(newPath);
    return newFile.path;
  }
}
