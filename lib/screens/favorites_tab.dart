import 'package:first_app/screens/fav_list_tab.dart';
import 'package:first_app/screens/fav_map_tab.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  final TabController controllerInMain;

  const FavoriteTab({Key key, this.controllerInMain}) : super(key: key);

  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab>
    with TickerProviderStateMixin {
  TabController controllerInFav;

  @override
  void initState() {
    super.initState();
    controllerInFav = TabController(length: 2, vsync: this, initialIndex: 0);
    controllerInFav.addListener(() {
      _handleTabSelection();
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: TabBarView(
        children: <Widget>[
          FavListTab(
            controllerInMain: widget.controllerInMain,
          ),
          FavMapTab(
            controllerInMain: widget.controllerInMain,
          )
        ],
        controller: controllerInFav,
      ),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: SafeArea(
          child: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).primaryColor,
            controller: controllerInFav,
            tabs: <Tab>[
              Tab(
                icon: Icon(Icons.list,
                    color: controllerInFav.index == 0
                        ? Colors.white
                        : Theme.of(context).primaryColor),
              ),
              Tab(
                icon: Icon(Icons.explore,
                    color: controllerInFav.index == 1
                        ? Colors.white
                        : Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
