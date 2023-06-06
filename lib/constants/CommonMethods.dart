import 'package:flutter/material.dart';

hideKeyBoard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}