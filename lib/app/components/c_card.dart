import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/components/c_button.dart';
import 'package:thismed/app/components/c_form.dart';
import 'package:thismed/app/data/models/post_model.dart';
import 'package:thismed/app/modules/home/controllers/home_controller.dart';
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
        Container(child: _buildBody(context, item, controller)));
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
            CircleAvatar(
              backgroundImage: AssetImage(item.users!.attribute!.avatar!),
            ),
            Gaps.small,
            Text(
              item.users!.attribute!.username,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const Spacer(),
            Text(
              Dates.formated(item.createdAt!),
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
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
        height: MediaQuerys.heightMQ / 2.3,
        fit: BoxFit.fill,
        width: double.infinity,
      ),
      Gaps.small,
      Wrap(
        spacing: 6,
        children: List.generate(item.category!.length, (i) {
          return Chip(
              side: BorderSide.none,
              backgroundColor: secondaryTextColor,
              label: Text("# ${item.category![i]}"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)));
        }),
      ),
      Gaps.medium,
      Row(
        children: [
          SizedBox(
            width: Get.width / 5,
            height: 42,
            child: CsButton(
              title: '👍: ${item.comments!.length.toString()}',
              useBorder: true,
              borderColor: primaryColor,
            ),
          ),
          Gaps.small,
          SizedBox(
            width: Get.width / 3,
            height: 42,
            child: CsButton(
              onPressed: () async {
                await _buildComment(item, homeC);
              },
              title: 'Comments : ${item.comments!.length.toString()}',
              useBorder: true,
              borderColor: primaryColor,
            ),
          ),
        ],
      ),
      // GestureDetector(
      //     child: Text("Comments : ${item.comments!.length.toString()}"),
      //     onTap: () async {
      //       await _buildComment(item, homeC);
      //     }),
      Gaps.medium,
      const Divider(
        height: 2,
        endIndent: 10,
        indent: 10,
      ),
    ],
  );
}

Future _buildComment(PostModel item, HomeController homeC) {
  return Get.bottomSheet(Obx(() {
/*     final ascc = homeC.posts; */
/*     final desc = homeC.posts.reversed.toList(); */
    final findcommentData = homeC.posts.firstWhere((i) => i.id == item.id);
    final commentData = findcommentData.comments!.reversed.toList();
    return Stack(children: [
      Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
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
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: Text(comment.content),
                          ),
                          Gaps.small,
                          comment.image != ""
                              ? Container(
                                  height: 160,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: primaryColor,
                                      image: DecorationImage(
                                          image: NetworkImage(comment.image!))),
                                )
                              : const SizedBox()
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
                            icon: const Icon(Icons.image)),
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
/*                          onPressed: () => homeC.postComment(item.id), */
                          onPressed: () async {
                            await homeC.postComment(item.id);
                          }),
                    ),
                  ],
                ),
              ),
            ],
          )),
      Positioned(
          bottom: 80,
          left: 20,
          child: GetBuilder<HomeController>(
              builder: (c) => c.image != null
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
                                  image: FileImage(File(c.image!.path)))),
                        ),
                        Positioned(
                            right: -8,
                            top: -8,
                            child: IconButton(
                                onPressed: () => c.clearImage(),
                                icon: const Icon(Icons.clear)))
                      ],
                    )
                  : const SizedBox())),
    ]);
  }));
}


// Expanded(
//             child: Obx(() {
//               final updatedPost =
//                   homeC.posts.firstWhere((post) => post.id == item.id);
//               return ListView.builder(
//                 itemCount: updatedPost.comments?.length ?? 0,
//                 itemBuilder: (context, i) {
//                   final comment = updatedPost.comments![i];
//                   return Paddings.mediumSy(Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage:
//                             AssetImage(comment.users!.attribute!.avatar!),
//                       ),
//                       Gaps.medium,
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(comment.users!.attribute!.username),
//                           Text(comment.content),
//                         ],
//                       ),
//                     ],
//                   ));
//                 },
//               );
//             }),
//           ),


// Widget _buildComment() {
//   return DraggableScrollableSheet(
//       builder: (BuildContext context, scrollController) {
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//         color: Theme.of(context).canvasColor,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//       ),
//       child: CustomScrollView(
//         controller: scrollController,
//         slivers: [
//           SliverList.list(children: const [
//             ListTile(title: Text('Jane Doe')),
//             ListTile(title: Text('Jack reacher')),
//           ])
//         ],
//       ),
//     );
//   });
// }
