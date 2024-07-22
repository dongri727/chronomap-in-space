import 'package:chronomap_in_space/3d_paths.dart';
import 'package:flutter/material.dart';
import 'add_events/principal_page.dart';
import 'scalable/menu/scalable.dart';
import 'utils/theme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Text(
                'ChronoMap',
                style: SpaceTheme.textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: Text(
                textAlign: TextAlign.center,
                'A 4D Journey\nThrough Time and Space',
                style: SpaceTheme.textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                child: Text(
                  'Register Events',
                  style: SpaceTheme.textTheme.bodyLarge,
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrincipalPage()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                child: Text(
                  'Scalable View',
                  style: SpaceTheme.textTheme.bodyLarge,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Scalable()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                child: Text(
                  'Voyager1',
                  style: SpaceTheme.textTheme.bodyLarge,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Paths()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Text(
                'Space-specific Edition',
                style: SpaceTheme.textTheme.headlineLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}