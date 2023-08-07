import 'package:beh_pouyan_test/data/dataSource/post_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../post.dart';

final postRepository = PostRepository(PostRemoteDataSource());

abstract class IPostRepository {
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getPosts();
  Future<void> sendPost(Post post);
}

class PostRepository implements IPostRepository {
  final IPostDataSource dataSource;

  PostRepository(this.dataSource);

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getPosts() {
    return dataSource.getPosts();
  }

  @override
  Future<void> sendPost(post) {
    return dataSource.sendPost(post);
  }
}
