import 'package:flutter/material.dart';

class AppConstant {
  //Static variable used in app
  static Color backgroundColor = const Color.fromRGBO(247, 248, 251, 1);

  // Custom Toast message
  static showToastMessage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }

  //Custom height and width of app

  static double height =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .height; //781.09
  static double width =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .size
          .width; //392.72

  static double width1 = width / width;
  static double width2 = width / 196.36;
  static double width3 = width / 130.90;
  static double width4 = width / 98.18;
  static double width5 = width / 78.54;
  static double width7 = width / 56.10;
  static double width10 = width / 39.27;
  static double width11 = width / 35.63;
  static double width12 = width / 32.33;
  static double width13 = width / 30.15;
  static double width14 = width / 28;
  static double width15 = width / 26.18;
  static double width20 = width / 19.63;
  static double width23 = width / 17.07;
  static double width25 = width / 15.68;
  static double width30 = width / 13.09;
  static double width32 = width / 12.25;
  static double width35 = width / 11.2;
  static double width40 = width / 9.81;
  static double width50 = width / 7.85;
  static double width55 = width / 7.12;
  static double width60 = width / 6.53;
  static double width70 = width / 5.6;
  static double width80 = width / 4.9;
  static double width90 = width / 4.35;
  static double width100 = width / 3.92;
  static double width112 = width / 3.5;
  static double width120 = width / 3.27;
  static double width150 = width / 2.61;

  static double height1 = height / height;
  static double height2 = height / 390.54;
  static double height3 = height / 260.33;
  static double height4 = height / 195.25;
  static double height5 = height / 156.21;
  static double height7 = height / 111.58;
  static double height10 = height / 78.10;
  static double height11 = height / 71;
  static double height12 = height / 65.08;
  static double height13 = height / 60.07;
  static double height14 = height / 55.78;
  static double height15 = height / 52.06;
  static double height18 = height / 43.38;
  static double height20 = height / 39.05;
  static double height23 = height / 33.95;
  static double height25 = height / 31.24;
  static double height30 = height / 26.03;
  static double height32 = height / 24.40;
  static double height35 = height / 22.31;
  static double height40 = height / 19.52;
  static double height50 = height / 15.62;
  static double height60 = height / 13.01;
  static double height70 = height / 11.15;
  static double height80 = height / 9.76;
  static double height90 = height / 8.67;
  static double height100 = height / 7.81;
  static double height110 = height / 7.1;
  static double height115 = height / 6.79;
  static double height120 = height / 6.50;
  static double height125 = height / 6.24;
  static double height130 = height / 6.00;
  static double height140 = height / 5.57;
  static double height150 = height / 5.20;
  static double height160 = height / 4.88;
  static double height165 = height / 4.73;
  static double height170 = height / 4.59;
  static double height180 = height / 4.33;
  static double height185 = height / 4.22;
  static double height190 = height / 4.11;
  static double height195 = height / 4.00;
  static double height200 = height / 3.90;
  static double height210 = height / 3.71;
  static double height220 = height / 3.55;
  static double height230 = height / 3.39;
  static double height240 = height / 3.25;
  static double height250 = height / 3.12;
  static double height260 = height / 3.00;
  static double height270 = height / 2.89;
  static double height280 = height / 2.78;
  static double height290 = height / 2.69;
  static double height350 = height / 2.23;

  static double radius3 = width / 130.90;
  static double radius5 = width / 78.54;
  static double radius7 = width / 56.10;
  static double radius10 = width / 39.2;
  static double radius15 = width / 26.13;
  static double radius20 = width / 19.63;
  static double radius25 = width / 15.68;
  static double radius28 = ((height + width) / 2) * 0.049;
  static double radius30 = width / 13.09;
  static double radius40 = width / 9.81;
  static double radius90 = width / 4.36;

  static double icon10 = ((height + width) / 2) * 0.017;
  static double icon11 = ((height + width) / 2) * 0.019;
  static double icon12 = ((height + width) / 2) * 0.021;
  static double icon13 = ((height + width) / 2) * 0.023;
  static double icon14 = ((height + width) / 2) * 0.024;
  static double icon15 = ((height + width) / 2) * 0.026;
  static double icon16 = ((height + width) / 2) * 0.029;
  static double icon18 = ((height + width) / 2) * 0.03;
  static double icon20 = width / 19.63;
  static double icon22 = ((height + width) / 2) * 0.038;
  static double icon24 = width / 16.36;
  static double icon50 = width / 7.85;

  static double font10 = ((height + width) / 2) * 0.017;
  static double font11 = ((height + width) / 2) * 0.019;
  static double font12 = ((height + width) / 2) * 0.021;
  static double font13 = ((height + width) / 2) * 0.023;
  static double font14 = ((height + width) / 2) * 0.024;
  static double font15 = ((height + width) / 2) * 0.026;
  static double font16 = ((height + width) / 2) * 0.029;
  static double font18 = ((height + width) / 2) * 0.03;
  static double font20 = ((height + width) / 2) * 0.035;
  static double font21 = ((height + width) / 2) * 0.036;
  static double font22 = ((height + width) / 2) * 0.038;
  static double font23 = ((height + width) / 2) * 0.040;
  static double font24 = ((height + width) / 2) * 0.041;
  static double font25 = ((height + width) / 2) * 0.043;
  static double font28 = ((height + width) / 2) * 0.049;
}
