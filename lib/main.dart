import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Favourite/FavouriteScreen.dart';
import 'LoginSinupScreen/ChangePasswordScreen.dart';
import 'LoginSinupScreen/LoginScreen.dart';
import 'Profile/EditProfileScreen.dart';
import 'Profile/ProfileScreen.dart';
import 'Profile/ViewProfileScreen.dart';
import 'Provider/Authprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => authprovider(),
            ),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Colors.black.withOpacity(0.4),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: LoginScreen(),
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
