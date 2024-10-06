import 'package:get/get.dart';
import 'package:thismed/app/data/events/event_pref.dart';
import 'package:thismed/app/data/models/comment_model.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/utils/hellper/storage.dart';

class PostService extends GetConnect {

  // GET POST DATAS
  Future<List<PostModel>> getPostService() async {

    try {
      final response = await get(
          headers: {'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IjEiLCJpYXQiOjE3MjY0OTcxNDV9.WMufxcU8DoybXemwSwyUfcT4kGUd0fbgEDE80aUKB0o"},
          'http://10.0.2.2:3000/api/post');
      if (response.statusCode == 200) {
        final data = response.body['data'];
        final responseData =
            List<PostModel>.from(data.map((post) => PostModel.fromJson(post)));
     
        return responseData;
      } else {
        throw Exception("error :");
      }
    } catch (e) {
      throw Exception("error $e");
    } 
  }

  //   Future<CommentModel> postCommentService(int postId, CommentModel item) async {
  //   try {
  //     final response = await post(
  //         headers: {'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IjEiLCJpYXQiOjE3MjY0OTcxNDV9.WMufxcU8DoybXemwSwyUfcT4kGUd0fbgEDE80aUKB0o"},
  //       'http://10.0.2.2:3000/api/comment?userId=e813695f-9cb9-45fc-8835-f1a8cfd811c7&postId=$postId',
  //         {
  //           "content": item.content,
  //           "image": item.image,
  //         });
  //     if (response.statusCode == 201) {
  //       final data = response.body['data'];
  //       final responseData = CommentModel.fromJson(data);
  //       return responseData;
  //     } else {
  //       throw Exception("error :");
  //     }
  //   } catch (e) {
  //     throw Exception("error $e");
  //   }
  // }
}
