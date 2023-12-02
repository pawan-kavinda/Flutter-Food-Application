import 'package:flutter/material.dart';
import 'package:food/inner_screens/burgers_screen.dart';
import 'package:food/inner_screens/deserts_screen.dart';
import 'package:food/inner_screens/kottu_screen.dart';
import 'package:food/inner_screens/salads_screen.dart';
import 'package:food/services/widgets/categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  List<Map<String, dynamic>> catinfo = [
    {
      'imgPath': 'assets/images/burger.png',
      'catText': 'Burgers',
    },
    {'imgPath': 'assets/images/kottu.png', 'catText': 'Kottu'},
    {'imgPath': 'assets/images/rice.png', 'catText': 'Rice'},
    {'imgPath': 'assets/images/desert.png', 'catText': 'Deserts'},
    {'imgPath': 'assets/images/soup.png', 'catText': 'Soups'},
    {'imgPath': 'assets/images/salad.png', 'catText': 'Salads'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
            appBar: AppBar(
              elevation: 5,
              backgroundColor: Colors.black,
              title: Text(
                "Categories",
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
            ),
            // body: GridView.count(
            //     crossAxisCount: 2,
            //     childAspectRatio: 300 / 250,
            //     crossAxisSpacing: 30,
            //     mainAxisSpacing: 30,
            //     children: List.generate(6, (index) {
            //       return CategoriesWidget(
            //         catText: catinfo[index]['catText'],
            //         imgPath: catinfo[index]['imgPath'],
            //         color: Colors.amber,
            //       );
            //     }
            //     ))),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              childAspectRatio: 300 / 360,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                InkWell(
                  child: Column(
                    children: [
                      const Text("Burgers"),
                      Image.asset('assets/images/burger.png')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BurgerScreen()),
                    );
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      const Text("Salads"),
                      Image.asset('assets/images/salad.png')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SaladsScreen()),
                    );
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      const Text("Kottu"),
                      Image.asset('assets/images/kottu.png')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KottuScreen()),
                    );
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      const Text("Deserts"),
                      Image.asset('assets/images/desert.png')
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DesertsScreen()),
                    );
                  },
                ),
              ],
            )));
  }
}
