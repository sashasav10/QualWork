import 'package:flutter/material.dart';
import 'package:my_app/constants/Routes.dart';
import 'package:my_app/constants/AuthMethods.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _init = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      // Delay for 2 second

      Future.delayed(const Duration(seconds: 1), () async {
        // if method return 1 the app goes to manager homepage screen
        // if method return 2 the app goes to customer homepage
        // otherwise the signIn screen will show
        if (AuthMethods().checkUserLogin() == 1) {
          Navigator.pushReplacementNamed(context, Routes.managerHomepage);
        } else if (AuthMethods().checkUserLogin() == 2) {
          Navigator.pushReplacementNamed(context, Routes.homepage);
        } else {
          Navigator.pushReplacementNamed(context, Routes.signIn);
        }
      });
      _init = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.restaurant,
                size: 100.0,
                color: Colors.white,
              ),
              SizedBox(height: 16.0),
              Text(
                'Nearby Restaurants',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 16.0),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
