import 'package:flutter/material.dart';
import 'dart:math';
import 'package:acorn_client/acorn_client.dart';

import '../fetch/fetch_site.dart';
import '../fetch/fetch_stars.dart';
import '../lists/area_list.dart';
import '../lists/epoch_list.dart';
import '../serverpod_client.dart';
import '../utils/choice_si_format.dart';
import 'principal_page.dart';

class PrincipalModel extends ChangeNotifier {

  late final FetchStarsRepository _fetchStarsRepository;
  late final FetchSiteRepository _fetchLaunchSiteRepository;

  PrincipalModel() {
    _fetchStarsRepository = FetchStarsRepository();
    _fetchLaunchSiteRepository = FetchSiteRepository();
  }

  TextEditingController starController = TextEditingController();
  TextEditingController launchSiteController = TextEditingController();

  double log10(num x) => log(x) / ln10;

  var newYearD = 0.0; //変換用の年
  var newYearI = 0; //入力された年
  var newAnnee = ''; //時代を含む年
  var newMonth = 0; //入力された月
  var newDay = 0; //入力された日
  late int newPoint; //時間軸point
  late double newLogarithm; //2100年基点対数
  late double newCoefficient; //座標係数
  var newName = ''; //事象名
  var calendarNo = 0; //時代コード
  var hecX =0.0;
  var hecY =0.0;
  var hecZ =0.0;
  var julianD = 0;
  var gLat = 0.0;
  var gLon = 0.0;
  var lightYear = 0.0;
  var launchSite = '';


  List<dynamic> currentDisplayList = [];

  var newLocation = '';
  final List<String> filtersLocation = <String>[];
  final List<int> filtersLocationId = <int>[];
  String selectedLocation = '';
  int selectedLocationId = 0;
  String chosenLocation ='';

  var newStar = '';
  final List<String> filtersStars= <String>[];
  final List<int> filtersStarsId = <int>[];
  String selectedStar = '';
  int selectedStarId = 0;
  String chosenStar = '';

  var newSite = '';
  final List<String> filtersSites= <String>[];
  final List<int> filtersSitesId = <int>[];
  String selectedSite = '';
  int selectedSiteId = 0;
  String chosenSite = '';

  ///DropdownButton
  String selectedArea = 'Universe';

  void setArea(String? value) {
    if (value != null) {
      selectedArea = value;
      keyZone = selectedArea;
    }
    notifyListeners();
  }

  //ZONEで絞り込んだ天体を取得する
    String? keyZone;

    Future<void> fetchStars(keyZone) async {
    await _fetchStarsRepository.fetchStars(keyZone);
    currentDisplayList = _fetchStarsRepository.listStars;
    notifyListeners();
  }

  ///siteを取得
  Future<void> fetchSite() async {
    await _fetchLaunchSiteRepository.fetchSite();
    currentDisplayList = _fetchLaunchSiteRepository.listLaunchSites;
    notifyListeners();
  }

  //Chipを表示
  Widget buildItemWidget(dynamic item) {
    // Define a function to extract the key based on item type
    String extractKey(dynamic item) {
      if (item is Stars) {
        return item.star;
      } else if (item is LaunchSites) {
        return item.site;
      }
      return ""; // Default case if none of the types match
    }

    // Use the extracted key to build the widget
    String choiceKey = extractKey(item);
    if (choiceKey.isEmpty) {
      return Container(); // Return an empty container if no valid key is found
    }

    return buildChoiceSIFormat(
      choiceSIList: (item is Stars) ? filtersStars : filtersSites,
      choiceSIKey: choiceKey,
      onChoiceSISelected: (selectedChoiceKey) {
        if (item is Stars) {
          chosenStar = selectedChoiceKey;
          updateChosenStar(selectedChoiceKey);
        } else if (item is LaunchSites) {
          chosenSite = selectedChoiceKey;
          updateChosenSite(selectedChoiceKey);
        }
      },
    );
  }

  //選択された天体を表示
  void setChosenStar(String star) {
    chosenStar = star;
    notifyListeners();
  }

  void updateChosenStar(String newChosenStar) {
    chosenStar = newChosenStar;
    notifyListeners();
  }

  //選択された射場を表示
  void setChosenSite(String site) {
    chosenSite = site;
    notifyListeners();
  }

  void updateChosenSite(String newChosenSite) {
    chosenSite = newChosenSite;
    notifyListeners();
  }

  //天体を追加して再表示
  Future<void> addAndFetchStars() async {
    await _fetchStarsRepository.addStarsAndFetch(newStar, keyZone!);
    currentDisplayList = _fetchStarsRepository.listStars;
    starController.clear();
    notifyListeners();
  }

  //記入された天体を取得
  setNewStar(text) {
    newStar = text;
  }

  //射場を追加して再表示
  Future<void> addAndFetchSites() async {
    await _fetchLaunchSiteRepository.addSitesAndFetch(newSite);
    currentDisplayList = _fetchLaunchSiteRepository.listLaunchSites;
    launchSiteController.clear();
    notifyListeners();
  }

  //記入された射場を取得
  setNewSite(text) {
    newSite = text;
  }

  List<String> periods = epoch; //時代選択肢
  List<String>  zone = area; //領域選択

  setNewName(text) {
    newName = text;
    notifyListeners();
  }

  void setSelectedLocation(String location) {
    selectedLocation = location;
    notifyListeners();
  }

  ///DropdownButton
  String selectedCalendar = 'Common-Era';

  void setCalendar(String? value) {
    if (value != null) {
      selectedCalendar = value;
    }
    notifyListeners();
  }

  setNewYearD(value) {
    newYearD = double.parse(value);
    notifyListeners();
  }

  setNewMonth(value) {
    try {
      newMonth = int.parse(value);
    } catch (e) {
      newMonth = 0;
    }
    notifyListeners();
  }

  setNewDay(value) {
    try {
      newDay = int.parse(value);
    } catch (e) {
      newDay = 0;
    }
    notifyListeners();
  }

  setHecX(value) {
    try {
      hecX = double.parse(value);
    } catch (e) {
      hecX = 0.0;
    }
    notifyListeners();
  }

  setHecY(value) {
    try {
      hecX = double.parse(value);
    } catch (e) {
      hecY = 0.0;
    }
    notifyListeners();
  }

  setHecZ(value) {
    try {
      hecX = double.parse(value);
    } catch (e) {
      hecZ = 0.0;
    }
    notifyListeners();
  }

  setJulianD(value) {
    try {
      julianD = int.parse(value);
    } catch (e) {
      julianD = 0;
    }
    notifyListeners();
  }

  setGLat(value) {
    try {
      gLat = double.parse(value);
    } catch (e) {
      gLat= 0.0;
    }
    notifyListeners();
  }

  setGLon(value) {
    try {
      gLon = double.parse(value);
    } catch (e) {
      gLon = 0.0;
    }
    notifyListeners();
  }

  setLightYear(value) {
    try {
      lightYear = double.parse(value);
    } catch (e) {
      lightYear = 0.0;
    }
    notifyListeners();
  }

  setLaunchSite(text) {
    launchSite = text;
    notifyListeners();
  }

  /// convert the years depending on the selected calendar period
  void convertPoint() {

    switch (selectedCalendar) {
      case 'Billion Years':
        newYearI = (newYearD * 1000000000).round();
        newYearI = -newYearI.abs();
        break;
      case 'Million Years':
        newYearI = (newYearD * 1000000).round();
        newYearI = -newYearI.abs();
        break;
      case 'Thousand Years':
        newYearI = (newYearD * 1000).round();
        newYearI = -newYearI.abs();
        break;
      case 'Years by Dating Methods':
        newYearI = (2000 - newYearD).round();
        break;
      case 'Before-CommonEra':
        newYearI = (newYearD).round();
        newYearI = -newYearI.abs();
        break;
      case 'Common-Era':
        newYearI = (newYearD).round();
        break;
    }

    ///make data of point
    newPoint =
        (((newYearI - 1) * 366 + (newMonth - 1) * 30.5 + newDay)
            .toDouble())
            .round();

    ///make data of logarithm
    newLogarithm = double.parse(
        (5885.0 - (1000 * (log10((newPoint - 768600).abs()))))
            .toStringAsFixed(4));

    ///make data of reverseLogarithm
    newCoefficient = 6820.0 + newLogarithm;

    switch (selectedCalendar) {
      case 'Billion Years':
        newAnnee = '${newYearD}B years ago';
        break;
      case 'Million Years':
        newAnnee = '${newYearD}M years ago';
        break;
      case 'Thousand Years':
        newAnnee = '${newYearD}K years ago';
        break;
      case 'Years by Dating Methods':
        newAnnee = 'about $newYearD years ago';
        break;
      case 'Before-CommonEra':
        newAnnee = 'BCE ${(newYearD).round()}';
        break;
      case 'Common-Era':
        newAnnee = 'CE ${(newYearD).round()}';
        break;
    }
  }

  Future<int> save() async {
    if (newYearI != 0 && newName != "") {
      try {
        var principal = Principal(
          period: selectedCalendar,
          annee: newAnnee,
          month: newMonth,
          day: newDay,
          point: newPoint,
          affair: newName,
          location: keyZone!,
          precise: chosenStar,
        );
        var principalId = await client.principal.addPrincipal(principal);

        //with Map
        var withMap = WithMap(
            principalId: principalId,
            annee: newAnnee,
            affair: newName,
            location: keyZone!,
            precise: chosenStar,
            latitude: 90.0,
            longitude: 0.0,
            logarithm: newLogarithm);
        await client.withMap.addWithMap(withMap);

        //with Globe
        var withGlobe = WithGlobe(
            principalId: principalId,
            annee: newAnnee,
            affair: newName,
            location: keyZone!,
            precise: chosenStar,
            xCoordinate: 0 * newCoefficient,
            yCoordinate: 1 * newCoefficient,
            zCoordinate: 0 * newCoefficient,
            coefficient: newCoefficient);
        await client.withGlobe.addWithGlobe(withGlobe);

        //in space
        var space = Space(
            principalId: principalId,
            annee: newAnnee,
            month: newMonth,
            day: newDay,
            point: newPoint,
            affair: newName,
            location: keyZone!,
            precise: chosenStar,
            hecX: hecX,
            hecY: hecY,
            hecZ: hecZ,
            julianD: julianD,
            gLat: gLat,
            gLon: gLon,
            lightYear: lightYear,
        );
        await client.space.addSpace(space);

        return 0;
      } catch (e) {
        return 1;
      }
    } else {
      return 2;
    }
  }

  void showCustomDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            GestureDetector(
              child: const Text('OK'),
              onTap: () {
                Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (context) => const PrincipalPage()),
                ); // ダイアログを閉じる
              },
            ),
          ],
        );
      },
    );
  }
}