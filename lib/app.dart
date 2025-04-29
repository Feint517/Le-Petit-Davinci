import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kids_learning_app/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:kids_learning_app/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,
      //? when the app runs, it will automatically initiate all the methods in GeneralBindings
      //initialBinding: GeneralBindings(),
      home: const WelcomeScreen(),
    );
  }
}
