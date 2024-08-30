import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:thismed/app/components/c_button.dart';
import 'package:thismed/app/components/c_form.dart';
import 'package:thismed/app/modules/auth/register/controllers/register_controller.dart';
import 'package:thismed/app/utils/themes/views/theme_view.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(100),
                Text(
                  'Sign Up',
                  style: greyTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 64),
                ),
                const Gap(20),
                Text(
                  'Email',
                  style: greyTextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Gap(10),
                CsFormField(
                  placeholder: 'Enter Your Email',
                  textValidator: 'Email cannot be empty',
                  controller: controller.emailC,
                ),
                const Gap(20),
                Text(
                  'Password',
                  style: greyTextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Gap(10),
                Obx(() => CsFormField(
                      obsecureText: controller.passwordSecure.value,
                      suffixIcon: Obx(() => IconButton(
                            padding: const EdgeInsets.only(right: 6),
                            icon: FaIcon(
                              size: 20,
                              controller.passwordSecure.value
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: secondaryTextColor,
                            ),
                            onPressed: () {
                              controller.passwordSecure.toggle();
                            },
                          )),
                      placeholder: 'Enter Your Password',
                      textValidator: 'Password cannot be empty',
                      controller: controller.passwordC,
                    )),
                CsButton(
                  onPressed: () => controller.generatePassword(),
                  title: 'Generate Password',
                  alignment: AlignmentDirectional.centerEnd,
                  textOnly: true,
                  textStyle: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                // const Gap(20),
                Text(
                  'Confirm Password',
                  style: greyTextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Gap(10),
                Obx(() => CsFormField(
                      obsecureText: controller.confirmPasswordSecure.value,
                      suffixIcon: Obx(() => IconButton(
                            padding: const EdgeInsets.only(right: 6),
                            icon: FaIcon(
                              size: 20,
                              controller.confirmPasswordSecure.value
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: secondaryTextColor,
                            ),
                            onPressed: () {
                              controller.confirmPasswordSecure.toggle();
                            },
                          )),
                      placeholder: 'Confirm Your Password',
                      textValidator: 'Password cannot be empty',
                      controller: controller.confirmPasswordC,
                    )),
                const Gap(38),
                CsButton(
                  title: 'Sign Up',
                  bgColor: primaryColor,
                  textStyle: whiteTextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 20),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      controller.register();
                    }
                  },
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have an Account ? ',
                        style: greyTextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    CsButton(
                      title: 'Sign In',
                      textStyle: primaryTextStyle.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 16),
                      textOnly: true,
                      onPressed: () => Get.back(),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
