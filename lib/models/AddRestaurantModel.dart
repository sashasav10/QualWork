import 'package:cloud_firestore/cloud_firestore.dart';

// Model for book table
class AddRestaurantModel {
  final String address;
  final List<String> cusines;
  final List<String> image;
  final String lat;
  final String long;
  final String name;

  AddRestaurantModel({
    required this.address,
    required this.image,
    required this.lat,
    required this.cusines,
    required this.long,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "address": address,
        "image": image,
        "cusines": cusines,
        "lat": lat,
        "long": long,
        "name": name,
      };

  static AddRestaurantModel? fr2omSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AddRestaurantModel(
        address: snapshot['address'],
        cusines: snapshot['cusines'],
        image: snapshot['image'],
        lat: snapshot['lat'],
        long: snapshot['long'],
        name: snapshot['name']);
  }
}
