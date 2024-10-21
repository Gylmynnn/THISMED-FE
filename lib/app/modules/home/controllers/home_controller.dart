import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thismed/app/data/models/comment_model.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/data/services/comment_service.dart';
import 'package:thismed/app/data/services/post_service.dart';
import 'package:thismed/app/utils/hellper/date.dart';
import 'dart:io';

import 'package:thismed/app/utils/hellper/storage.dart';

class HomeController extends GetxController {
  final PostService _http = PostService();
  final CommentService _http2 = CommentService();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxString _filePath = ''.obs;
  final RxString _imgDownloadUrl = ''.obs;
  late TextEditingController commentC;
  XFile? image;
  Rx<XFile>? halloWorld;

  @override
  void onInit() {
    commentC = TextEditingController();
    getPost();
    super.onInit();
  }

  @override
  void onClose() {
    commentC.dispose();
    super.onClose();
  }

  set setFilePath(String value) => _filePath.value = value;
  set setImgDownloadUrl(String value) => _imgDownloadUrl.value = value;
  String get getImgDownloadUrl => _imgDownloadUrl.value;
  String get getFilePath => _filePath.value;

  Future<void> uploadImage() async {
    try {
      final String formattedDateTime = Dates.yyyyMMdd(DateTime.now());
      final File imageFile = File(getFilePath);
      final String fileName = getFilePath.split('/').last;
      final String uniquePath = '$formattedDateTime$fileName';
      final String path = 'comments/${Storages.getUserId}/$uniquePath';
      final Reference storageRef = _storage.ref().child(path);
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot task = await uploadTask;
      final String value = await task.ref.getDownloadURL();
      setImgDownloadUrl = value;
    } catch (e) {
      throw Exception("error : $e");
    }
  }

  void clearImage() {
    image = null;
    update();
  }

  Future<void> pickImage() async {
    try {
      image = await _picker.pickImage(source: ImageSource.gallery);
      update();
      if (image != null) {
        setFilePath = image!.path;
      } else {
        Get.snackbar("Info", "No Image Insert");
      }
    } catch (e) {
      image = null;
      update();
    }
  }

  Future<void> getPost() async {
    try {
      final List<PostModel> response = await _http.getPostService();
      posts.assignAll(response);
    } catch (e) {
      throw Exception("error :$e");
    }
  }

  Future<void> postComment(int postId) async {
    try {
      if (image != null) {
        await uploadImage();
        final data = CommentModel(
            id: 0, content: commentC.text, image: getImgDownloadUrl);
        final response = await _http2.postCommentService(postId, data);
        final postIndex = posts.indexWhere((post) => post.id == postId);
        if (postIndex == -1) throw Exception("Post not found");
        posts[postIndex].comments!.assign(response);
        await getPost();
        commentC.clear();
        image = null;
        update();
      } else {
        final data = CommentModel(id: 0, content: commentC.text, image: null);
        final response = await _http2.postCommentService(postId, data);
        final postIndex = posts.indexWhere((post) => post.id == postId);
        if (postIndex == -1) throw Exception("Post not found");
        posts[postIndex].comments!.assign(response);
        await getPost();
        commentC.clear();
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
