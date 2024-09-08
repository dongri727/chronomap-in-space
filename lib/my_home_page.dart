import 'package:chronomap_in_cosmos/scatter/db_view.dart';
import 'package:chronomap_in_cosmos/scatter/interstellar.dart';
import 'package:chronomap_in_cosmos/scatter/terrestrial_planets.dart';
import 'package:flutter/material.dart';
import 'add_events/principal_page.dart';
import 'scalable/menu/scalable.dart';
import 'utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand( ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    AppLocalizations.of(context)!.indexA,
                    style: SpaceTheme.textTheme.headlineMedium,
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
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    AppLocalizations.of(context)!.indexB,
                    style: SpaceTheme.textTheme.headlineMedium,
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
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    AppLocalizations.of(context)!.indexC,
                    style: SpaceTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DBView()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    AppLocalizations.of(context)!.indexD,
                    style: SpaceTheme.textTheme.headlineMedium,
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
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    AppLocalizations.of(context)!.indexE,
                    style: SpaceTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Planets()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}