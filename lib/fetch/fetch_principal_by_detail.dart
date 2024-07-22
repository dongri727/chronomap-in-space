import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchPrincipalByDetailRepository {
  List<Principal> listPrincipalSpace = [];
  List<int> spaceIds = [];

  ///fetch principal in Space
  fetchPrincipalByDetailIds() async {
    try {
      listPrincipalSpace = await client.principal.getPrincipalByDetailIds(detailIds: spaceIds);
    } catch (e) {
      debugPrint('$e');
    }
  }
}