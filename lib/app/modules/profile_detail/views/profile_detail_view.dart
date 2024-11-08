import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/components/c_card.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/utils/hellper/layout.dart';
import '../controllers/profile_detail_controller.dart';

class ProfileDetailView extends GetView<ProfileDetailController> {
  const ProfileDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final PostModel post = Get.arguments;
    controller.getUserPost(post.userId!);

    return Obx(() => Scaffold(
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
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Gaps.small,
                Text(
                  post.users!.attribute!.bio ?? 'Hallo world..',
                  style: const TextStyle(fontSize: 20),
                ),

                Gaps.small,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPostCount(controller),
                    _buildFollowerCount(controller),
                    _buildFollowingCount(controller),
                  ],
                ),
                Gaps.large,
                _badges(post),
                // Gaps.medium,
                Flexible(
                  flex: 4,
                  child: ListView.builder(
                    itemCount: controller.postDatas.length,
                    itemBuilder: (context, index) {
                      final PostModel item = controller.postDatas[index];
                      return CsCard(
                        item: item,
                        isClickedProfile: false,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Widget _buildPostCount(ProfileDetailController controller) {
  final int postLength = controller.postDatas.length;
  return Text(
    postLength <= 1 ? "Post : $postLength" : "Posts : $postLength",
    style: const TextStyle(fontSize: 16),
  );
}

Widget _buildFollowerCount(ProfileDetailController controller) {
  final int postLength = controller.postDatas.length;
  return Text(
    postLength <= 1 ? "Follower : $postLength" : "Followers : $postLength",
    style: const TextStyle(fontSize: 16),
  );
}

Widget _buildFollowingCount(ProfileDetailController controller) {
  final int postLength = controller.postDatas.length;
  return Text(
    postLength <= 1 ? "Following : $postLength" : "Followings : $postLength",
    style: const TextStyle(fontSize: 16),
  );
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
                  radius: MediaQuerys.widthMQ / 16,
                  backgroundImage: NetworkImage(
                    post.users!.attribute!.badges![index],
                  ),
                );
              },
            ),
          ),
        )
      : const SizedBox();
}
