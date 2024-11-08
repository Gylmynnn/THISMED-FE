import 'package:get/get.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/data/services/post_service.dart';

class ProfileDetailController extends GetxController {
  final PostService _http = PostService();
  final RxList<PostModel> postDatas = <PostModel>[].obs;

  @override
  void dispose() {
    postDatas.clear();
    super.dispose();
  }

  Future<void> getUserPost(String userId) async {
    try {
      final response = await _http.getPostServiceUserId(userId);
      postDatas.assignAll(response);
      postDatas.refresh();
    } catch (e) {
      throw Exception(e);
    }
  }
}
