import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/utils/hellper/layout.dart';
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.large,
            CircleAvatar(
              radius: MediaQuerys.widthMQ / 5,
              backgroundImage: AssetImage(post.users!.attribute!.avatar!),
            ),
            Gaps.small,
            Text(
              post.users!.attribute!.username,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Text(
              post.users!.attribute!.bio ?? 'Hallo World',
              style: const TextStyle(fontSize: 20),
            ),
            _badges(post),
          ],
        ),
      ),
    );
  }
}

Widget _badges(PostModel post) {
  return post.users!.attribute!.badges!.isNotEmpty
      ? Expanded(
          child: Wrap(
            spacing: 12,
            children: List.generate(
              post.users!.attribute!.badges!.length,
              (int index) {
                return CircleAvatar(
                  radius: MediaQuerys.widthMQ / 12,
                  backgroundImage:
                      NetworkImage(post.users!.attribute!.badges![index]),
                );
              },
            ),
          ),
        )
      : const SizedBox();
}
