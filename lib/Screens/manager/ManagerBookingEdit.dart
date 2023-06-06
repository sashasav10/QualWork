import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/CommonMethods.dart';
import 'package:my_app/constants/CustomColor.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';
import 'package:my_app/custom%20widgets/LoadingWidget.dart';

class ManagerBookingEdit extends StatefulWidget {
  const ManagerBookingEdit({Key? key}) : super(key: key);

  @override
  State<ManagerBookingEdit> createState() => _ManagerBookingEditState();
}

class _ManagerBookingEditState extends State<ManagerBookingEdit> {

  bool _isLoading = false;

  String uid='';
  String restaurantName='';
  String date='';
  String time='';
  String noOfPeoples='';

  bool _init = true;
  late TextEditingController _noOfPeoplesController;
  late DateTime selectedDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      // get the data from previous screen from arguments
      var mapValue = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      if (mapValue['uid'] != null) {
        uid = mapValue['uid'];
      }
      if (mapValue['restaurantName'] != null) {
        restaurantName = mapValue['restaurantName'];
      }
      if (mapValue['date'] != null) {
        date = mapValue['date'];
      }
      selectedDate = DateTime.parse(date);
      if (mapValue['time'] != null) {
        time = mapValue['time'];
      }
      if (mapValue['noOfPeoples'] != null) {
        noOfPeoples = mapValue['noOfPeoples'];
      }
      _noOfPeoplesController = TextEditingController(text: noOfPeoples);
      _init = false;
    }
  }


  // Method for select date and open the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year, selectedDate.month),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Method for select time and open the time picker
  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkWhite,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Text(
          ' Edit Booking ',
          style: TextStyle(
            fontSize: AppConstant.font20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppConstant.height10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppConstant.height30),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: CustomText(
                  title: 'Date',
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppConstant.width20,
                  vertical: AppConstant.height4,
                ),
                child: InkWell(
                  onTap: () async {
                    _selectDate(context);
                  },
                  borderRadius: BorderRadius.circular(AppConstant.radius7),
                  child: Ink(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstant.width7,
                      vertical: AppConstant.height10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                      BorderRadius.circular(AppConstant.radius7),
                    ),
                    child: CustomText(
                      title: "${selectedDate.toLocal()}".split(' ')[0],
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppConstant.height10),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: CustomText(
                  title: 'Time',
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppConstant.width20,
                  vertical: AppConstant.height4,
                ),
                child: InkWell(
                  onTap: () async {
                    TimeOfDay? tt = await getTime(context: context);
                    String aa = tt
                        .toString()
                        .split("(")
                        .last
                        .replaceAll(")", '')
                        .replaceAll("(", '');
                    setState(() {
                      time = aa;
                    });
                  },
                  borderRadius: BorderRadius.circular(AppConstant.radius7),
                  child: Ink(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstant.width7,
                      vertical: AppConstant.height10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                      BorderRadius.circular(AppConstant.radius7),
                    ),
                    child: CustomText(
                      title: time,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppConstant.height10),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: AppConstant.width20),
                child: CustomText(
                  title: 'No of Peoples',
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstant.width20,
                    vertical: AppConstant.height2),
                child: TextField(
                  controller: _noOfPeoplesController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppConstant.height10,
                      horizontal: AppConstant.width5,
                    ),
                    hintText: 'No of Peoples',
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
                    if (_noOfPeoplesController.text.trim().isEmpty) {
                      if (mounted) {
                        AppConstant.showToastMessage(context,
                            'Please enter complete details !!');
                      }
                    } else {
                      hideKeyBoard(context);
                      _updateData();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: AppConstant.height15,
                    ),
                  ),
                  child: CustomText(
                    title: 'Update Booking',
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
        ],
      ),
    );
  }

  // Method for update data in firebase of bookings by manager
  void _updateData() async {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore
        .instance
        .collection(
        'booking')
        .doc(uid)
        .update({
      'date': "${selectedDate.toLocal()}".split(' ')[0],
      'time': time,
      'noOfPeoples': _noOfPeoplesController.text.trim(),
    });

    AppConstant.showToastMessage(context, 'Successfully updated.');
    Navigator.pop(context);

    setState(() {
      _isLoading = false;
    });
  }

}
