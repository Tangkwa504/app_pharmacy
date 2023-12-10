//import 'package:app_pharmacy/menu/home_screen.dart';
import 'dart:async';

import 'package:app_pharmacy/app_router.dart';
import 'package:app_pharmacy/core/get_it/configure_dependencies.dart';
import 'package:app_pharmacy/core/get_it/di_instance.dart';
import 'package:app_pharmacy/core/route/app_navigator.dart';
import 'package:app_pharmacy/first_page.dart';
//import 'package:app_pharmacy/login/login_screen.dart';
//import 'package:app_pharmacy/profile/setting_profile.dart';
import 'package:app_pharmacy/widgets/Service.dart';
import 'package:app_pharmacy/widgets/base_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//import 'chatmockup.dart';
//import 'login/login_test.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      );

      await MyApp.initialize();

      runApp(const MyApp());
    },
    (error, stack) => Text('$error'),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static Future<void> initialize() async {
    try {
      await getIt.reset();

      await configureDependencies();

      await getIt.allReady(timeout: const Duration(seconds: 5));
    } catch (e) {
      print(e);
    }
    return;
  }
}

class _MyAppState extends BaseState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _appNavigator = getIt<AppNavigator>();
    appservice.email = "1"; // คำสั่งกำหนดค่าให้ตัวแปรที่จะเก็บเข้า Service
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderSer()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => Useridprovider()),
        ChangeNotifierProvider(create: (_) => Orderprovider()),
      ],
      child: MaterialApp(
        navigatorKey: _appNavigator.navigatorKey,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.initialRouterName,
        onGenerateRoute: AppRouter.router,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) {
          return SizedBox(
            child: child,
          );
        },
      ),
    );
  }
}
