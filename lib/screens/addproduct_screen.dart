import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../reuseable widget/text_constraint.dart';
import 'mainscreen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _typeTextController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final TextEditingController _sizeTextController = TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();
  final TextEditingController _phonenumberTextController =
      TextEditingController();
  final TextEditingController _bathroomTextController = TextEditingController();
  final TextEditingController _bedroomTextController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('ad_list');
  List<String> imageUrls = [];

  // String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope is used to handle keyboard-related interactions
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: Icon(
                color: Colors.black,
                Icons.arrow_back_ios_sharp,
                size: 30,
              )),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: PText('Add Your Place', color: Colors.black, fontSize: 22),
        ),
        body: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: key,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _typeTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Type',
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                      filled: true,
                      fillColor: Color(0xFFEAEAEA),
                      hintText: 'Flat / House',
                      hintStyle: TextStyle(fontSize: 20.0, letterSpacing: 2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Ad Type Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _priceTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                      filled: true,
                      fillColor: Color(0xFFEAEAEA),
                      hintText: '2000',
                      hintStyle: TextStyle(fontSize: 20.0, letterSpacing: 2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Ad Price Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _descriptionTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                      filled: true,
                      fillColor: Color(0xFFEAEAEA),
                      hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 20.0, letterSpacing: 2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Ad Description Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _locationTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                      filled: true,
                      fillColor: Color(0xFFEAEAEA),
                      hintText: 'F.B Area',
                      hintStyle: TextStyle(fontSize: 20.0, letterSpacing: 2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Ad Location Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _sizeTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Size',
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                      filled: true,
                      fillColor: Color(0xFFEAEAEA),
                      hintText: '1200 sqft',
                      hintStyle: TextStyle(fontSize: 20.0, letterSpacing: 2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Ad size Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _bathroomTextController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Bathroom',
                            labelStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                            filled: true,
                            fillColor: Color(0xFFEAEAEA),
                            hintText: '1,2,3',
                            hintStyle:
                                TextStyle(fontSize: 20.0, letterSpacing: 2),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'How Many Bathroom';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _bedroomTextController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Bedroom',
                            labelStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                            filled: true,
                            fillColor: const Color(0xFFEAEAEA),
                            hintText: '1,2,3',
                            hintStyle: const TextStyle(
                                fontSize: 20.0, letterSpacing: 2),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'How Many Bedroom';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _phonenumberTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                      filled: true,
                      fillColor: Color(0xFFEAEAEA),
                      hintText: '03211234578',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, letterSpacing: 2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number  Required';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () async {
                          final ImagePicker imagePicker = ImagePicker();
                          List<XFile>? imageFileList = [];

                          void selectImages() async {
                            final List<XFile>? selectedImages =
                                await imagePicker.pickMultiImage();
                            if (selectedImages != null &&
                                selectedImages.isNotEmpty) {
                              imageFileList!.addAll(selectedImages);
                            }
                            print(
                                "Image List Length: ${imageFileList!.length}");
                            setState(() {});
                          }

                          XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery,
                          );
                          print('${file?.path}');

                          if (file == null) return;
                          //Import dart:core
                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);

                          //Handle errors/success
                          try {
                            //Store the file
                            await referenceImageToUpload
                                .putFile(File(file!.path));
                            //Success: get the download URL
                            // String imageUrl =
                            //     await referenceImageToUpload.getDownloadURL();
                            // imageUrls.add(imageUrl); // Add URL to list
                            String imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                            imageUrls.add(imageUrl);
                            print("Image URL: $imageUrl");
                          } catch (error) {
                            //Some error occurred
                          }
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 70,
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xff2e7b5b), // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                      ),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (key.currentState!.validate()) {
                        String type = _typeTextController.text;
                        String location = _locationTextController.text;
                        String phonenumber = _phonenumberTextController.text;
                        String bedroom = _bedroomTextController.text;
                        String bathroom = _bathroomTextController.text;

                        String description = _descriptionTextController.text;
                        String price = _priceTextController.text;

                        String size = _sizeTextController.text;

                        Map<String, dynamic> dataToSend = {
                          'type': type,
                          'location': location,
                          'description': description,
                          'price': price,
                          'phonenumber': phonenumber,
                          'bathroom': bathroom,
                          'bedroom': bedroom,
                          'size': size,
                          'imageUrls': imageUrls,
                        };

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ));
                        _reference.add(dataToSend);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
