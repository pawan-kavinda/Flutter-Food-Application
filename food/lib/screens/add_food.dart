// ignore_for_file: prefer_const_constructors
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountpriceController = TextEditingController();
  final _imgurlController = TextEditingController();
  final _categoryController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  File? _image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _discountpriceController.dispose();
    _imgurlController.dispose();
    _categoryController.dispose();
  }

  // Future add() async {
  //   await addNewFood(
  //       _titleController.text.trim(),
  //       int.parse(_priceController.text.trim()),
  //       int.parse(_discountpriceController.text.trim()),
  //       _imgurlController.text.trim(),
  //       _categoryController.text.trim(),
  //       );
  // }

  // Future addNewFood(String title, int price, int discountprice, String imgurl,
  //     String category) async {
  //   await FirebaseFirestore.instance.collection('foods').add({
  //     'foodname': title,
  //     'price': price,
  //     'discountprice': discountprice,
  //     'imgname': imgurl,
  //     'category': category,
  //     'imgpath': _image
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
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Food name',
                ),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: 'Price',
                ),
              ),
              TextField(
                controller: _discountpriceController,
                decoration: InputDecoration(
                  hintText: 'Discount Price',
                ),
              ),
              TextField(
                controller: _imgurlController,
                decoration: InputDecoration(
                  hintText: 'Image URL',
                ),
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  hintText: 'food type',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    _image = File(image.path);
                  }
                },
                child: Text('Select image'),
              ),
              TextButton(
                onPressed: () async {
                  var imageName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  var storageRef = FirebaseStorage.instance
                      .ref()
                      .child('food_images/$imageName.jpg');
                  var uploadTask = storageRef.putFile(_image!);
                  var downloadUrl =
                      await (await uploadTask).ref.getDownloadURL();
                  FirebaseFirestore.instance.collection('foods').add({
                    'foodname': _titleController.text,
                    'price': int.parse(_priceController.text),
                    'discountprice': int.parse(_discountpriceController.text),
                    'imgname': _imgurlController.text,
                    'category': _categoryController.text,
                    'imageurl': downloadUrl
                  });
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
