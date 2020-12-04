import 'package:first_app/generated/l10n.dart';
import 'package:first_app/providers/favorite_provider.dart';
import 'package:first_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class FavMapTab extends StatefulWidget {
  final TabController controllerInMain;

  const FavMapTab({Key key, this.controllerInMain}) : super(key: key);

  @override
  _FavMapTabState createState() => _FavMapTabState();
}

class _FavMapTabState extends State<FavMapTab> {
  MapController mapController;
  List<Marker> markers = List();

  void _toggleTab(double latitude, double longitude) async {
    await context.read<WeatherProvider>().getWeatherByCoords(
          latitude,
          longitude,
        );
    widget.controllerInMain.animateTo(1);
  }

  void _closeModal(latitude, longitude) {
    mapController.move(LatLng(latitude, longitude), 6);
  }

  void initState() {
    mapController = MapController();
    super.initState();
    context.read<FavoriteProvider>().favorites.forEach((element) {
      Marker resultMarker = Marker(
        width: 80,
        height: 80,
        point: LatLng(element.latitude, element.longitude),
        builder: (ctx) => Container(
          child: IconButton(
            icon: Icon(
              Icons.room,
              size: 50,
              color: Colors.black,
            ),
            onPressed: () {
              mapController.move(
                  LatLng(element.latitude, element.longitude), 10);
              Future<void> future = showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    final delegate = S.of(context);
                    return Container(
                      height: 200,
                      color: Color(0xFF1E1E20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                element.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              _toggleTab(element.latitude, element.longitude);
                              Navigator.pop(context);
                            },
                            label: Text(
                              '${delegate.chooseText}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            icon: Icon(
                              Icons.find_replace,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    );
                  });
              future.then(
                  (value) => _closeModal(element.latitude, element.longitude));
            },
          ),
        ),
      );
      markers.add(resultMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<FavoriteProvider>(builder: (context, favorite, child) {
        return new FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: LatLng(
                context.watch<WeatherProvider>().weatherModel.coord.lat,
                context.watch<WeatherProvider>().weatherModel.coord.lon),
            zoom: 6.0,
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(markers: markers)
          ],
        );
      }),
    );
  }
}
