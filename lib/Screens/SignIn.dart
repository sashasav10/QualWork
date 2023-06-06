import 'package:flutter/material.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/AuthMethods.dart';
import 'package:my_app/constants/CommonMethods.dart';
import 'package:my_app/constants/CustomColor.dart';
import 'package:my_app/constants/Routes.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';
import 'package:my_app/custom%20widgets/LoadingWidget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // Define text editing controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isManager = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppConstant.height10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title: 'NearBy Restaurants',
                  textAlign: TextAlign.center,
                  fontSize: AppConstant.font23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(height: AppConstant.height30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppConstant.width20),
              child: CustomText(
                title: 'Email',
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstant.width20,
                  vertical: AppConstant.height2),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: AppConstant.height10,
                    horizontal: AppConstant.width5,
                  ),
                  hintText: 'Email',
                ),
              ),
            ),
            SizedBox(height: AppConstant.height10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppConstant.width20),
              child: CustomText(
                title: 'Password',
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstant.width20,
                  vertical: AppConstant.height2),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: AppConstant.height10,
                    horizontal: AppConstant.width5,
                  ),
                  hintText: 'Password',
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
                        if (_emailController.text.trim().isEmpty ||
                            _passwordController.text.trim().isEmpty) {
                          if (mounted) {
                            AppConstant.showToastMessage(
                                context, 'Please enter complete details !!');
                          }
                        } else {
                          hideKeyBoard(context);
                          _logInUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: AppConstant.height15)),
                      child: CustomText(
                        title: 'Login',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstant.font16,
                      ),
                    ),
            ),
            SizedBox(
              height: AppConstant.height30,
            ),
            _isManager
                ? Container()
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppConstant.width20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signUp);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            "Don't have an account? Signup Now",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            _isManager
                ? Container()
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppConstant.width20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isManager = true;
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            "Click here for manager login",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: AppConstant.height30,
            ),
          ],
        ),
      ),
    );
  }


  // Method for login the user
  void _logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (result == 'success') {
      if (mounted) {

        // Check the user is manager or not, if user is manager the app goes to manager homepage
        // otherwise app goes to customer homepage
        if (_emailController.text.trim() == 'manager@gmail.com') {
          Navigator.pushReplacementNamed(context, Routes.managerHomepage);
        } else {
          Navigator.pushReplacementNamed(context, Routes.homepage);
        }
      }
    } else {
      if (mounted) {
        AppConstant.showToastMessage(context, result);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }
}
