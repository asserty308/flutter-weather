import 'package:flutter/material.dart';
import 'package:weather_app/tabs/app_settings_tab.dart';
import 'package:weather_app/tabs/city_overview_page.dart';
import 'package:weather_app/tabs/current_weather_page.dart';

class ContentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContentScreenState();
}

// SingleTickerProviderStateMixin is used for animation
class ContentScreenState extends State<ContentScreen> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    this.controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TabBarView(
        controller: this.controller,
        children: <Widget>[
          CurrentWeatherPage(),
          CityOverviewPage(),
          AppSettingsTab(),
      ]),
      bottomNavigationBar: Material(
        // set navbar's color
        color: Colors.black,
        // set TabBar as the child of bottomNavigationBar
        child: TabBar(
          indicatorColor: Colors.blueGrey,
          controller: this.controller,
          tabs: <Tab>[
            Tab(icon: Icon(Icons.location_on,)),
            Tab(icon: Icon(Icons.view_list,)),
            Tab(icon: Icon(Icons.settings,)),
        ]),
      ),
    );
  }
}