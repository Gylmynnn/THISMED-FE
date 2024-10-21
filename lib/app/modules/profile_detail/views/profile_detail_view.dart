import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/models/post_model.dart';
import '../controllers/profile_detail_controller.dart';

class ProfileDetailView extends GetView<ProfileDetailController> {
  const ProfileDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final PostModel post = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('@${post.users!.attribute!.username}'),
          centerTitle: true,
        ),
        body: Column(

          children: [
            CircleAvatar(
              backgroundImage: AssetImage(post.users!.attribute!.avatar!),
            ),
            Text(
              post.users!.attribute!.username,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              post.users!.attribute!.bio ?? 'isi woii',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ));
  }
}
