import 'package:my_app/constants/AppConstant.dart';
import 'package:flutter/material.dart';

// Custom loading widget
class LoadingWidget extends StatelessWidget {
  Color color;
  LoadingWidget({Key? key, this.color = const Color(0xFF414BB2)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: AppConstant.height13)),
      child: SizedBox(
          height: AppConstant.height25,
          width: AppConstant.width25,
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
      ),
    );
  }
}
