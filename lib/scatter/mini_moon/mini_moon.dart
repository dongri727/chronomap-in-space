import '../../hints/mini_moon_hint.dart';
import 'package:flutter/material.dart';
import '../../my_home_page.dart';
import '../../utils/navi_button.dart';
import 'earth_centered_view.dart';
import 'sun_centered_view.dart';

class MiniMoonPage extends StatelessWidget {
  const MiniMoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const NavigationButton(
              destinationPage: MyHomePage(),
              buttonText: 'INDEX'),
          leadingWidth: 100,
          title: const Text('Mini Moon 2024PT5'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MiniMoonHint()));
                },
                icon: const Icon(Icons.question_mark, color: Colors.blue,))
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Earth-centered"),
              Tab(text: "Sun-centered"),
            ],
          ),
        ),
        body: Container(
          constraints: const BoxConstraints.expand( ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/space.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              EarthCenteredView(),
              SunCenteredView(),
            ],
          ),
        ),
      ),
    );
  }
}
