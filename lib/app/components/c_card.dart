import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/components/c_button.dart';
import 'package:thismed/app/components/c_form.dart';
import 'package:thismed/app/data/models/comment_model.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/modules/home/controllers/home_controller.dart';
import 'package:thismed/app/routes/app_pages.dart';
import 'package:thismed/app/utils/hellper/asset.dart';
import 'package:thismed/app/utils/hellper/date.dart';
import 'package:thismed/app/utils/hellper/layout.dart';
import 'package:thismed/app/utils/themes/views/theme_view.dart';

class CsCard extends GetView<HomeController> {
  const CsCard({super.key, required this.item});

  final PostModel item;

  @override
  Widget build(BuildContext context) {
    return Paddings.mediumAll(
      Container(
        child: _buildBody(context, item, controller),
      ),
    );
  }
}

Widget _buildBody(BuildContext context, PostModel item, HomeController homeC) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Paddings.smallSx(
        Row(
          children: [
            InkWell(
              onTap: () => Get.toNamed(Routes.PROFILE_DETAIL, arguments: item),
              child: CircleAvatar(
                backgroundImage: AssetImage(item.users!.attribute!.avatar!),
              ),
            ),
            Gaps.small,
            Text(
              item.users!.attribute!.username,
              style:
                  TextStyle(color: Get.theme.colorScheme.primary, fontSize: 16),
            ),
            const Spacer(),
            Text(
              Dates.formated(item.createdAt!),
              style: TextStyle(color: Get.theme.colorScheme.primary),
            ),
          ],
        ),
      ),
      Gaps.medium,
      const Divider(
        height: 2,
        endIndent: 20,
        indent: 20,
      ),
      Gaps.medium,
      Text(
        item.title,
        style: TextStyle(
            color: Get.theme.colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      Gaps.medium,
      CachedNetworkImage(
        imageUrl: item.image!,
        imageBuilder: (context, imageProvider) => Container(
          height: MediaQuerys.heightMQ / 2.6,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: imageProvider,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      Gaps.small,
      Wrap(
        spacing: 6,
        children: List.generate(item.category!.length, (int i) {
          return Chip(
            side: BorderSide.none,
            backgroundColor: secondaryTextColor,
            label: Text("# ${item.category![i]}"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          );
        }),
      ),
      Gaps.medium,
      Row(
        children: [
          SizedBox(
            width: Get.width / 5,
            height: 42,
            child: CsButton(
              title:
                  '👍: ${item.intractions!.where((e) => e.liked == true).length}',
              useBorder: true,
              borderColor: primaryColor,
              onPressed: () async {
                homeC.getToggleIsLiked;
                homeC.setIsDisLiked = false;
                final int interactionIndex = item.intractions!
                    .indexWhere((i) => i.liked == true || i.liked == false);

                if (interactionIndex != -1) {
                  final intractId = item.intractions![interactionIndex].id;

                  if (item.intractions![interactionIndex].liked == true) {
                    await homeC.deleteIntraction(intractId, item.id);
                    homeC.setIsLiked = false;
                  } else {
                    await homeC.updateIntraction(intractId, item.id, true);
                    homeC.setIsLiked = true;
                  }
                } else {
                  await homeC.liked(item.id);
                  homeC.setIsLiked = true;
                }

                homeC.getToggleIsLiked;
              },
            ),
          ),
          Gaps.small,
          SizedBox(
            width: Get.width / 5,
            height: 42,
            child: CsButton(
              title:
                  '👎: ${item.intractions!.where((e) => e.liked == false).length}',
              useBorder: true,
              borderColor: primaryColor,
              onPressed: () async {
                homeC.getToggleIsDisLiked;
                homeC.setIsLiked = false;
                final int interactionIndex = item.intractions!
                    .indexWhere((i) => i.liked == false || i.liked == true);

                if (interactionIndex != -1) {
                  final intractId = item.intractions![interactionIndex].id;

                  if (item.intractions![interactionIndex].liked == false) {
                    await homeC.deleteIntraction(intractId, item.id);
                    homeC.setIsDisLiked = false;
                  } else {
                    await homeC.updateIntraction(intractId, item.id, false);
                    homeC.setIsDisLiked = true;
                  }
                } else {
                  await homeC.disLiked(item.id);
                  homeC.setIsDisLiked = true;
                }

                homeC.getToggleIsDisLiked;
              },
            ),
          ),
          Gaps.small,
          SizedBox(
            width: Get.width / 3,
            height: 42,
            child: CsButton(
              onPressed: () async {
                // await _buildComment(context);
                await _buildComment(item, homeC);
              },
              title: 'Comments : ${item.comments!.length.toString()}',
              useBorder: true,
              borderColor: primaryColor,
            ),
          ),
        ],
      ),
      Gaps.medium,
      const Divider(
        height: 2,
        endIndent: 10,
        indent: 10,
      ),
    ],
  );
}

Future<void> _buildComment(PostModel item, HomeController homeC) {
  return Get.bottomSheet(
    DefaultTextStyle(
      style: Get.theme.textTheme.bodyMedium!,
      child: Obx(
        () {
          final findcommentData =
              homeC.posts.firstWhere((i) => i.id == item.id);
          final commentData = findcommentData.comments!.reversed.toList();
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                color: Get.isDarkMode ? Colors.black : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(findcommentData.title),
                    Text("Comments : ${commentData.length.toString()}"),
                    Gaps.small,
                    Expanded(
                        child: ListView.builder(
                      itemCount: commentData.length,
                      itemBuilder: (context, i) {
                        final comment = commentData[i];
                        return Paddings.mediumSy(Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(comment.users!.attribute!.avatar!),
                            ),
                            Gaps.medium,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.users!.attribute!.username),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 150),
                                  child: Text(comment.content),
                                ),
                                Gaps.small,
                                _isCommentHasImage(comment)
                              ],
                            ),
                            const Spacer(),
                            Text(
                              Dates.formated(comment.createdAt!),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ));
                      },
                    )),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: CsFormField(
                              placeholder: 'write a comment',
                              controller: homeC.commentC,
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  await homeC.pickImage();
                                },
                                icon: const Icon(Icons.image),
                              ),
                            ),
                          ),
                          Gaps.small,
                          SizedBox(
                            width: 60,
                            child: CsButton(
                              title: "",
                              useIcon: true,
                              icon: Assets.sendLogo,
                              textStyle: const TextStyle(color: Colors.white),
                              bgColor: primaryColor,
                              onPressed: () async {
                                await homeC.postComment(item.id);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 80,
                left: 20,
                child: GetBuilder<HomeController>(
                  builder: (c) => _isUserPickImage(c),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget _isUserPickImage(HomeController c) {
  return c.image != null
      ? Stack(
          children: [
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2),
                color: primaryColor,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(
                    File(c.getFilePath),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -8,
              top: -8,
              child: IconButton(
                onPressed: () => c.clearImage(),
                icon: const Icon(Icons.clear),
              ),
            ),
          ],
        )
      : const SizedBox();
}

Widget _isCommentHasImage(CommentModel comment) {
  return comment.image != ""
      ? CachedNetworkImage(
          imageUrl: comment.image!,
          imageBuilder: (context, imageProvider) {
            return Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: imageProvider,
                ),
              ),
            );
          },
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
      : const SizedBox();
}
