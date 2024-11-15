import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/components/c_form.dart';
import 'package:thismed/app/modules/post/controllers/post_controller.dart';
import 'package:thismed/app/utils/hellper/layout.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(controller),
    );
  }
}

Widget _buildBody(PostController controller) {
  return Column(
    children: [
      Paddings.mediumAll(CsFormField(
        controller: controller.postC,
        placeholder: "Enter Title",
        maxLines: 10,
        // minLines: 2,
      ))
    ],
  );
}

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    title: const Text("Create Post"),
    centerTitle: true,
  );
}
