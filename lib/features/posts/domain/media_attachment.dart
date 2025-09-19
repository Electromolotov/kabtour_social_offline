// Manual Hive adapters; no codegen.
import 'package:hive/hive.dart';

enum MediaType { image }

class MediaAttachment {
  final String id;
  final MediaType type;
  final String path; // local file path persisted
  final DateTime createdAt;

  MediaAttachment({
    required this.id,
    required this.type,
    required this.path,
    required this.createdAt,
  });
}

class MediaTypeAdapter extends TypeAdapter<MediaType> {
  @override
  final int typeId = 10;

  @override
  MediaType read(BinaryReader reader) {
    final v = reader.readByte();
    return MediaType.values[v];
  }

  @override
  void write(BinaryWriter writer, MediaType obj) {
    writer.writeByte(obj.index);
  }
}

class MediaAttachmentAdapter extends TypeAdapter<MediaAttachment> {
  @override
  final int typeId = 11;

  @override
  MediaAttachment read(BinaryReader reader) {
    return MediaAttachment(
      id: reader.readString(),
      type: MediaType.values[reader.readByte()],
      path: reader.readString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, MediaAttachment obj) {
    writer
      ..writeString(obj.id)
      ..writeByte(obj.type.index)
      ..writeString(obj.path)
      ..writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}
