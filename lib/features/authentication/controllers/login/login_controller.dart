import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      // Perform login action
    }
  }
}