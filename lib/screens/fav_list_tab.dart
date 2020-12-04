import 'package:first_app/models/favorite_model.dart';
import 'package:first_app/providers/favorite_provider.dart';
import 'package:first_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavListTab extends StatefulWidget {
  final TabController controllerInMain;

  const FavListTab({Key key, this.controllerInMain, controller})
      : super(key: key);

  @override
  _FavListTabState createState() => _FavListTabState();
}

class _FavListTabState extends State<FavListTab> {
  void _toggleTab(FavoriteModel favoriteModel) async {
    await context.read<WeatherProvider>().getWeatherByCoords(
          favoriteModel.latitude,
          favoriteModel.longitude,
        );
    widget.controllerInMain.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<FavoriteProvider>(builder: (context, favorite, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            itemCount: favorite.favorites.length,
            itemBuilder: (context, index) {
              final item = favorite.favorites[index];
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        _toggleTab(item);
                      },
                      child: Text(
                        item.name,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => context
                          .read<FavoriteProvider>()
                          .deleteFromFavorite(item),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
