import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchSiteRepository {

  List<LaunchSites> listLaunchSites = [];


  ///fetch stars in stars with area
  fetchSite() async {
    try{
      listLaunchSites = await client.launchSites.getLaunchSite();
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///adds a star with keyZone into table Stars
  ///and at same time adds and get stars without keyZone into table Detail.
  addSitesAndFetch(String newSite) async {
    try {
      var launchSites = LaunchSites(location: '', precise: '', site: newSite, lat: 90, lon: 0);
      listLaunchSites =
      await client.launchSites.addAndReturnLaunchSites(launchSites);
    } catch (e) {
      debugPrint('$e');
    }
  }
}