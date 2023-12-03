// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/inner_screens/burgers_screen.dart';
import 'package:food/screens/admin_btm_bar.dart';
import 'package:food/screens/btm_bar.dart';
import 'package:food/screens/user_registration.dart';
import 'package:food/services/authentication/authentication_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _AddFoodState();
}

final AuthenticationServices _auth = AuthenticationServices();

class _AddFoodState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

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
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
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
                  login();
                },
                child: Text('Login'),
              ),
              Row(
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserRegistration()),
                        );
                      },
                      child: Text("Sign up")),
                  Text("here")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void login() async {
  //   User? authResult = await _auth.userLogin(
  //       _usernameController.text, _passwordController.text);

  //   if (authResult != null) {
  //     print("logged in");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const BottomBarScreen()),
  //     );
  //   } else {
  //     print("login error");
  //   }
  // }
  void login() async {
    User? authResult = await _auth.userLogin(
        _usernameController.text, _passwordController.text);

    if (authResult != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.uid)
              .get();

      if (userSnapshot.exists) {
        String role = userSnapshot.get('role');

        if (role == 'admin') {
          print("logged in as admin");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminBottomBarScreen()),
          );
        } else if (role == 'customer') {
          print("logged in as customer");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BottomBarScreen()),
          );
        } else {
          print("unknown role");
        }
      } else {
        print("user data not found");
      }
    } else {
      print("login error");
    }
  }
}
