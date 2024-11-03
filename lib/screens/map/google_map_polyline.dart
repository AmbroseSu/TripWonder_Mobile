// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GoogleMapPolyline extends StatefulWidget {
//   const GoogleMapPolyline({super.key});
//
//   @override
//   State<GoogleMapPolyline> createState() => _GoogleMapPolylineState();
// }
//
// class _GoogleMapPolylineState extends State<GoogleMapPolyline> {
//
//   LatLng myCurrentLocation = const LatLng(10.7683, 106.6758);
//   late GoogleMapController googleMapController;
//   Set<Marker> markers = {};
//
//   final Set<Polyline> _polyline = {};
//
//   List<LatLng> pointOnMap = [
//     const LatLng(10.789618384470534, 106.72071270322675),
//     const LatLng(10.778256267758502, 106.70165148974465),
//     const LatLng(10.773488805635555, 106.70111626675745),
//     const LatLng(10.777336129536994, 106.71275710111793),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     for(int i=0; i < pointOnMap.length; i++){
//       markers.add(
//         Marker(markerId: MarkerId(
//           i.toString()
//         ),
//           position: pointOnMap[i],
//           infoWindow: const InfoWindow(
//             title: "Place around my Country", snippet: " So beautiful "
//           ),
//           icon: BitmapDescriptor.defaultMarker,
//         ),
//       );
//       setState(() {
//         _polyline.add(
//           Polyline(
//               polylineId: const PolylineId("Id"),
//             points: pointOnMap,
//             color: Colors.blue
//           ),
//         );
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text("Google Maps"),
//       ),
//
//       body: GoogleMap(
//         polylines: _polyline,
//         myLocationButtonEnabled: false,
//         markers: markers,
//
//         initialCameraPosition:
//         CameraPosition(target: myCurrentLocation, zoom: 15),
//         // markers: {
//         //   Marker(
//         //     markerId: MarkerId("Mrker Id"),
//         //     position: myCurrentLocation,
//         //     draggable: true,
//         //     onDragEnd: (value) {},
//         //     infoWindow: const InfoWindow(
//         //         title: "Title of the marker",
//         //         snippet: "more infor about marker"),
//         //     icon: customIcon,
//         //   ),
//         // },
//       ),
//     );
//   }
// }



/// Version 2

//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GoogleMapPolyline extends StatefulWidget {
//   const GoogleMapPolyline({super.key});
//
//   @override
//   State<GoogleMapPolyline> createState() => _GoogleMapPolylineState();
// }
//
// class _GoogleMapPolylineState extends State<GoogleMapPolyline> {
//   LatLng myCurrentLocation = const LatLng(10.7683, 106.6758);
//   late GoogleMapController googleMapController;
//   Set<Marker> markers = {};
//   final Set<Polyline> _polyline = {};
//
//   List<LatLng> pointOnMap = [
//     const LatLng(10.789618384470534, 106.72071270322675),
//     const LatLng(10.778256267758502, 106.70165148974465),
//     const LatLng(10.773488805635555, 106.70111626675745),
//     const LatLng(10.777336129536994, 106.71275710111793),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Thêm marker cho vị trí hiện tại
//     markers.add(
//       Marker(
//         markerId: const MarkerId("currentLocation"),
//         position: myCurrentLocation,
//         infoWindow: const InfoWindow(
//           title: "Current Location",
//           snippet: "Your starting point",
//         ),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       ),
//     );
//
//     // Thêm markers cho các điểm khác
//     for (int i = 0; i < pointOnMap.length; i++) {
//       markers.add(
//         Marker(
//           markerId: MarkerId(i.toString()),
//           position: pointOnMap[i],
//           infoWindow: const InfoWindow(
//             title: "Place around my Country",
//             snippet: "So beautiful",
//           ),
//           icon: BitmapDescriptor.defaultMarker,
//         ),
//       );
//     }
//
//     // Tạo polyline từ vị trí hiện tại đến các điểm còn lại
//     setState(() {
//       List<LatLng> polylinePoints = [myCurrentLocation, ...pointOnMap];
//       _polyline.add(
//         Polyline(
//           polylineId: const PolylineId("route"),
//           points: polylinePoints,
//           color: Colors.blue,
//           width: 5,
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text("Google Maps"),
//       ),
//       body: GoogleMap(
//         polylines: _polyline,
//         myLocationButtonEnabled: false,
//         markers: markers,
//         initialCameraPosition:
//         CameraPosition(target: myCurrentLocation, zoom: 15),
//       ),
//     );
//   }
// }


/// Version 3

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapPolyline extends StatefulWidget {
  const GoogleMapPolyline({super.key});

  @override
  State<GoogleMapPolyline> createState() => _GoogleMapPolylineState();
}

class _GoogleMapPolylineState extends State<GoogleMapPolyline> {
  LatLng myCurrentLocation = const LatLng(10.7683, 106.6758);
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> pointOnMap = [
    const LatLng(10.789618384470534, 106.72071270322675),
    const LatLng(10.778256267758502, 106.70165148974465),
    const LatLng(10.773488805635555, 106.70111626675745),
    const LatLng(10.777336129536994, 106.71275710111793),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // Kiểm tra quyền truy cập vị trí
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return; // Nếu quyền bị từ chối
      }
    }

    // Lấy vị trí hiện tại
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      myCurrentLocation = LatLng(position.latitude, position.longitude);
      _updateMarkersAndPolyline();
    });
  }

  void _updateMarkersAndPolyline() {
    // Thêm marker cho vị trí hiện tại
    markers.add(
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: myCurrentLocation,
        infoWindow: const InfoWindow(
          title: "Current Location",
          snippet: "Your starting point",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    // Thêm markers cho các điểm khác
    for (int i = 0; i < pointOnMap.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: pointOnMap[i],
          infoWindow: const InfoWindow(
            title: "Place around my Country",
            snippet: "So beautiful",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }

    // Tạo polyline từ vị trí hiện tại đến các điểm còn lại
    List<LatLng> polylinePoints = [myCurrentLocation, ...pointOnMap];
    _polyline.add(
      Polyline(
        polylineId: const PolylineId("route"),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Google Maps"),
      ),
      body: GoogleMap(
        polylines: _polyline,
        myLocationButtonEnabled: false,
        markers: markers,
        initialCameraPosition: CameraPosition(target: myCurrentLocation, zoom: 15),
      ),
    );
  }
}

