// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //* Shared state
  final isChildSelected = true.obs;
  final obscurePassword = true.obs;
  final selectedAvatar = 0.obs;
  final selectedGrade = 1.obs;

  // Controllers - initialized ONCE when controller is created
  late final TextEditingController parentNameController;
  late final TextEditingController childNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController usernameController;
  late final TextEditingController pinController;

  @override
  void onInit() {
    super.onInit();
    //* Initialize all controllers just once
    parentNameController = TextEditingController();
    childNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    pinController = TextEditingController();
  }

  void toggleRole(bool isChild) {
    isChildSelected.value = isChild;
  }

  // Methods for parent form
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void registerParent() {
    print('Registering parent: ${parentNameController.text}');
    print('Email: ${emailController.text}');
  }

  void addChildAccount() {
    //* Logic to add child account
    print('Adding child account');
    // TODO: Add API calls or validation
  }

  // Methods for child form
  void setAvatar(int index) {
    selectedAvatar.value = index;
  }

  // void setGrade(int grade) {
  //   selectedGrade.value = grade;
  // }

  void registerChild() {
    print('Registering child: ${usernameController.text}');
    print('Selected avatar: ${selectedAvatar.value}');
  }

  @override
  void onClose() {
    print("SignupController is being disposed");

    super.onClose();
  }

  @override
  void dispose() {
    print('Disposing controllers');

    super.dispose();
  }
}
