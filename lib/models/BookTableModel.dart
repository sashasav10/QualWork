import 'package:cloud_firestore/cloud_firestore.dart';

// Model for book table
class BookTableModel {
  final String restaurantName;
  final String uid;
  final String date;
  final String time;
  final String noOfPeoples;
  final String bookingConfirm;

  BookTableModel({
    required this.restaurantName,
    required this.date,
    required this.time,
    required this.uid,
    required this.noOfPeoples,
    required this.bookingConfirm,
  });

  Map<String, dynamic> toJson() => {
        "restaurantName": restaurantName,
        "date": date,
        "uid": uid,
        "time": time,
        "noOfPeoples": noOfPeoples,
        "bookingConfirm": bookingConfirm,
      };

  static BookTableModel? fr2omSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return BookTableModel(
        restaurantName: snapshot['restaurantName'],
        uid: snapshot['uid'],
        date: snapshot['date'],
        time: snapshot['time'],
        noOfPeoples: snapshot['noOfPeoples'],
        bookingConfirm: snapshot['bookingConfirm']);
  }
}
