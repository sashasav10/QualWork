import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/AuthMethods.dart';
import 'package:my_app/constants/CommonMethods.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';
import 'package:my_app/custom%20widgets/LoadingWidget.dart';
import 'package:intl/intl.dart';

import '../../constants/Routes.dart';

class ManagerAddRestaurant extends StatefulWidget {
  const ManagerAddRestaurant({Key? key}) : super(key: key);

  @override
  State<ManagerAddRestaurant> createState() => _ManagerAddRestaurantState();
}

class _ManagerAddRestaurantState extends State<ManagerAddRestaurant> {
  bool _isLoading = false;
  String restaurantName = '';
  List<String> cuisinesList = [];
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cuisinesController = TextEditingController();
  final TextEditingController _imagesController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _init = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppConstant.height20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: CustomText(
                  title: 'Address',
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstant.width20,
                    vertical: AppConstant.height2),
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppConstant.height10,
                      horizontal: AppConstant.width5,
                    ),
                    hintText: 'address',
                  ),
                ),
              ),
              SizedBox(height: AppConstant.height10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: InkWell(
                  onTap: () async {
                    var result =
                        await Navigator.pushNamed(context, Routes.filtersScreen);
                    setState(() {
                      cuisinesList = result as List<String>;
                    });
                  },
                  child: CustomText(
                        title: 'Add cuisines: $cuisinesList',
                      ),
                ),
              ),
              SizedBox(height: AppConstant.height10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: CustomText(
                  title: 'Images',
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstant.width20,
                    vertical: AppConstant.height2),
                child: TextField(
                  controller: _imagesController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppConstant.height10,
                      horizontal: AppConstant.width5,
                    ),
                    hintText: 'please split links by ", "',
                  ),
                ),
              ),
              SizedBox(height: AppConstant.height10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: CustomText(
                  title: 'Lat',
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstant.width20,
                    vertical: AppConstant.height2),
                child: TextField(
                  controller: _latController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppConstant.height10,
                      horizontal: AppConstant.width5,
                    ),
                    hintText: 'lat',
                  ),
                ),
              ),
              SizedBox(height: AppConstant.height10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: CustomText(
                  title: 'Long',
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstant.width20,
                    vertical: AppConstant.height2),
                child: TextField(
                  controller: _longController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppConstant.height10,
                      horizontal: AppConstant.width5,
                    ),
                    hintText: 'long',
                  ),
                ),
              ),
              SizedBox(height: AppConstant.height10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: CustomText(
                  title: 'Name',
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstant.width20,
                    vertical: AppConstant.height2),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppConstant.height10,
                      horizontal: AppConstant.width5,
                    ),
                    hintText: 'Name',
                  ),
                ),
              ),
              SizedBox(height: AppConstant.height20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppConstant.width20),
                width: double.infinity,
                child: _isLoading
                    ? LoadingWidget()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_addressController.text.trim().isEmpty) {
                            if (mounted) {
                              AppConstant.showToastMessage(
                                  context, 'Please enter complete details !!');
                            }
                          } else {
                            hideKeyBoard(context);
                            _saveData();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AppConstant.height15,
                          ),
                        ),
                        child: CustomText(
                          title: 'Add',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstant.font16,
                        ),
                      ),
              ),
              SizedBox(
                height: AppConstant.height30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method for save the data of table booking by customer in firebase
  void _saveData() async {
    setState(() {
      _isLoading = true;
    });

    String result = await AuthMethods().addRestaurantData(
        address: _addressController.text.trim(),
        cusines: cuisinesList,
        image: _imagesController.text.split(", "),
        lat: _latController.text.trim(),
        long: _longController.text.trim(),
        name: _nameController.text.trim());
    if (result != 'success') {
      if (mounted) {
        AppConstant.showToastMessage(context, result);
      }
    } else {
      if (mounted) {
        AppConstant.showToastMessage(context, 'Booking created successfully.');
        Navigator.pop(context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }
}
