import 'package:first_app/providers/weather_provider.dart';
import 'package:first_app/screens/favorites_tab.dart';
import 'package:first_app/screens/settings_tab.dart';
import 'package:first_app/screens/start_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController controllerInMain;

  @override
  void initState() {
    context.read<WeatherProvider>().getWeatherByCurrentPosition();
    super.initState();
    controllerInMain = TabController(length: 3, vsync: this, initialIndex: 1);
    controllerInMain.addListener(() {
      _handleTabSelection();
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    controllerInMain.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: TabBarView(
        children: <Widget>[
          FavoriteTab(
            controllerInMain: controllerInMain,
          ),
          StartTab(),
          SettingsTab(),
        ],
        controller: controllerInMain,
      ),
      bottomNavigationBar: TabBar(
        controller: controllerInMain,
        indicatorColor: Theme.of(context).primaryColor,
        // unselectedLabelColor: Colors.greenAccent[400],
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.favorite,
                color: controllerInMain.index == 0
                    ? Colors.white
                    : Theme.of(context).primaryColor),
          ),
          Tab(
            icon: Icon(Icons.home,
                color: controllerInMain.index == 1
                    ? Colors.white
                    : Theme.of(context).primaryColor),
          ),
          Tab(
            icon: Icon(
              Icons.settings,
              color: controllerInMain.index == 2
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
