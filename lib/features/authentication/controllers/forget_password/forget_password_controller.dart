import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var emailSent = false.obs;

  void resetPassword() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      //* Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        emailSent.value = true;
      });
    }
  }

  void goToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
