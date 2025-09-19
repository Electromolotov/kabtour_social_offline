import 'package:hive/hive.dart';
import 'media_attachment.dart';

class Post {
  final String id;
  final String caption;
  final List<MediaAttachment> media;
  final DateTime createdAt;
  final bool archived;

  const Post({
    required this.id,
    required this.caption,
    required this.media,
    required this.createdAt,
    this.archived = false,
  });

  Post copyWith({String? caption, List<MediaAttachment>? media, bool? archived}) => Post(
        id: id,
        caption: caption ?? this.caption,
        media: media ?? this.media,
        createdAt: createdAt,
        archived: archived ?? this.archived,
      );
}

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 12;

  @override
  Post read(BinaryReader reader) {
    final id = reader.readString();
    final caption = reader.readString();
    final mediaLen = reader.readInt();
    final media = List<MediaAttachment>.generate(mediaLen, (i) => reader.read() as MediaAttachment);
    final createdAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final archived = reader.readBool();
    return Post(id: id, caption: caption, media: media, createdAt: createdAt, archived: archived);
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeString(obj.id)
      ..writeString(obj.caption)
      ..writeInt(obj.media.length);
    for (final m in obj.media) {
      writer.write(m);
    }
    writer
      ..writeInt(obj.createdAt.millisecondsSinceEpoch)
      ..writeBool(obj.archived);
  }
}
