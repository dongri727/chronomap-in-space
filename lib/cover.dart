import 'package:chronomap_in_cosmos/my_home_page.dart';
import 'package:chronomap_in_cosmos/utils/language_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'hints/info_page.dart';
import 'utils/shadowed_container.dart';

class CoverPage extends StatefulWidget {
  const CoverPage({super.key});

  @override
  CoverPageState createState() => CoverPageState();
}

class CoverPageState extends State<CoverPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppLocalizations.of(context)!.cover),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
              child: ShadowedContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextButton(
                        child: const Text(
                          "Start",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blueAccent,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push<String>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(),
                            ),
                          );
                        }),

                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: LanguageDropdownButton(),
                    ),

                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InfoPage()));
                        },
                        icon: const Icon(Icons.info_outline, size: 32.0, color: Colors.blue,))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}