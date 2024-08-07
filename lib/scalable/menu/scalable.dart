import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../../serverpod_client.dart';
import '../bloc_provider.dart';
import '../timeline/widget.dart';
import 'menu_data.dart';
import 'menu_section.dart';

class Scalable extends StatefulWidget {

  final List<Principal>? principal;
  const Scalable({ super.key, this.principal});

  @override
  ScalableState createState() => ScalableState();
}

class ScalableState extends State<Scalable> {


  /// [MenuData] selects era witch will be displayed at the Timeline
  /// This data is loaded from the asset bundle during [initState()]
  final MenuData _menu = MenuData();

  List<String> locations = ['Universe', 'Solar System', 'Milky Way', 'Other Galaxy'];
  List<int> spaceCode = [686];

  List<Principal> listPrincipal = [];
  List<int> principalIds = [];

  Future<void> fetchPrincipal() async {
    try {
      listPrincipal = await client.principal.getPrincipal();
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      setState(() {}); // データの更新をUIに反映させる
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> fetchPrincipalByLocation({List<String>? location}) async {
    try {
      listPrincipal = await client.principal.getPrincipal(keywords: location);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      setState(() {}); // Refresh UI with new data
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  ///fetch principal in Space
  Future<void> fetchPrincipalByDetailId({List<int>? detailIds}) async {
    try {
      listPrincipal = await client.principal.getPrincipalByDetailIds(detailIds: spaceCode);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      setState(() {}); // データの更新をUIに反映させる
    } catch (e) {
      debugPrint('$e');
    }
  }




  /// Helper function which sets the [MenuItemData] for the [TimelineWidget].
  /// This will trigger a transition from the current menu to the Timeline,
  /// thus the push on the [Navigator], this widget will know where to scroll to.
  navigateToTimeline(MenuItemData item, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) =>
          TimelineWidget(item, BlocProvider.getTimeline(context)),
    ));
  }

  @override
  void initState() {
    super.initState();

    /// Initialize the menu with hardcoded data.
    _menu.initializeWithDefaultData();

    /// Notify the framework that the internal state of this object has changed.
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    //EdgeInsets devicePadding = MediaQuery.of(context).padding;
    final timeline = BlocProvider.getTimeline(context);

    List<Widget> tail = [];

    tail
        .addAll(_menu.sections
        .map<Widget>((MenuSectionData section) => Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: MenuSection(
          section.label,
          section.backgroundColor,
          section.textColor,
          section.items,
          navigateToTimeline,
        )))
        .toList(growable: false)
    );

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("SCALABLE"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 20.0),
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: IconButton(
                          icon: const Icon(
                            Icons.question_mark,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Search Hint'),
                                    content: const Text('Select the target,\nthen the era you wish to view.'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('close'))
                                    ],
                                  );
                                });
                          }
                      ),
                    ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                            onPressed: () async {
                              await fetchPrincipal();
                              await timeline.gatherEntries(listPrincipal);
                            },
                            child: const Text('All Items')
                        ),
                      ),

                      OutlinedButton(
                        onPressed: () async {
                          //await fetchPrincipalByLocation(location: locations);
                          await fetchPrincipalByDetailId();
                          await timeline.gatherEntries(listPrincipal);
                        }, child: const Text('In Space')
                      ),

                  ] + tail),
            ),
          ),
        )
    );
  }
}