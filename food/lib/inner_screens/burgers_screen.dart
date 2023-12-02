// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/cart.dart';
import 'cartitems.dart';

class BurgerScreen extends StatefulWidget {
  const BurgerScreen({super.key});

  @override
  State<BurgerScreen> createState() => _BurgerScreenState();
}

class _BurgerScreenState extends State<BurgerScreen> {
  List<QueryDocumentSnapshot<Object?>> data = [];
  //cartitems cartItems = cartitems();
  cartitems cartItems = cartitems();
  // List<String> cartItemTitle = [];
  // List<int> cartItemPrice = [];
  // List<String> cartItemImg = [];

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("foods")
        .where("category", isEqualTo: "burger")
        .get();
    data.addAll(querySnapshot.docs);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Burgers"),
      ),
      body: GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 300 / 360),
          itemBuilder: (context, i) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "${data[i]["foodname"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Image.asset('assets/images/${data[i]["imgname"]}.png'),
                    TextButton(
                        onPressed: () {
                          cartItems.returntitle(data[i]["foodname"]);
                          cartItems.returnPrice(data[i]["price"]);
                          cartItems.returnImg(data[i]["imageurl"]);
                        },
                        child: Text("Add to cart")),
                    Text(data[i]["price"].toString()),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
