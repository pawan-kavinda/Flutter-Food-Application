// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/inner_screens/cartitems.dart';

class SaladsScreen extends StatefulWidget {
  const SaladsScreen({super.key});

  @override
  State<SaladsScreen> createState() => _SaladsScreenState();
}

class _SaladsScreenState extends State<SaladsScreen> {
  List<QueryDocumentSnapshot<Object?>> data = [];
  cartitems cartItems = cartitems();

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("foods")
        .where("category", isEqualTo: "salad")
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
        title: Text("Salads"),
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
                        child: Text("Add to cart"))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
