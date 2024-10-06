// import 'package:get/get.dart';
// import 'package:thismed/app/data/events/event_pref.dart';
// import 'package:thismed/app/data/models/attribute_model.dart';
// import 'package:thismed/app/data/models/post_model.dart';
// import 'package:thismed/app/data/models/user_model.dart';
//
// class AppServices {
//   static final http = GetConnect();
//   static final getUserId = EventPref.readUser()!.id;
//   static final getUserToken = EventPref.readUser()!.token;
//   static Future<UserModel> loginService(UserModel user) async {
//     try {
//       final response = await http.post(
//         'http://10.0.2.2:3000/api/login',
//         {
//           'email': user.email,
//           'password': user.password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = response.body['data'];
//         final responseData = UserModel.fromJson(data);
//         await EventPref.writeUser(responseData);
//         return responseData;
//       } else {
//         throw Exception("error");
//       }
//     } catch (e) {
//       throw Exception("error : $e");
//     }
//   }
//
//   static Future<UserModel> registerService(UserModel user) async {
//     try {
//       final response = await http.post(
//         'http://10.0.2.2:3000/api/register',
//         {
//           'email': user.email,
//           'password': user.password,
//         },
//       );
//
//       if (response.statusCode == 201) {
//         final data = response.body['data'];
//         final responseData = UserModel.fromJson(data);
//         await EventPref.writeUser(responseData);
//         return responseData;
//       } else {
//         throw Exception("error");
//       }
//     } catch (e) {
//       throw Exception("error : $e");
//     }
//   }
//
//   static Future<AttributeModel> attributeService(AttributeModel item) async {
//     try {
//       final response = await http.post(
//         headers: {'Authorization': 'Bearer $getUserToken'},
//         'http://10.0.2.2:3000/api/attribute?userId=$getUserId',
//         {'username': item.username, 'avatar': item.avatar, 'bio': item.bio},
//       );
//
//       if (response.statusCode == 201) {
//         final data = response.body['data'];
//         final responseData = AttributeModel.fromJson(data);
//         return responseData;
//       } else {
//         throw Exception("error");
//       }
//     } catch (e) {
//       throw Exception("error : $e");
//     }
//   }
//
//   static Future<List<PostModel>> getpostService() async {
//     try {
//       final response = await http.get(
//           headers: {'Authorization': 'Bearer $getUserToken'},
//           'http://10.0.2.2:3000/api/post');
//       if (response.statusCode == 200) {
//         final data = response.body['data'];
//         final responseData =
//             List<PostModel>.from(data.map((post) => PostModel.fromJson(post)));
//         return responseData;
//       } else {
//         throw Exception("error :");
//       }
//     } catch (e) {
//       throw Exception("error $e");
//     }
//   }
// }
