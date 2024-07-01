import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RealEstateMap extends StatefulWidget {
  final ScrollController controller;

  RealEstateMap({required this.controller});

  @override
  _RealEstateMapState createState() => _RealEstateMapState();
}

class _RealEstateMapState extends State<RealEstateMap> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  late Future<BitmapDescriptor> customIconFuture;

  @override
  void initState() {
    super.initState();
    customIconFuture = loadCustomIcon();
    getCurrentLocation();
  }

  Future<BitmapDescriptor> loadCustomIcon() async {
    ByteData data = await rootBundle.load('assets/building.png');
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: 100,  
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? resizedData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(resizedData!.buffer.asUint8List());
  }

  Future<void> getCurrentLocation() async {
    _mapController = await _controller.future;
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(zoom: 17, target: LatLng(-1.263423, 38.44646)),
    ));
  }

  void loadMarkers(BitmapDescriptor customIcon) {
    setState(() {
      _markers.addAll([
        Marker(
          markerId: MarkerId('exampleMarker'),
          position: LatLng(-1.263423, 38.44646),
          infoWindow: InfoWindow(
            title: ' ',
            snippet: '49k',
          ),
          icon: customIcon,
        ),
        Marker(
          markerId: MarkerId('r'),
          position: LatLng(-1.273423, 38.74646),
          infoWindow: InfoWindow(
            title: '',
            snippet: '76u',
          ),
          icon: customIcon,
        ),
        Marker(
          markerId: MarkerId('exampleMyarker'),
          position: LatLng(-1.26645, 38.9350986),
          infoWindow: InfoWindow(
            title: ' ',
            snippet: 'h7878',
          ),
          icon: customIcon,
        ),
        Marker(
          markerId: MarkerId('exampleeMarker'),
          position: LatLng(-1.26345, 38.3350986),
          infoWindow: InfoWindow(
            title: '',
            snippet: '7878\$',
          ),
          icon: customIcon,
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search City',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<BitmapDescriptor>(
        future: customIconFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading custom icon'));
          } else if (snapshot.hasData) {
            return GoogleMap(
              onMapCreated: (controller) {
                _controller.complete(controller);
                _mapController = controller;
                loadMarkers(snapshot.data!);
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(-1.23345, 38.3350986),
                zoom: 12,
              ),
              markers: _markers,
            );
          } else {
            return Center(child: Text('No custom icon available'));
          }
        },
      ),
    );
  }
}
