import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/Routes.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';

// Custom Single product item
class RestaurantItem extends StatefulWidget {
  final String name;
  final List<dynamic> image;
  final String address;
  final List<dynamic> cuisine;
  final String id;
  final DocumentSnapshot documentSnapshot;
  const RestaurantItem({super.key,
    required this.image,
    required this.address,
    required this.documentSnapshot,
    required this.id,
    required this.cuisine,
    required this.name,
  });

  @override
  State<RestaurantItem> createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstant.width7),
      margin: EdgeInsets.symmetric(horizontal: AppConstant.width7),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.restaurantDetailsScreen,arguments: {
            'documentSnapshot':widget.documentSnapshot,
          });
        },
        borderRadius: BorderRadius.circular(AppConstant.radius10),
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.all(AppConstant.width10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstant.radius10),
              color: Colors.white,
              // border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: AppConstant.height100,
                width: AppConstant.width150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstant.radius10),
                  child: Image.network(
                    widget.image[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: AppConstant.width10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: AppConstant.width7),
                        child: CustomText(
                          title: widget.name,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstant.font18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: AppConstant.width7),
                        child: CustomText(
                          title: widget.address,
                          fontSize: AppConstant.font15,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(height: AppConstant.height10),
                      SizedBox(
                        height: AppConstant.width70,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: AppConstant.width7),
                              child: CustomText(
                                title: "Cuisine:",
                                fontWeight: FontWeight.w500,
                                fontSize: AppConstant.font18,
                              ),
                            ),
                            SizedBox(width: AppConstant.width7),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: widget.cuisine.length,
                                  itemBuilder: (_, index) {
                                    return CustomText(
                                      title: widget.cuisine[index],
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppConstant.font15,
                                      textAlign: TextAlign.start,
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
