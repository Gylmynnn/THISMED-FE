import 'package:get/get.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/utils/hellper/storage.dart';

class PostService extends GetConnect {
  Future<List<PostModel>> getPostServiceUserId(String userId) async {
    try {
      final Response<dynamic> response = await get(
          headers: {'Authorization': "Bearer ${Storages.getUserToken}"},
          'http://10.0.2.2:3000/api/post?userId=$userId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.body['data'];
        final List<PostModel> responseData = List<PostModel>.from(
          data.map((post) => PostModel.fromJson(post)),
        );
        return responseData;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // GET POST DATAS
  Future<List<PostModel>> getPostService() async {
    try {
      final Response<dynamic> response = await get(
          headers: {'Authorization': "Bearer ${Storages.getUserToken}"},
          'http://10.0.2.2:3000/api/post');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.body['data'];
        final List<PostModel> responseData =
            List<PostModel>.from(data.map((post) => PostModel.fromJson(post)));
        return responseData;
      } else {
        throw Exception("error :");
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }
}
