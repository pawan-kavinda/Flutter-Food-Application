import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/consts/theme_data.dart';
import 'package:food/inner_screens/burgers_screen.dart';
import 'package:food/inner_screens/cartitems.dart';
import 'package:food/inner_screens/feeds_screen.dart';
import 'package:food/inner_screens/on_sale_screen.dart';
import 'package:food/provider/dark_theme_provider.dart';
import 'package:food/screens/admin_btm_bar.dart';
import 'package:food/screens/btm_bar.dart';
import 'package:food/screens/categories.dart';
import 'package:food/screens/home_screen.dart';
import 'package:food/screens/login.dart';
import 'package:food/screens/user_registration.dart';
import 'package:food/services/dark_theme_pref.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: BottomBarScreen(),
          routes: {
            OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
            FeedScreen.routeName: (ctx) => const FeedScreen(),
          },
        );
      }),
    );
  }
}
