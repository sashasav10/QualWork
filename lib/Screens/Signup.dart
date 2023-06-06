import 'package:flutter/material.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/AuthMethods.dart';
import 'package:my_app/constants/CommonMethods.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';
import 'package:my_app/custom%20widgets/LoadingWidget.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isLoading = false;

  // Define text editing controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                keyboardType: TextInputType.name,
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
            SizedBox(height: AppConstant.height10),
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
                        if (_nameController.text.trim().isEmpty ||
                            _emailController.text.trim().isEmpty ||
                            _passwordController.text.trim().isEmpty) {
                          if (mounted) {
                            AppConstant.showToastMessage(
                                context, 'Please enter complete details !!');
                          }
                        } else {
                          hideKeyBoard(context);
                          _signUp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: AppConstant.height15)),
                      child: CustomText(
                        title: 'Create Account',
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
    );
  }


  // Method for signUp the new user
  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    // Logging in the user w/ Firebase
    String result = await AuthMethods()
        .signUpUser(name: _nameController.text.trim(), email: _emailController.text.trim(), password: _passwordController.text.trim());
    if (result != 'success') {
      if (mounted) {
        AppConstant.showToastMessage(context, result);
      }
    } else {
      // if result is success the screen will pop and app show signIn screen
      if (mounted) {
        AppConstant.showToastMessage(context, 'Account successfully created.');
        Navigator.pop(context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }
}
