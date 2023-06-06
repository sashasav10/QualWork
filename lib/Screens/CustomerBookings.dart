import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/CustomColor.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';

class CustomerBookings extends StatefulWidget {
  const CustomerBookings({Key? key}) : super(key: key);

  @override
  State<CustomerBookings> createState() => _CustomerBookingsState();
}

class _CustomerBookingsState extends State<CustomerBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkWhite,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Text(
          ' All Bookings ',
          style: TextStyle(
            fontSize: AppConstant.font20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
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

                                  if (products['uid'] ==
                                      FirebaseAuth.instance.currentUser!.uid) {
                                    return Container(
                                      padding:
                                          EdgeInsets.all(AppConstant.width7),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: AppConstant.width7),
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(
                                            AppConstant.radius10),
                                        child: Ink(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(
                                              AppConstant.width10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                AppConstant.radius10),
                                            color: Colors.white,
                                            // border: Border.all(color: Colors.grey),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CustomText(
                                                    title: 'Restaurant Name : ',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        AppConstant.font16,
                                                  ),
                                                  CustomText(
                                                    title: products[
                                                        'restaurantName'],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        AppConstant.font16,
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
                                                    fontSize:
                                                        AppConstant.font16,
                                                  ),
                                                  CustomText(
                                                    title: products['date'],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        AppConstant.font16,
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
                                                    fontSize:
                                                        AppConstant.font16,
                                                  ),
                                                  CustomText(
                                                    title: products['time'],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        AppConstant.font16,
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
                                                    fontSize:
                                                        AppConstant.font16,
                                                  ),
                                                  CustomText(
                                                    title:
                                                        products['noOfPeoples'],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        AppConstant.font16,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: AppConstant.height3,
                                              ),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    title: 'Booking status : ',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppConstant.font16,
                                                  ),
                                                  CustomText(
                                                    title: products['bookingConfirm'],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: AppConstant.font16,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
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
