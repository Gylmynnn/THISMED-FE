import 'package:get/get.dart';
import 'package:thismed/app/data/models/intraction_model.dart';
import 'package:thismed/app/utils/hellper/storage.dart';

class InteractionService extends GetConnect {
  Future<IntractionModel> postInteractionService(
      int postId, IntractionModel item) async {
    try {
      final Response<dynamic> response = await post(
        headers: {'Authorization': "Bearer ${Storages.getUserToken}"},
        'http://10.0.2.2:3000/api/intraction?userId=${Storages.getUserId}&postId=$postId',
        {
          "liked": item.liked,
        },
      );
      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.body['data'];
        final IntractionModel responseData = IntractionModel.fromJson(data);
        return responseData;
      } else {
        throw Exception("error :");
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }

  Future<IntractionModel> putInteractionService(
      int id, int postId, IntractionModel item) async {
    try {
      final Response<dynamic> response = await put(
        headers: {'Authorization': "Bearer ${Storages.getUserToken}"},
        'http://10.0.2.2:3000/api/intraction?id=$id&userId=${Storages.getUserId}&postId=$postId',
        {
          "liked": item.liked,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.body['data'];
        final IntractionModel responseData = IntractionModel.fromJson(data);
        return responseData;
      } else {
        throw Exception("error :");
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }

  Future<IntractionModel> deleteInteractionService(
      int id, int postId) async {
    try {
      final Response<dynamic> response = await delete(
        headers: {'Authorization': "Bearer ${Storages.getUserToken}"},
        'http://10.0.2.2:3000/api/intraction?id=$id&userId=${Storages.getUserId}&postId=$postId',
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.body['data'];
        final IntractionModel responseData = IntractionModel.fromJson(data);
        return responseData;
      } else {
        throw Exception("error :");
      }
    } catch (e) {
      throw Exception("error $e");
    }
  }
}
