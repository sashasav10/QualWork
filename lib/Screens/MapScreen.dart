import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/Routes.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  List<LatLng>? latlongList;
  List<DocumentSnapshot> _list=[];
  double currentlat=0.0;
  double currentlong=0.0;

  CameraPosition? _kGooglePlex;

  // created empty list of markers
  final List<Marker> _markers = <Marker>[];

  bool _init = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      var mapValue =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      if (mapValue['latlonglist'] != null) {
        latlongList = mapValue['latlonglist'];
      }
      if (mapValue['list'] != null) {
        _list = mapValue['list'];
      }
      if (mapValue['currentlat'] != null) {
        currentlat = mapValue['currentlat'];
      }if (mapValue['currentlong'] != null) {
        currentlong = mapValue['currentlong'];
      }

    _kGooglePlex= CameraPosition(
    target: LatLng(currentlat,currentlong),
    zoom: 14.4746,
    );
      loadData();
      _init = false;
    }
  }

  // created method for displaying custom markers according to index
  loadData() async{
    for(int i=0 ;i<latlongList!.length; i++){
      // makers added according to index
      _markers.add(
          Marker(
            // given marker id
            markerId: MarkerId(i.toString()),
            // given position
            position:latlongList![i],
            // draggable: true,
            infoWindow: InfoWindow(
              // given title for marker
              title: 'Location: ${_list[i]['name']}',
            ),
            onTap: (){
              Navigator.pushNamed(context, Routes.restaurantDetailsScreen,arguments: {
                'documentSnapshot':_list[i],
              });
            }
          )
      );
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Map View',
          style: TextStyle(
            fontSize: AppConstant.font20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex!,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers:  Set<Marker>.of(_markers),
        ),
      ),
    );
  }
}
