import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/AuthMethods.dart';
import 'package:my_app/constants/CommonMethods.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';
import 'package:my_app/custom%20widgets/LoadingWidget.dart';
import 'package:intl/intl.dart';

class BookTable extends StatefulWidget {
  const BookTable({Key? key}) : super(key: key);

  @override
  State<BookTable> createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  bool _isLoading = false;
  String restaurantName = '';

  final TextEditingController _noOfPeoplesController = TextEditingController();

  bool _init = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      var mapValue =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      if (mapValue['restaurantName'] != null) {
        restaurantName = mapValue['restaurantName'];
      }
      _init = false;
    }
  }

  final sDateFormate = "dd.MM.yyyy";
  DateTime selectedDate = DateTime.now();
  String date = DateFormat("dd.MM.yyyy").format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        locale: const Locale('uk', 'UA'),
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime.now().add(const Duration(days: 90)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = DateFormat(sDateFormate).format(picked);
      });
    }
  }

  String time = TimeOfDay.now().toString().substring(
      TimeOfDay.now().toString().indexOf('(') + 1,
      TimeOfDay.now().toString().indexOf(')'));

  Future<TimeOfDay> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? selectedTime = initialTime ?? TimeOfDay.now();

    TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: selectedTime,
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (newTime != null) {
      selectedTime = newTime;
    }

    return selectedTime!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppConstant.height20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' Book Table ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppConstant.font25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
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
                        title: date.split(' ')[0],
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
                      hintText: 'No of Peoples (up to 20)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[1-9]$|^1[0-9]$|^20$')),
                    ],
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
                              _saveData();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: AppConstant.height15,
                            ),
                          ),
                          child: CustomText(
                            title: 'Book Now',
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
      ),
    );
  }

  // Method for save the data of table booking by customer in firebase
  void _saveData() async {
    setState(() {
      _isLoading = true;
    });

    String result = await AuthMethods().saveData(
        restaurantName: restaurantName,
        date: date.split(' ')[0],
        time: time,
        noOfPeoples: _noOfPeoplesController.text.trim());
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
