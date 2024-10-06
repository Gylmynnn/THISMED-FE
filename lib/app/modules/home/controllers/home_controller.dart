import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thismed/app/data/models/comment_model.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/data/services/comment_service.dart';
import 'package:thismed/app/data/services/post_service.dart';

class HomeController extends GetxController {
  final PostService http = PostService();
  final CommentService _http2 = CommentService();
  final RxList<PostModel> posts = <PostModel>[].obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  XFile? image;

  late TextEditingController commentC;

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

  // Future<void> uploadImage() async {
  //   print(image!.name);
  //   print(image!.path);
  //   Reference ref = _storage.ref(image!.name);
  //   final File getFile = File(image!.path);
  //   final dataUp = await ref.putFile(getFile);
  //   /*  final linkImage = await ref.getDownloadURL(); */
  //   print(dataUp);
  //
  //
  // }

  void clearImage() {
    image = null;
    update();
  }

  Future<void> pickImage() async {
    try {
      image = await _picker.pickImage(source: ImageSource.gallery);
      update();
      if (image != null) {
        Get.log(image!.path);
      }
    } catch (e) {
      image = null;
      update();
    }
  }

  Future<void> getPost() async {
    try {
      final List<PostModel> response = await http.getPostService();
      posts.assignAll(response);
    } catch (e) {
      throw Exception("error :$e");
    }
  }

  Future<void> postComment(int postId) async {
    try {
      const String imageMyPath =
          "https://firebasestorage.googleapis.com/v0/b/thismed-app.appspot.com/o/images%2Fcute.png?alt=media&token=0ab086ff-6b2f-4947-ac6a-b5a017756094";
      final data =
          CommentModel(id: 0, content: commentC.text, image: imageMyPath);
      final response = await _http2.postCommentService(postId, data);
      final postIndex = posts.indexWhere((post) => post.id == postId);
      if (postIndex == -1) throw Exception("Post not found");
      posts[postIndex].comments!.assign(response);
      await getPost();
      commentC.clear();
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
