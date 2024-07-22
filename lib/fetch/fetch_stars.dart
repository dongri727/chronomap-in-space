import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchStarsRepository {
  List<Detail> listDetailStars = [];

  ///fetch stars in detail for keywords
  fetchStarsInDetail() async {
    try {
      listDetailStars = await client.detail.getDetailByGenre(genre: 'stars_involved');
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///add and get stars in detail for keywords
  addDetailStarsAndFetch(String starsInvolved, String newStar) async {
    try {
      var detailStars = Detail(genre: starsInvolved, mot: newStar);
      listDetailStars = await client.detail.addAndReturnDetailByGenre(detailStars);
    } catch (e) {
      debugPrint('$e');
    }
  }
}