import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadRepository {
  final FirebaseStorage storage;

  const UploadRepository({
    required this.storage,
  });

  Future<String> uploadFile(
    String path,
    String fileName,
    String storagePath,
  ) async {
    final Reference storageReference = storage.ref("$storagePath/$fileName");

    final UploadTask task = storageReference.putFile(
      File(path),
    );

    await task;

    final String url = task.snapshot.ref.fullPath;

    return url;
  }

  String generateName(String path) {
    final List<String> split = path.split("/");
    final List<String> nameSplited = split.last.split(".");

    final String ext = nameSplited.last;
    final String basename = md5
        .convert(
          utf8.encode(nameSplited.first),
        )
        .toString();

    return "$basename.$ext";
  }
}
