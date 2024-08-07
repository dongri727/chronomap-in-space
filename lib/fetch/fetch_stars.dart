import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchStarsRepository {
  List<Detail> listDetailStars = [];
  List<Stars> listStars = [];

  ///fetch stars in detail for keywords
  fetchStarsInDetail() async {
    try {
      listDetailStars = await client.detail.getDetailByGenre(genre: 'stars_involved');
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///fetch stars in stars with area
  fetchStars(keyZone) async {
    try{
      listStars = await client.stars.getStars(keyword: keyZone);
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///adds a star with keyZone into table Stars
  ///and at same time adds and get stars without keyZone into table Detail.
  addStarsAndFetch(String newStar, String keyZone) async {
    try {
      var stars = Stars(star: newStar, area: keyZone);
      var keyword = keyZone;
      var detail = Detail(genre: 'stars_involved', mot: newStar);
      listStars =
      await client.stars.addAndReturnStarsWithKeyArea(stars, keyword);
      await client.detail.addDetail(detail);
    } catch (e) {
      debugPrint('$e');
    }
  }


  addDetailStarsAndFetch(String starsInvolved, String newStar) async {
    try {
      var detailStars = Detail(genre: starsInvolved, mot: newStar);
      listDetailStars = await client.detail.addAndReturnDetailByGenre(detailStars);
    } catch (e) {
      debugPrint('$e');
    }
  }


}