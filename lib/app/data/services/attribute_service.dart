
import 'package:thismed/app/data/models/attribute_model.dart';
import 'package:get/get.dart';
import 'package:thismed/app/utils/hellper/storage.dart';

class AttributeService extends GetConnect {
  
   Future<AttributeModel> attributeService(AttributeModel item) async {
    try {
      final Response<dynamic> response = await post(
        headers: {'Authorization': 'Bearer ${Storages.getUserToken}'},
        'http://10.0.2.2:3000/api/attribute?userId=${Storages.getUserId}',
        {'username': item.username, 'avatar': item.avatar, 'bio': item.bio},
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.body['data'];
        final AttributeModel responseData = AttributeModel.fromJson(data);
        return responseData;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception("error : $e");
    }
  }
}
