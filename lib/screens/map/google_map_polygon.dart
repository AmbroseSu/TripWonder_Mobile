import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPolygon extends StatefulWidget {
  const GoogleMapPolygon({super.key});

  @override
  State<GoogleMapPolygon> createState() => _GoogleMapPolygonState();
}

class _GoogleMapPolygonState extends State<GoogleMapPolygon> {

  LatLng myCurrentLocation = const LatLng(10.7683, 106.6758);
  final Completer<GoogleMapController> _completer = Completer();

  Set<Marker> markers = {};

  Set<Polygon> polygon = HashSet<Polygon>();

  List<LatLng> points = [

  ];

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      markers: markers,

      initialCameraPosition:
      CameraPosition(target: myCurrentLocation, zoom: 15),
      // markers: {
      //   Marker(
      //     markerId: MarkerId("Mrker Id"),
      //     position: myCurrentLocation,
      //     draggable: true,
      //     onDragEnd: (value) {},
      //     infoWindow: const InfoWindow(
      //         title: "Title of the marker",
      //         snippet: "more infor about marker"),
      //     icon: customIcon,
      //   ),
      // },
    );
  }
}
