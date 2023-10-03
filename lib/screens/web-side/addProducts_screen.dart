import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_buy/models/products_model.dart';
import 'package:ecom_buy/screens/home_screen.dart';
import 'package:ecom_buy/utils/styles.dart';
import 'package:ecom_buy/widgets/button.dart';
import 'package:ecom_buy/widgets/text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const String id = "addProducts";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  TextEditingController brandC = TextEditingController();

  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourite = false;

  String? selectedValue;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imagesUrls = [];
  var uuid = Uuid();
  bool isSaving = false;
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            children: [
              const Text(
                'Add Products',
                style: EcoStyle.boldStyle,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonFormField(
                    hint: const Text('Choose the Category..'),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Please Select the Category";
                      }
                      return null;
                    },
                    value: selectedValue,
                    items: categories
                        .map((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    }),
              ),
              EcoTextField(
                controller: productNameC,
                hintText: "enter product name...",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "should not be empty";
                  }
                  return null;
                },
              ),
              EcoTextField(
                maxLines: 5,
                controller: detailC,
                hintText: "enter product detail...",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "should not be empty";
                  }
                  return null;
                },
              ),
              EcoTextField(
                controller: priceC,
                hintText: "enter product price...",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "should not be empty";
                  }
                  return null;
                },
              ),
              EcoTextField(
                controller: discountPriceC,
                hintText: "enter product discount Price...",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "should not be empty";
                  }
                  return null;
                },
              ),
              EcoTextField(
                controller: serialCodeC,
                hintText: "enter product serial code...",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "should not be empty";
                  }
                  return null;
                },
              ),
              EcoTextField(
                controller: brandC,
                hintText: "enter product brand...",
                validate: (v) {
                  if (v!.isEmpty) {
                    return "should not be empty";
                  }
                  return null;
                },
              ),
              EcoButton(
                title: 'Pick Images',
                isLoginButton: true,
                onPress: () {
                  pickImage();
                },
              ),
              // EcoButton(
              //   title: 'Upload Images',
              //   isLoading: isUploading,
              //   isLoginButton: true,
              //   onPress: () {
              //     // postImages(images[0]);
              //     uploadeImages();
              //   },
              // ),
              Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  File(images[index].path).path,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.cancel_outlined))
                            ],
                          ),
                        );
                      })),
              SwitchListTile(
                  title: const Text("Is this Product on Sale?"),
                  value: isOnSale,
                  onChanged: (v) {
                    setState(() {
                      isOnSale = !isOnSale;
                    });
                  }),
              SwitchListTile(
                  title: const Text("Is this Product Popular?"),
                  value: isPopular,
                  onChanged: (v) {
                    setState(() {
                      isPopular = !isPopular;
                    });
                  }),
              EcoButton(
                title: 'Save',
                isLoading: isSaving,
                isLoginButton: true,
                onPress: () {
                  save();
                },
              )
            ],
          ),
        )),
      ),
    );
  }

  pickImage() async {
    final List<XFile> pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print('Images not selected');
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String? urls;
    Reference ref = FirebaseStorage.instance.ref().child('images').child(
        imageFile!.name); // this line selecet the path on firebase storage
    if (kIsWeb) {
      await ref.putData(
        await imageFile
            .readAsBytes(), // this line get the data any type and then read in bytes form only 0 1
        SettableMetadata(
            contentType:
                'image/jpeg'), // its means get the any type data E.g jpg,png,etc.
      );
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image)
          .then((downLoadUrl) => imagesUrls.add(downLoadUrl));
    }
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await Products.addProducts(Products(
            category: selectedValue,
            id: uuid.v4(),
            brand: brandC.text,
            productName: productNameC.text,
            detail: detailC.text,
            price: int.parse(priceC.text),
            discountPrice: int.parse(discountPriceC.text),
            serialCode: serialCodeC.text,
            imageUrls: imagesUrls,
            isSale: isOnSale,
            isPopular: isPopular,
            isFavourite: isFavourite))
        .whenComplete(() {
      setState(() {
        isSaving = false;
        imagesUrls.clear();
        images.clear();
        clearFields();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("ADDED SUCCESSFULLY")));
      });
    });

    // await uploadeImages();
    // await FirebaseFirestore.instance
    //     .collection('products')
    //     .add({'images': imagesUrls}).whenComplete(() {
    //   setState(() {
    //     isSaving = false;
    //     images.clear();
    //     imagesUrls.clear();
    //   });
    // });
  }

  clearFields() {
    setState(() {
      // selectedValue = "";
      productNameC.clear();
    });
  }
}
