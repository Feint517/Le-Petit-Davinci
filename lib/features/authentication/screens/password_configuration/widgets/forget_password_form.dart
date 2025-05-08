import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:kids_learning_app/features/authentication/screens/password_configuration/widgets/email_sent_view.dart';
import 'package:kids_learning_app/features/authentication/screens/password_configuration/widgets/request_form.dart';

class ForgotPasswordForm extends GetView<ForgotPasswordController> {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.emailSent.value) {
        return EmailSentView();
      } else {
        return RequestForm();
      }
    });
  }
}
