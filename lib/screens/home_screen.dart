import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_buy/services/firebase_servieces.dart';
import 'package:ecom_buy/utils/styles.dart';
import 'package:ecom_buy/widgets/home_cards.dart';
import 'package:flutter/material.dart';

List categories = [
  'Grocery Items',
  'Toys',
  'Electronics',
  'Pharmecy',
  'Garments',
  'Costmetics',
];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List images = [
    'https://cdn.pixabay.com/photo/2016/11/23/15/14/jars-1853439_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/06/25/12/48/glasess-1478812_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/06/25/12/48/glasess-1478812_1280.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(actions: [
      //   IconButton(
      //       onPressed: () {
      //         FirebaseServices.signOut();
      //       },
      //       icon: const Icon(Icons.logout))
      // ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Home Screen',
                  style: EcoStyle.boldStyle,
                ),
              ),
              CarouselSlider(
                  items: images
                      .map((e) => Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    child: Image.network(
                                      e,
                                      width: double.infinity,
                                      height: 200,
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(colors: [
                                        Colors.blueAccent.withOpacity(0.3),
                                        Colors.redAccent.withOpacity(0.3),
                                      ])),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Title',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                  options: CarouselOptions(height: 200, autoPlay: true)),
              HomeCards(
                title: categories[0],
              ),
              HomeCards(
                title: categories[1],
              ),
              HomeCards(
                title: categories[2],
              ),
              HomeCards(
                title: categories[3],
              ),
              HomeCards(
                title: categories[4],
              ),
              HomeCards(
                title: categories[5],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
