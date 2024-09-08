import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchSpaceRepository {
  List<Space> listSpace = [];

  /// fetch space in space by precise
  fetchAllSpace() async {
    try {
      listSpace = await client.space.getSpace();
    } catch (e) {
      debugPrint('$e');
    }
  }

  /// fetch space in space by precise
  fetchSelectedSpace(keyBody) async {
    try {
      listSpace = await client.space.getSpace(keyword: keyBody);
    } catch (e) {
      debugPrint('$e');
    }
  }
}
