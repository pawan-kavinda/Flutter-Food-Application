// ignore_for_file: prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/inner_screens/feeds_screen.dart';
import 'package:food/inner_screens/on_sale_screen.dart';
import 'package:food/provider/dark_theme_provider.dart';
import 'package:food/services/global_methods.dart';
import 'package:food/services/widgets/feed_items.dart';
import 'package:food/services/widgets/on_sale_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _foodstream =
      FirebaseFirestore.instance.collection('foods').snapshots();
  final List<String> _offerImages = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  _offerImages[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: 3,
              pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: Colors.red)),
              control: SwiperControl(),
            ),
          ),
          TextButton(
              onPressed: () {
                GlobalMethods.navigateTo(
                    ctx: context, routeName: OnSaleScreen.routeName);
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              )),
          SizedBox(
            height: 180,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return OnSaleWidget();
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Our foods",
                  style: TextStyle(fontSize: 22),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: FeedScreen.routeName);
                    },
                    child: Text(
                      "Brows all",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    )),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            childAspectRatio: 250 / 300,
            children: List.generate(1, (index) {
              //return FeedsWidget();
              return FeedsWidget();
            }),
          )
        ],
      ),
    ));
  }
}
