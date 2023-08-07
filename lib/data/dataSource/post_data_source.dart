import 'package:beh_pouyan_test/data/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

abstract class IPostDataSource {
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getPosts();
  Future<void> sendPost(Post post);
}

class PostRemoteDataSource implements IPostDataSource {
  final fireStore = FirebaseFirestore.instance;
  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getPosts() async {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapShot =
        fireStore.collection("posts").snapshots();
    return snapShot;
  }

  @override
  Future<void> sendPost(Post post) async {
    final postId = Uuid().v1();
    fireStore.collection("posts").doc(postId).set(post.toJson());
  }
}
