import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/describe_card.dart';

class InterstellarHintPage extends StatelessWidget {
  const InterstellarHintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hints'),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/space.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.isMissionA),
                  ),
                  CustomTextContainer(
                      textContent: AppLocalizations.of(context)!.gmail),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.isMissionB),
                  ),
                  CustomTextContainer(
                      textContent: AppLocalizations.of(context)!.isMissionC),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.isMissionD),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.zoomable),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}