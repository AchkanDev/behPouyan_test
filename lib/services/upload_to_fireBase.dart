import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageToFireBase(String childName, Uint8List file) async {
    Reference reference = firebaseStorage.ref().child(childName);
    final id = const Uuid().v1();
    reference = reference.child(id);
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
