import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final String lat;
  final String lng;
  const MapView({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _controller;

  Set<Marker> _createMarker() {
    return <Marker>{
      Marker(
        markerId: const MarkerId("Home"),
        position: LatLng(
          double.parse(widget.lat),
          double.parse(widget.lng),
        ),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: "Home",
        ),
      ),
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('Lat is ' + double.parse(widget.lat).toString());
    print('Lng is ' + double.parse(widget.lng).toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(
          double.parse(widget.lat),
          double.parse(widget.lng),
        ),
        zoom: 5.0,
      ),
      onMapCreated: (GoogleMapController controller) =>
          _controller = controller,
    );
  }
}
