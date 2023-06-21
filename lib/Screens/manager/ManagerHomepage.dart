import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/CustomColor.dart';
import 'package:my_app/constants/Routes.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';

class ManagerHomepage extends StatefulWidget {
  const ManagerHomepage({Key? key}) : super(key: key);

  @override
  State<ManagerHomepage> createState() => _ManagerHomepageState();
}

class _ManagerHomepageState extends State<ManagerHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkWhite,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          ' List of Bookings ',
          style: TextStyle(
            fontSize: AppConstant.font20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, Routes.managerRestaurant);
            },
            icon: const Icon(Icons.house),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.signIn, (route) => false);
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: AppConstant.height10),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("booking").snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : snapshot.data!.docs.isEmpty
                      ? Center(
                          child: CustomText(
                            title: 'No Booking Found',
                            fontSize: AppConstant.font18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(height: AppConstant.height10),
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot products =
                                      snapshot.data!.docs[index];

                                  return Container(
                                    padding: EdgeInsets.all(AppConstant.width7),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: AppConstant.width7),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.managerBookingEdit,
                                            arguments: {
                                              'uid':snapshot
                                                  .data!
                                                  .docs[index]
                                                  .id,
                                              'restaurantName':products['restaurantName'],
                                              'date':products['date'],
                                              'time':products['time'],
                                              'noOfPeoples':products['noOfPeoples'],
                                            });
                                      },
                                      borderRadius: BorderRadius.circular(
                                          AppConstant.radius10),
                                      child: Ink(
                                        width: double.infinity,
                                        padding:
                                            EdgeInsets.all(AppConstant.width10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppConstant.radius10),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CustomText(
                                                  title: 'Restaurant Name : ',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppConstant.font16,
                                                ),
                                                CustomText(
                                                  title: products[
                                                      'restaurantName'],
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AppConstant.font16,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: AppConstant.height3),
                                            Row(
                                              children: [
                                                CustomText(
                                                  title: 'Date : ',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppConstant.font16,
                                                ),
                                                CustomText(
                                                  title: products['date'],
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AppConstant.font16,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: AppConstant.height3),
                                            Row(
                                              children: [
                                                CustomText(
                                                  title: 'Time : ',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppConstant.font16,
                                                ),
                                                CustomText(
                                                  title: products['time'],
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AppConstant.font16,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: AppConstant.height3),
                                            Row(
                                              children: [
                                                CustomText(
                                                  title: 'No of Peoples : ',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppConstant.font16,
                                                ),
                                                CustomText(
                                                  title:
                                                      products['noOfPeoples'],
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AppConstant.font16,
                                                ),
                                              ],
                                            ),
                                            products['bookingConfirm'] !=
                                                    'Processing'
                                                ? Container()
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'booking')
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id)
                                                              .update({
                                                            'bookingConfirm':
                                                                'Decline'
                                                          });
                                                        },
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppConstant
                                                                    .radius7),
                                                        child: Ink(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical:
                                                                AppConstant
                                                                    .width7,
                                                            horizontal:
                                                                AppConstant
                                                                    .width7,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    AppConstant
                                                                        .radius7),
                                                          ),
                                                          child: CustomText(
                                                            title: 'Decline',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                AppConstant
                                                                    .font15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: AppConstant
                                                              .width5),
                                                      InkWell(
                                                        onTap: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'booking')
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id)
                                                              .update({
                                                            'bookingConfirm':
                                                                'Confirm'
                                                          });
                                                        },
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppConstant
                                                                    .radius7),
                                                        child: Ink(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical:
                                                                AppConstant
                                                                    .width7,
                                                            horizontal:
                                                                AppConstant
                                                                    .width7,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    AppConstant
                                                                        .radius7),
                                                          ),
                                                          child: CustomText(
                                                            title:
                                                                'Confirm Booking',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                AppConstant
                                                                    .font15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
            },
          ),
        ),
      ),
    );
  }
}
