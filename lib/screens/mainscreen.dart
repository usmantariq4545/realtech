import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtech/screens/calculation_screem.dart';

import '../reuseable widget/text_constraint.dart';
import 'addproduct_screen.dart';
import 'detail_page.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('ad_list');
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              //get the data
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              //          Convert the documents to Maps
              List<Map> ads = documents
                  .map((e) => {
                        'bedroom': e['bedroom'],
                        'bathroom': e['bathroom'],
                        'id': e.id,
                        'type': e['type'],
                        'location': e['location'],
                        'size': e['size'],
                        'price': e['price'],
                        //  'price': e['price'],
                        //    'imageUrl': e['image'],
                        'imageUrls': e['imageUrls'],
                      })
                  .toList();

              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: PText(
                            "Properties",
                            weight: FontWeight.w500,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MainScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 2),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: PText(
                                      'Available',
                                      color: Color(0xff2e7b5b),
                                      fontSize: 16,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                )),
                          ),
                          Flexible(
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddProductScreen(),
                                    ),
                                  );
                                },
                                child: PText(
                                  'Sell',
                                  color: Color(0xff2e7b5b),
                                  fontSize: 16,
                                  weight: FontWeight.w500,
                                )),
                          ),
                          Flexible(
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CalculationScreen(),
                                    ),
                                  );
                                },
                                child: PText(
                                  'Price Prediction',
                                  color: Color(0xff2e7b5b),
                                  fontSize: 16,
                                  weight: FontWeight.w500,
                                )),
                          ),
                        ],
                      ),
                      ListView.builder(
                        itemCount: ads.length,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // Disable outer ListView scrolling
                        itemBuilder: (BuildContext context, int index) {
                          Map thisAd = ads[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AdDetail(thisAd['id'])));
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 2),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: thisAd.containsKey(
                                                        'imageUrls') &&
                                                    thisAd['imageUrls']
                                                        .isNotEmpty
                                                ? Image.network(
                                                    '${thisAd['imageUrls'][0]}',
                                                    fit: BoxFit.fill,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  )
                                                : Container(),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    PText(
                                                      '${thisAd['type']}'
                                                          .toUpperCase(),
                                                      fontSize: 22,
                                                      weight: FontWeight.bold,
                                                    ),
                                                    Spacer(),
                                                    PText(
                                                      '${thisAd['price']}',
                                                      fontSize: 19,
                                                      weight: FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: PText(
                                                    '${thisAd['location']}',
                                                    fontSize: 15,
                                                    // weight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Icon(
                                                              Icons
                                                                  .bed_outlined,
                                                              size: 30,
                                                              color: Color(
                                                                  0xff2e7b5b),
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                          PText(
                                                            '${thisAd['bedroom']} Bedroom',
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Icon(
                                                                Icons
                                                                    .shower_outlined,
                                                                size: 30,
                                                                color: Color(
                                                                    0xff2e7b5b)),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                          PText(
                                                            '${thisAd['bathroom']} Bathroom',
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Icon(
                                                                Icons
                                                                    .house_outlined,
                                                                size: 30,
                                                                color: Color(
                                                                    0xff2e7b5b)),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                          PText(
                                                            '${thisAd['size']} Size',
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
