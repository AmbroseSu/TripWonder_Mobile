import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tripwonder/screens/map/consist.dart';
//
// class MapPage extends StatefulWidget {
//   const MapPage({super.key});
//
//   @override
//   State<MapPage> createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   Location _locationController = new Location();
//
//   final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
//
//   static const LatLng _pGooglePlex = LatLng(37.4233, -122.0848);
//   static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
//   LatLng? _currentP = null;
//
//   Map<PolylineId, Polyline> polylines = {};
//
//   @override
//   void initState() {
//     super.initState();
//     getLocationUpdates().then((_) => {
//       getPolylinePoints().then((coordinates) => {
//         generatePolyLineFromPoints(coordinates),
//       }),
//     },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: const Text("Google Maps"),
//       ),
//       body: _currentP == null
//           ? const Center(
//               child: Text("Loading..."),
//             )
//           : GoogleMap(
//         onMapCreated: ((GoogleMapController controller) =>
//         _mapController.complete(controller)),
//               initialCameraPosition:
//                   CameraPosition(target: _pGooglePlex, zoom: 14),
//               markers: {
//                 Marker(
//                   markerId: const MarkerId("_currentLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _currentP!,
//                 ),
//                 Marker(
//                   markerId: const MarkerId("_sourceLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _pGooglePlex,
//                 ),
//                 Marker(
//                   markerId: const MarkerId("_destinationLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _pApplePark,
//                 ),
//               },
//         polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }
//
//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
//   }
//
//   Future<void> getLocationUpdates() async {
//     bool _serviceEnbabled;
//     PermissionStatus _permissionGranted;
//
//     _serviceEnbabled = await _locationController.serviceEnabled();
//     if (_serviceEnbabled) {
//       _serviceEnbabled = await _locationController.requestService();
//     } else {
//       return;
//     }
//
//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           _currentP =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           _cameraToPosition(_currentP!);
//         });
//       }
//     });
//   }
//
//   // Future<List<LatLng>> getPolylinePoints() async {
//   //   List<LatLng> polylineCoordinates = [];
//   //   PolylinePoints polylinePoints = PolylinePoints();
//   //
//   //   // Tạo đối tượng PolylineRequest
//   //   PolylineRequest request = PolylineRequest(
//   //     origin: PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
//   //     destination: PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
//   //     mode: TravelMode.driving, // Sử dụng mode thay vì travelMode
//   //   );
//   //
//   //   // Gọi phương thức getRouteBetweenCoordinates với request
//   //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//   //     request: request,
//   //     googleApiKey: GOOGLE_MAPS_API_KEY,
//   //   );
//   //
//   //   if (result.points.isNotEmpty) {
//   //     for (PointLatLng point in result.points) {
//   //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//   //     }
//   //   } else {
//   //     print(result.errorMessage);
//   //   }
//   //
//   //   return polylineCoordinates;
//   // }
//
//   Future<List<LatLng>> getPolylinePoints() async {
//     List<LatLng> polylineCoordinates = [];
//     PolylinePoints polylinePoints = PolylinePoints();
//
//     // Tạo đối tượng PolylineRequest
//     PolylineRequest request = PolylineRequest(
//       origin: PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
//       destination: PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
//       mode: TravelMode.driving, // Sử dụng mode thay vì travelMode
//     );
//
//     // Gọi phương thức getRouteBetweenCoordinates với request
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       request: request,
//       googleApiKey: GOOGLE_MAPS_API_KEY,
//     );
//
//     if (result.points.isNotEmpty) {
//       for (PointLatLng point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     } else {
//       print(result.errorMessage);
//     }
//
//     return polylineCoordinates;
//   }
//
//
//
//   void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.black,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     setState(() {
//       polylines[id] = polyline;
//     });
//   }
//
// }

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng myCurrentLocation = const LatLng(10.7683, 106.6758);
  late GoogleMapController googleMapController;
  Set<Marker> marker = {};

  // BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  //
  // @override
  // void initState() {
  //   customMarker();
  //   super.initState();
  // }
  //
  // void customMarker() {
  //   BitmapDescriptor.asset(const ImageConfiguration(size: Size(35, 35)),
  //           "assets/images/bus-stop.png")
  //       .then((icon) {
  //     setState(() {
  //       customIcon = icon;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Google Maps"),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        markers: marker,
        onMapCreated: (GoogleMapController controller){
          googleMapController = controller;
        },
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async{
          Position position = await currentPosition();
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 14,
                  target: LatLng(position.latitude, position.longitude)
              )
            )
          );
          marker.clear();
          marker.add(
            Marker(markerId: const MarkerId("This is my location"),
              position: LatLng(position.latitude, position.longitude)
            )
          );
          setState(() {

          });
        },
        child: const Icon(Icons.my_location, size: 30,),
      ),
    );
  }
  Future<Position> currentPosition() async{
    bool serviceEnable;
    LocationPermission permission;

    // check if the location service are enabled or not
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable){
      return Future.error("Location services are disable");
    }
    // check the location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location denied permanently");
      }

      Position position = await Geolocator.getCurrentPosition();
      return position;
    }
}
