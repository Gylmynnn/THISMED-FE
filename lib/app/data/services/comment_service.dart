import 'package:get/get.dart';
import 'package:thismed/app/data/models/comment_model.dart';
import 'package:thismed/app/utils/hellper/storage.dart';

class CommentService extends GetConnect {
  // GET POST DATAS
  Future<CommentModel> postCommentService(int postId, CommentModel item) async {
    try {
      final Response<dynamic> response = await post(
          headers: {'Authorization': "Bearer ${Storages.getUserToken}"},
          'http://10.0.2.2:3000/api/comment?userId=${Storages.getUserId}&postId=$postId',
          {
            "content": item.content,
            "image": item.image,
          });
      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.body['data'];
        final CommentModel responseData = CommentModel.fromJson(data);
        return responseData;
      } else {
        throw Exception("error :");
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }
}
