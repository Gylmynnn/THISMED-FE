import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thismed/app/data/models/comment_model.dart';
import 'package:thismed/app/data/models/intraction_model.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/data/services/comment_service.dart';
import 'package:thismed/app/data/services/interaction_service.dart';
import 'package:thismed/app/data/services/post_service.dart';
import 'package:thismed/app/utils/hellper/date.dart';
import 'package:thismed/app/utils/hellper/storage.dart';
import 'package:image/image.dart' as img;
import 'package:get/get.dart';
import 'dart:io';

class HomeController extends GetxController {
  final PostService _http = PostService();
  final CommentService _http2 = CommentService();
  final InteractionService _http3 = InteractionService();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxString _filePath = ''.obs;
  final RxString _imgDownloadUrl = ''.obs;
  final RxBool _isLiked = false.obs;
  final RxBool _isDisLiked = false.obs;
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

  set setIsLiked(bool value) => _isLiked.value = value;
  set setIsDisLiked(bool value) => _isDisLiked.value = value;
  set setFilePath(String value) => _filePath.value = value;
  set setImgDownloadUrl(String value) => _imgDownloadUrl.value = value;
  bool get getIsLiked => _isLiked.value;
  bool get getIsDisLiked => _isDisLiked.value;
  Rx<bool> get getToggleIsLiked => _isLiked.toggle();
  Rx<bool> get getToggleIsDisLiked => _isDisLiked.toggle();

  String get getImgDownloadUrl => _imgDownloadUrl.value;
  String get getFilePath => _filePath.value;

  Future<List<int>> compressImage(File file) async {
    final img.Image? originalImage = img.decodeImage(file.readAsBytesSync());
    final resizedImage = img.encodeJpg(originalImage!,
        quality: 50); // Resize width, keep aspect ratio
    return resizedImage; // Compress with 80% quality
  }

  Future<void> uploadImage() async {
    try {
      final String formattedDateTime = Dates.yyyyMMdd(DateTime.now());
      final File imageFile = File(getFilePath);
      final String fileName = getFilePath.split('/').last;
      final String uniquePath = '$formattedDateTime$fileName';
      final String path = 'comments/${Storages.getUserId}/$uniquePath';
      final Reference storageRef = _storage.ref().child(path);
      final List<int> compressed = await compressImage(imageFile);
      final UploadTask uploadTask =
          storageRef.putData(Uint8List.fromList(compressed));
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

  Future<void> liked(int postId) async {
    try {
      final data = IntractionModel(id: 0, liked: true);
      await _http3.postInteractionService(postId, data);
      posts.refresh();
      await getPost();
    } catch (e) {
      throw Exception("error :$e");
    }
  }

  Future<void> updateIntraction(int id, int postId, bool liked) async {
    try {
      final data = IntractionModel(id: 0, liked: liked);
      await _http3.putInteractionService(id, postId, data);
      await getPost();
      posts.refresh();
    } catch (e) {
      throw Exception("error :$e");
    }
  }

  Future<void> deleteIntraction(
    int id,
    int postId,
  ) async {
    try {
      await _http3.deleteInteractionService(id, postId);
      posts.refresh();
      await getPost();
    } catch (e) {
      throw Exception("error :$e");
    }
  }

  Future<void> disLiked(int postId) async {
    try {
      final data = IntractionModel(id: 0, liked: false);
      await _http3.postInteractionService(postId, data);
      await getPost();
      posts.refresh();
    } catch (e) {
      throw Exception("error :$e");
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
        if (commentC.text.length > 3) {
          final data = CommentModel(id: 0, content: commentC.text, image: null);
          final response = await _http2.postCommentService(postId, data);
          final postIndex = posts.indexWhere((post) => post.id == postId);
          if (postIndex == -1) throw Exception("Post not found");
          posts[postIndex].comments!.assign(response);
          await getPost();
          commentC.clear();
        } else {
          Get.snackbar("Notice", "Comment text must more than 3 Characters");
        }
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
