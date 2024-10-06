import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:thismed/app/components/c_button.dart';
import 'package:thismed/app/components/c_form.dart';
import 'package:thismed/app/utils/themes/views/theme_view.dart';
import '../controllers/setup_controller.dart';

class SetupView extends GetView<SetupController> {
  const SetupView({super.key});
  @override
  Widget build(BuildContext context) {
    // var key = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Form(
            key: controller.key,
            child: SingleChildScrollView(
              child: Column(
                // physics: const NeverScrollableScrollPhysics(),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(140),
                  Text(
                    'Sign In',
                    style: greyTextStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 64),
                  ),
                  const Gap(30),
                  Text(
                    'Username',
                    style: greyTextStyle.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const Gap(10),
                  CsFormField(
                    placeholder: 'Enter Your Username',
                    textValidator: 'Username cannot be empty',
                    controller: controller.usernameC,
                  ),
                  const Gap(20),
                  Text(
                    'Avatar',
                    style: greyTextStyle.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const Gap(10),
                  CsFormField(
                    placeholder: 'Enter Your Avatar',
                    textValidator: 'Avatar cannot be empty',
                    controller: controller.avatarC,
                  ),
                  const Gap(20),
                  Text(
                    'Bio',
                    style: greyTextStyle.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const Gap(10),
                  CsFormField(
                    placeholder: 'Enter Your Bio',
                    textValidator: 'Bio cannot be empty',
                    controller: controller.bioC,
                  ),
                  const Gap(38),
                  CsButton(
                    title: 'Save',
                    bgColor: primaryColor,
                    textStyle: whiteTextStyle.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 20),
                    onPressed: () {
                      if (controller.key.currentState!.validate()) {
                        controller.setupAttribute();
                      }
                    },
                  ),
                  const Gap(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
