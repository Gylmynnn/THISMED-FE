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
import 'package:get/get.dart';
import 'dart:io';

import 'package:thismed/app/utils/hellper/utils.dart';

class HomeController extends GetxController {
  //---------------------------------------
  final PostService _http = PostService();
  final CommentService _http2 = CommentService();
  final InteractionService _http3 = InteractionService();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxString _filePath = ''.obs;
  final RxString _imgDownloadUrl = ''.obs;
  final RxInt _likeCount = 0.obs;
  final RxInt _disLikeCount = 0.obs;
  final RxBool _isLiked = false.obs;
  final RxBool _isDisLiked = false.obs;
  final RxBool _isLoading = false.obs;
  late TextEditingController commentC;
  XFile? image;
  // Rx<XFile>? halloWorld;

  //-----------------------------------------
  set setLikedCount(int value) => _likeCount.value = value;
  set setDisLikedCount(int value) => _disLikeCount.value = value;
  set setIsLoading(bool value) => _isLoading.value = value;
  set setIsLiked(bool value) => _isLiked.value = value;
  set setIsDisLiked(bool value) => _isDisLiked.value = value;
  set setFilePath(String value) => _filePath.value = value;
  set setImgDownloadUrl(String value) => _imgDownloadUrl.value = value;

  //-----------------------------------------

  bool get getIsLoading => _isLoading.value;
  bool get getIsLiked => _isLiked.value;
  bool get getIsDisLiked => _isDisLiked.value;
  Rx<bool> get getToggleIsLiked => _isLiked.toggle();
  Rx<bool> get getToggleIsDisLiked => _isDisLiked.toggle();
  String get getImgDownloadUrl => _imgDownloadUrl.value;
  String get getFilePath => _filePath.value;
  int get getLikedCount => _likeCount.value;
  int get getDisLikedCount => _disLikeCount.value;

  //------------------------------------------

  @override
  void onInit() {
    commentC = TextEditingController();
    getPost();
    super.onInit();
  }

  @override
  void onReady() {
    posts.refresh();
    super.onReady();
  }

  @override
  void onClose() {
    commentC.dispose();
    super.onClose();
  }

  //-------------------------------------

  Future<void> uploadImage() async {
    try {
      final String formattedDateTime = Dates.yyyyMMdd(DateTime.now());
      final File imageFile = File(getFilePath);
      final String fileName = getFilePath.split('/').last;
      final String uniquePath = '$formattedDateTime$fileName';
      final String path = 'comments/${Storages.getUserId}/$uniquePath';
      final Reference storageRef = _storage.ref().child(path);
      final List<int> compressed = await Utils.compressImage(imageFile, 40);
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

  void toggleDisLiked(PostModel item) {
    final String currentUserId = Storages.getUserId;
    final int interactionIndex =
        item.intractions!.indexWhere((i) => i.userId == currentUserId);
    if (interactionIndex != -1) {
      final IntractionModel intraction = item.intractions![interactionIndex];
      final int intractId = intraction.id;
      if (intraction.liked == false) {
        deleteIntraction(intractId, item.id);
        setIsDisLiked = false;
      } else {
        updateIntraction(intractId, item.id, false);
        setIsLiked = false;
        setIsDisLiked = true;
      }
    } else {
      disLiked(item.id);
      setIsLiked = false;
      setIsDisLiked = true;
    }
    getToggleIsDisLiked;
  }

  void toggleLiked(PostModel item) {
    final String currentUserId = Storages.getUserId;
    final int interactionIndex =
        item.intractions!.indexWhere((i) => i.userId == currentUserId);
    if (interactionIndex != -1) {
      final IntractionModel intraction = item.intractions![interactionIndex];
      final int intractId = intraction.id;
      if (intraction.liked == true) {
        deleteIntraction(intractId, item.id);
        setIsLiked = false;
      } else {
        updateIntraction(intractId, item.id, true);
        setIsLiked = true;
      }
    } else {
      liked(item.id);
      setIsDisLiked = false;
      setIsLiked = true;
    }

    getToggleIsLiked;
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

  Future<void> deleteIntraction(int id, int postId) async {
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
    setIsLoading = true;
    try {
      final List<PostModel> response = await _http.getPostService();
      posts.assignAll(response);
    } catch (e) {
      throw Exception(e);
    } finally {
      setIsLoading = false;
    }
  }

  Future<void> postComment(int postId) async {
    setIsLoading = true;
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
        if (commentC.text.length > 1) {
          final data = CommentModel(id: 0, content: commentC.text, image: null);
          final response = await _http2.postCommentService(postId, data);
          final postIndex = posts.indexWhere((post) => post.id == postId);
          if (postIndex == -1) throw Exception("Post not found");
          posts[postIndex].comments!.assign(response);
          await getPost();
          commentC.clear();
        } else {
          Get.snackbar("Notice", "Comment text must more than 1 Characters");
        }
      }
    } catch (e) {
      throw Exception("Error: $e");
    } finally {
      setIsLoading = false;
    }
  }
}
