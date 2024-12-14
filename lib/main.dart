import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/services/category_service.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:e_commerce/utils/routes/routes.dart';
import 'package:e_commerce/utils/theme/theme_data.dart';
import 'package:e_commerce/viewmodels/auth_viewmodel.dart';
import 'package:e_commerce/viewmodels/cart_viewmodel.dart';
import 'package:e_commerce/viewmodels/explore_viewmodel.dart';
import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:e_commerce/viewmodels/profile_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');
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
        providers: [
          Provider(create: (_) => ProductService()),
          ChangeNotifierProvider(create: (context) => AuthViewModel()),
          ChangeNotifierProvider(
            create: (context) => HomeViewModel(context.read<ProductService>()),
          ),
          Provider<CategoryService>(create: (_) => CategoryService()),
          ChangeNotifierProvider<ExploreViewModel>(
            create: (context) =>
                ExploreViewModel(context.read<CategoryService>()),
          ),
          ChangeNotifierProvider(create: (context) => CartViewModel()),
          ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ],
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
