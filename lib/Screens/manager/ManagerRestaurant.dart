import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/CustomColor.dart';
import 'package:my_app/constants/Routes.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';

import '../../custom widgets/RestauranttItem.dart';

class ManagerRestaurant extends StatefulWidget {
  const ManagerRestaurant({Key? key}) : super(key: key);

  @override
  State<ManagerRestaurant> createState() => _ManagerRestaurantState();
}

class _ManagerRestaurantState extends State<ManagerRestaurant> {

  Position? _currentPosition;

  // Method for handle the location permission
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
      }

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
        }

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
      }

      return false;
    }
    return true;
  }

  // Method for get current user location
  Future<bool> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return false;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
    return true;
  }

  List<LatLng> latlongList = [];
  bool _sort = true;

  bool italian = false;
  bool asian = false;
  bool indian = false;
  bool japanese = false;
  bool pizzeria = false;
  bool european = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCurrentPosition();
  }

  final List<DocumentSnapshot> _list = [];
  List<String> filterList = [
    'Italian',
    'Indian',
    'Pizzeria',
    'European',
    'Japanese',
    'Asian'
  ];
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkWhite,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          ' Restaurants ',
          style: TextStyle(
            fontSize: AppConstant.font20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, Routes.managerAddRestaurant);
            },
            icon: const Icon(Icons.add_business),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.signIn, (route) => false);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: AppConstant.height10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("restaurants")
                .where('cusines', arrayContainsAny: filterList)
                .orderBy('name', descending: _sort)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData || _currentPosition == null
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : snapshot.data!.docs.isEmpty || number == 2
                  ? Center(
                child: CustomText(
                  title: 'No Restaurants Found',
                  fontSize: AppConstant.font18,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : Column(
                children: [
                  SizedBox(height: AppConstant.height10),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppConstant.width10,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstant.width5,
                      vertical: AppConstant.width10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(AppConstant.radius10),
                    ),
                    child: Material(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _sort = !_sort;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sort_rounded,
                                  size: AppConstant.icon24,
                                ),
                                SizedBox(width: AppConstant.width5),
                                CustomText(
                                  title: 'Sort By',
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              var result = await Navigator.pushNamed(
                                  context, Routes.filtersScreen);
                              setState(() {
                                filterList = result as List<String>;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.filter_alt_outlined,
                                  size: AppConstant.icon24,
                                ),
                                SizedBox(width: AppConstant.width5),
                                CustomText(
                                  title: 'Filter',
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              for (int i = 0;
                              i < snapshot.data!.docs.length;
                              i++) {
                                DocumentSnapshot products =
                                snapshot.data!.docs[i];
                                  latlongList.add(LatLng(
                                      double.parse(products['lat']),
                                      double.parse(
                                          products['long'])));
                                  _list.add(products);
                              }

                              Navigator.pushNamed(
                                  context, Routes.mapScreen,
                                  arguments: {
                                    'latlonglist': latlongList,
                                    'list': _list,
                                    'currentlat':
                                    _currentPosition!.latitude,
                                    'currentlong':
                                    _currentPosition!.longitude,
                                  });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.map,
                                  size: AppConstant.icon24,
                                ),
                                SizedBox(width: AppConstant.width5),
                                CustomText(
                                  title: 'Maps',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppConstant.height10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot products =
                        snapshot.data!.docs[index];
                          number = 1;
                          return RestaurantItem(
                            name: products['name'],
                            image: products['image'],
                            documentSnapshot: products,
                            id: '',
                            cuisine: products['cusines'],
                            address: products['address'],
                          );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
