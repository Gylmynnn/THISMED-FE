import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:thismed/app/components/c_button.dart';
import 'package:thismed/app/components/c_form.dart';
import 'package:thismed/app/modules/auth/login/controllers/login_controller.dart';
import 'package:thismed/app/routes/app_pages.dart';
import 'package:thismed/app/utils/hellper/layout.dart';
import 'package:thismed/app/utils/themes/views/theme_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: _buildForm(controller, key)),
      ),
    );
  }
}

Form _buildForm(LoginController controller, GlobalKey<FormState> key) {
  return Form(
    key: key,
    child: SingleChildScrollView(
      child: Column(
        // physics: const NeverScrollableScrollPhysics(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.custom(140),
          Text(
            'Sign In',
            style: greyTextStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 64),
          ),
          Gaps.large,
          Text(
            '✉  Email',
            style: greyTextStyle.copyWith(
                fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Gaps.small,
          CsFormField(
            placeholder: 'Enter Your Email',
            textValidator: 'Email cannot be empty',
            controller: controller.emailC,
          ),
          Gaps.medium,
          Text(
            '🔒 Password',
            style: greyTextStyle.copyWith(
                fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Gaps.small,
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
          Gaps.large,
          CsButton(
            title: 'Login ✨',
            bgColor: primaryColor,
            textStyle: whiteTextStyle.copyWith(
                fontWeight: FontWeight.w600, fontSize: 20),
            onPressed: () {
              if (key.currentState!.validate()) {
                controller.login();
              }
            },
          ),
          Gaps.medium,
          const Center(
            child: Text(
              'Or',
            ),
          ),
          Gaps.small,
          CsButton(
            title: 'Google',
            useBorder: true,
            useIcon: true,
            iconAssetPath: ThemeUtilsView.logoGoogle,
            borderColor: primaryColor,
            onPressed: () => Get.toNamed(Routes.HOME),
            textStyle: primaryTextStyle.copyWith(
                fontWeight: FontWeight.w600, fontSize: 20),
          ),
          Gaps.medium,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don`t Have an Account ? ',
                  style: greyTextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 16)),
              CsButton(
                title: 'Sign Up',
                textStyle: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.w600, fontSize: 16),
                textOnly: true,
                onPressed: () {
                  Get.toNamed(Routes.REGISTER);
                },
              ),
            ],
          )
        ],
      ),
    ),
  );
}
