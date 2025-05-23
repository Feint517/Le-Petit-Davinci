import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/features/splash/screens/splash_screen.dart';
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

    // Initialiser le contrôleur de mascotte
    if (!Get.isRegistered<MascotController>()) {
      Get.put(MascotController(), permanent: true);
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
      home: const SplashScreen(),

      //* Disable any initial route bindings that might override the home screen
      initialRoute: null,
    );
  }
}
