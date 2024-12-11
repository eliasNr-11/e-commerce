import 'package:e_commerce/utils/routes/routes.dart';
import 'package:e_commerce/utils/theme/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: false,
      builder: (context, child) => MultiProvider(
        providers: [],
        child: MaterialApp.router(
          title: 'E-Commerce App',
          themeMode: ThemeMode.light,
          theme: GlobalThemData.lightThemeData,
          darkTheme: GlobalThemData.darkThemeData,
          routerConfig: router,
        ),
      ),
    );
  }
}
