import 'package:acorn_client/acorn_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

late Client client;

Future<void> initializeServerpodClient() async {

  //const ipAddress = 'localhost';

  client = Client(
    //'http://$ipAddress:8080/',
    'https://api.laporte.academy/',
  )..connectivityMonitor = FlutterConnectivityMonitor();
}