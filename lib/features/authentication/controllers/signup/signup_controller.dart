// lib/features/authentication/controllers/registration_controller.dart
// ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SignupControllerOld extends GetxController {
//   //* Shared state
//   final isChildSelected = true.obs;

//   // Private controller fields
//   TextEditingController? _nameController;
//   TextEditingController? _emailController;
//   TextEditingController? _passwordController;
//   TextEditingController? _usernameController;
//   TextEditingController? _pinController;

//   // Getters for controllers with lazy initialization
//   TextEditingController get nameController {
//     _nameController ??= TextEditingController();
//     return _nameController!;
//   }

//   TextEditingController get emailController {
//     _emailController ??= TextEditingController();
//     return _emailController!;
//   }

//   TextEditingController get passwordController {
//     _passwordController ??= TextEditingController();
//     return _passwordController!;
//   }

//   TextEditingController get usernameController {
//     _usernameController ??= TextEditingController();
//     return _usernameController!;
//   }

//   TextEditingController get pinController {
//     _pinController ??= TextEditingController();
//     return _pinController!;
//   }

//   //* Parent form state
//   final obscurePassword = true.obs;
//   // final nameController = TextEditingController();
//   // final emailController = TextEditingController();
//   // final passwordController = TextEditingController();

//   //* Child form state
//   final selectedAvatar = 0.obs;
//   final selectedGrade = 1.obs;
//   // final usernameController = TextEditingController();
//   // final pinController = TextEditingController();

//   //* Role selection
//   // void toggleRole(bool isChild) {
//   //   isChildSelected.value = isChild;
//   // }
//   void toggleRole(bool isChild) {
//     //* Clean up existing controllers first
//     bool needsReinit = isChildSelected.value != isChild;
//     isChildSelected.value = isChild;

//     if (needsReinit) {
//       //* Clean up old controllers
//       _nameController?.dispose();
//       _emailController?.dispose();
//       _passwordController?.dispose();
//       _usernameController?.dispose();
//       _pinController?.dispose();

//       //* Set to null so they'll be recreated on next access
//       _nameController = null;
//       _emailController = null;
//       _passwordController = null;
//       _usernameController = null;
//       _pinController = null;
//     }
//   }

//   //* Parent methods
//   void togglePasswordVisibility() {
//     obscurePassword.value = !obscurePassword.value;
//   }

//   void registerParent() {
//     // Implement parent registration logic
//     print('Registering parent: ${nameController.text}');
//     print('Email: ${emailController.text}');
//     // TODO: Add API calls or validation
//   }

//   void addChildAccount() {
//     //* Logic to add child account
//     print('Adding child account');
//     // TODO: Add API calls or validation
//   }

//   // Child methods
//   void setAvatar(int index) {
//     selectedAvatar.value = index;
//   }

//   void setGrade(int grade) {
//     selectedGrade.value = grade;
//   }

//   void registerChild() {
//     // child registration logic
//     print('Registering child: ${usernameController.text}');
//     print('Selected avatar: ${selectedAvatar.value}');
//     print('Selected grade: ${selectedGrade.value}');
//     // TODO: Add API calls or validation
//   }

//   @override
//   void onClose() {
//     //* Dispose all controllers
//     // nameController.dispose();
//     // emailController.dispose();
//     // passwordController.dispose();
//     // usernameController.dispose();
//     // pinController.dispose();
//     _nameController?.dispose();
//     _emailController?.dispose();
//     _passwordController?.dispose();
//     _usernameController?.dispose();
//     _pinController?.dispose();
//     super.onClose();
//   }
// }

class SignupController extends GetxController {
  // Shared state
  final isChildSelected = true.obs;
  final obscurePassword = true.obs;
  final selectedAvatar = 0.obs;
  final selectedGrade = 1.obs;

  // Controllers - initialized ONCE when controller is created
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController usernameController;
  late final TextEditingController pinController;

  @override
  void onInit() {
    super.onInit();
    // Initialize all controllers just once
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    pinController = TextEditingController();
  }

  // Role selection - now without controller disposal
  void toggleRole(bool isChild) {
    isChildSelected.value = isChild;
    // NO controller disposal here
  }

  // Methods for parent form
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void registerParent() {
    // Registration logic
    print('Registering parent: ${nameController.text}');
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

  void setGrade(int grade) {
    selectedGrade.value = grade;
  }

  void registerChild() {
    // Registration logic
    print('Registering child: ${usernameController.text}');
    print('Selected avatar: ${selectedAvatar.value}');
  }

  @override
  void onClose() {
    // Only dispose controllers when the whole controller is being destroyed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    pinController.dispose();
    super.onClose();
  }
}
