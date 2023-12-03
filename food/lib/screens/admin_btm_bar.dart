import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food/inner_screens/feeds_screen.dart';
import 'package:food/provider/dark_theme_provider.dart';
import 'package:food/screens/add_food.dart';
import 'package:food/screens/categories.dart';
import 'package:provider/provider.dart';

class AdminBottomBarScreen extends StatefulWidget {
  const AdminBottomBarScreen({super.key});

  @override
  State<AdminBottomBarScreen> createState() => _AdminBottomBarScreenState();
}

class _AdminBottomBarScreenState extends State<AdminBottomBarScreen> {
  int _selectedIndex = 0;
  final List _pages = [
    const FeedScreen(),
    CategoriesScreen(),
    const AddFood(),
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
          unselectedItemColor: _isDark ? Colors.white : Colors.black,
          selectedItemColor: _isDark ? Colors.blue : Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _selectedPage,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: "Products"),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 2 ? IconlyBold.plus : IconlyLight.plus),
                label: "Add"),
          ]),
    );
  }
}
