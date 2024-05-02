import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:via/pages/chat/chat_page.dart';
import 'package:via/pages/map/nearby_places_cubit.dart';
import 'package:via/pages/map/nearby_places_state.dart';
import 'package:via/util/location_service.dart';
import 'package:via/util/require_position_permission.dart';

import '../../api_key.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => NearbyPlaceCubit(),
        child: CustomMapScreen(),
      ),
    );
  }
}

class CustomMapScreen extends StatefulWidget {
  @override
  _CustomMapScreenState createState() => _CustomMapScreenState();
}

class _CustomMapScreenState extends State<CustomMapScreen> {
  MapboxMap? mapboxMap;

  void _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    final pos = (await LocationService().getPosition());
    LatLng location = LatLng(pos.latitude, pos.longitude);
    mapboxMap.setCamera(CameraOptions(
      center: location.toJson(),
      zoom: 15.0,
      pitch: 0,
      bearing: 90.0,
    ));
    mapboxMap.annotations
        .createPointAnnotationManager()
        .then((pointAnnotationManager) async {
      final ByteData bytes = await rootBundle.load('assets/custom_icon.png');
      final Uint8List list = bytes.buffer.asUint8List();
      var options = <PointAnnotationOptions>[];
      for (var i = 0; i < 5; i++) {
        options.add(
            PointAnnotationOptions(geometry: location.toJson(), image: list));
      }
      pointAnnotationManager.createMulti(options);
    });
  }

  @override
  Widget build(BuildContext context) {
    MapboxOptions.setAccessToken(mapboxKey);
    return Scaffold(
      body: BlocBuilder<NearbyPlaceCubit, NearbyPlaceState>(
          builder: (context, state) {
        return FutureBuilder<LatLng>(
            future: queryLocation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final location = snapshot.data;
                if (state is NearbyPlaceInitial && location != null) {
                  context
                      .read<NearbyPlaceCubit>()
                      .fetchNearbyPlaces(location.latitude, location.longitude);
                }
                return Stack(alignment: Alignment.bottomLeft, children: [
                  MapWidget(
                    onMapCreated: _onMapCreated,
                    cameraOptions: CameraOptions(
                      center: LatLng(48.8, 2.3).toJson(),
                      zoom: 15.0,
                      pitch: 0,
                      bearing: 90.0,
                    ),
                    styleUri: 'mapbox://styles/mapbox/streets-v12',
                  ),
                  Container(
                    height: 172,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: state.props
                          .map(
                            (e) => Container(
                              width: 150,
                              padding: const EdgeInsets.all(16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChatPage(wikiPage: e)),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.greenAccent.withOpacity(0.8),
                                  child: ListView(
                                      padding: EdgeInsets.zero,
                                      children: [
                                        Text(
                                          e.title, //e["name"] ?? "null",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('${e.dist.toInt()} m' ?? "null"),
                                      ]),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ]);
              } else {
                return const CircularProgressIndicator();
              }
            });
      }),
    );
  }

  Future<LatLng> queryLocation() async {
    final enabled = await requirePositionPermission();
    if (!enabled) return LatLng(0, 0);
    final position = await LocationService().getPosition();
    final point = LatLng(position.latitude, position.longitude);
    return point;
  }
}
