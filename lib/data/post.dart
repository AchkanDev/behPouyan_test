import 'package:flutter/services.dart';

class PostImageEntity {
  final String caption;
  final Uint8List image;

  PostImageEntity(this.caption, this.image);
}

class Post {
  final String downloadUrl;
  final String caption;

  Post(this.downloadUrl, this.caption);

  Post.fromJson(Map<String, dynamic> json)
      : downloadUrl = json['downloadUrl'],
        caption = json['caption'];

  Map<String, dynamic> toJson() =>
      {"caption": caption, "downloadUrl": downloadUrl};
}
