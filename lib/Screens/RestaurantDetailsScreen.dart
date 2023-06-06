import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/CustomColor.dart';
import 'package:my_app/constants/Routes.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  const RestaurantDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  DocumentSnapshot? documentSnapshot;
  bool _init = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      var mapValue =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      if (mapValue['documentSnapshot'] != null) {
        documentSnapshot = mapValue['documentSnapshot'];
      }
      _init = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: AppConstant.height200,
              width: double.infinity,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: AppConstant.height200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration:
                      const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                ),
                items: documentSnapshot!['image'].map<Widget>((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        child: Image.network(
                          i,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: blueColor,
                          size: AppConstant.icon24,
                        ))
                  ],
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: AppConstant.height120),
                    padding: EdgeInsets.symmetric(
                      vertical: AppConstant.height20,
                      horizontal: AppConstant.width20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppConstant.radius40),
                        topRight: Radius.circular(AppConstant.radius40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: documentSnapshot!['name'],
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstant.font20,
                              ),
                              CustomText(
                                title: documentSnapshot!['address'],
                                fontSize: AppConstant.font18,
                                color: Colors.black45,
                              ),
                              SizedBox(height: AppConstant.height15),
                              CustomText(
                                title: 'Features',
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstant.font18,
                              ),
                              SizedBox(height: AppConstant.height10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: 'Quality Customer Service',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: 'Simple Booking',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: AppConstant.height7),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: 'Fully AC',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: 'Free WiFi',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: AppConstant.height7),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title:
                                                'Clean and Tidy Environment',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppConstant.height15),
                              CustomText(
                                title: 'Facilities',
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstant.font18,
                              ),
                              SizedBox(height: AppConstant.height10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: 'Free Parking',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: 'Waiting Area',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: AppConstant.height7),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: 'Swimming pool',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: '24 Hour security',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: AppConstant.height7),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppConstant.radius90)),
                                        ),
                                        SizedBox(width: AppConstant.width7),
                                        Expanded(
                                          child: CustomText(
                                            title: 'Poolside bar',
                                            fontSize: AppConstant.font15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppConstant.height15),
                              CustomText(
                                title: 'Cuisine',
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstant.font18,
                              ),
                              SizedBox(height: AppConstant.height10),
                              SizedBox(width: AppConstant.width7),
                              Expanded(
                                child: ListView.builder(
                                    itemCount:
                                        documentSnapshot!['cusines'].length,
                                    itemBuilder: (_, index) {
                                      return CustomText(
                                        title: documentSnapshot!['cusines']
                                            [index],
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppConstant.font15,
                                        textAlign: TextAlign.start,
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: AppConstant.width20,
                          ),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.bookTable,
                                  arguments: {
                                    'restaurantName':
                                        documentSnapshot!['name'],
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: AppConstant.height15,
                              ),
                            ),
                            child: CustomText(
                              title: 'Book Your Table',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstant.font16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
