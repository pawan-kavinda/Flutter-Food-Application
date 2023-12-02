// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/screens/add_food.dart';
import 'package:food/screens/login.dart';
import 'package:food/services/authentication/authentication_services.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

final AuthenticationServices _auth = AuthenticationServices();

class _UserRegistrationState extends State<UserRegistration> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  //Future login() async {}
  // Future add() async {
  //   await addNewFood(
  //       _usernameController.text.trim(),

  //      _passwordController.text.trim(),);
  // }

  // Future addNewFood(
  //     String title, int price, int discountprice, String imgurl) async {
  //   await FirebaseFirestore.instance.collection('foods').add({
  //     'title': title,
  //     'price': price,
  //     'discountprice': discountprice,
  //     'imgurl': imgurl
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email address',
                ),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'User name',
                ),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              TextButton(
                onPressed: () {
                  _auth.createUser(
                      _emailController.text,
                      _passwordController.text,
                      _usernameController.text,
                      _addressController.text);
                  _emailController.clear();
                  _passwordController.clear();
                  _usernameController.clear();
                  _addressController.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: Text('Sign Up'),
              ),
              Row(
                children: [
                  Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: Text("Sign in")),
                  Text("here")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//   void createUser() async {
//     dynamic result =
//         await _auth.createUser(_emailController.text, _passwordController.text);
//     if (result == null) {
//       print("Email is not valid");
//     } else {
//       print(result.toString());
//     }
//   }
}
