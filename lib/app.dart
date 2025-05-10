import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kids_learning_app/features/home/screens/home_sceen.dart';
import 'package:kids_learning_app/features/lessons/screens/alphabets/alphabet_introduction.dart';
import 'package:kids_learning_app/features/lessons/screens/alphabets/alphabet_lesson.dart';
import 'package:kids_learning_app/features/lessons/screens/construction/construction_exercice.dart';
import 'package:kids_learning_app/features/lessons/screens/construction/construction_learn.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/font_manager.dart';
import 'package:kids_learning_app/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //* Configure system UI for better splash experience
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    //* Ensure GetStorage is initialized
    try {
      GetStorage();
    } catch (e) {
      if (kDebugMode) {
        print("GetStorage error: $e");
      }
    }

    if (kDebugMode) {
      print("Initializing app with SplashScreen as home");
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: false,
      locale: DevicePreview.locale(context),
      builder: (context, child) {
        return FontScale.scaleBuilder(
          context,
          child,
          DevicePreview.appBuilder, // Pass DevicePreview's builder
        );
      },
      themeMode: ThemeMode.system,
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,

      //* Explicitly set home to SplashScreen and prevent any automatic redirects
      home: const ExercisePage(day: 1),

      //* Disable any initial route bindings that might override the home screen
      initialRoute: null,
    );
  }
}
