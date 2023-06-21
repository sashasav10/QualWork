import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/models/BookTableModel.dart';
import 'package:my_app/models/UserModel.dart';

import '../models/AddRestaurantModel.dart';

// firebase methods
class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // Method for signUp the user
  Future<String> signUpUser({
    required String? name,
    required String? email,
    required String? password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email!.isNotEmpty || name!.isNotEmpty || password!.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password!);

        UserModel userModel = UserModel(
          email: email,
          name: name!,
          uid: user.user!.uid,
        );

        await _firestore.collection('users').doc(user.user!.uid).set(
              userModel.toJson(),
            );
        result = 'success';
      }
    } catch (err) {
      result = 'The email address is already in use by another account.';
    }
    return result;
  }

  // Method for signIn the user
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
      }
    } catch (err) {
      result = 'User not found or password is invalid.';
    }
    return result;
  }

  // Method for check signIn the user
  int checkUserLogin() {
    if (FirebaseAuth.instance.currentUser != null) {
      if(FirebaseAuth.instance.currentUser!.email=='manager@gmail.com'){
        return 1;
      }else{
        return 2;
      }
      // signed in
    } else {
      // signed out
      return 0;
    }
  }

  // Method for save the data of book table in firebase database
  Future<String> saveData({
    required String restaurantName,
    required String? date,
    required String time,
    required String noOfPeoples,
  }) async {
    String result = 'Some error occurred';
    try {
      if (date!.isNotEmpty || time.isNotEmpty || noOfPeoples.isNotEmpty) {
        BookTableModel bookTableModel = BookTableModel(
          restaurantName:restaurantName,
          date: date,
          time: time,
          uid: _auth.currentUser!.uid,
          noOfPeoples: noOfPeoples,
          bookingConfirm: 'Processing',
        );

        await _firestore.collection('booking').add(
              bookTableModel.toJson(),
            );
        result = 'success';
      }
    } catch (err) {
      result = 'Something went wrong';
    }
    return result;
  }


  // Method for adding restaurant in firebase database
  Future<String> addRestaurantData({
    required String address,
    required List<String> cusines,
    required List<String> image,
    required String lat,
    required String long,
    required String name,
  }) async {
    String result = 'Some error occurred';
    try {
      if (address.isNotEmpty || lat.isNotEmpty || long.isNotEmpty|| name.isNotEmpty) {
        AddRestaurantModel addRestaurantModel = AddRestaurantModel(
            address:address,
            cusines:cusines,
            image:image,
            lat:lat,
            long:long,
            name:name,
        );

        await _firestore.collection('restaurants').add(
          addRestaurantModel.toJson(),
        );
        result = 'success';
      }
    } catch (err) {
      result = 'Something went wrong';
    }
    return result;
  }
}
