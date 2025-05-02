import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kids_learning_app/app.dart';
import 'package:kids_learning_app/data/repositories/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* init local storage
  await GetStorage.init();
  Get.put(AuthenticationRepository());

  runApp(const App());
}