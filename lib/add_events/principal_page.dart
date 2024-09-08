import 'package:chronomap_in_space/hints/add_hint_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/blank_text_format.dart';
import '../utils/button_format.dart';
import '../utils/dropdown_button_format.dart';
import '../utils/format_grey.dart';
import '../utils/shadowed_container.dart';
import '../utils/tff_format.dart';
import 'principal_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PrincipalModel>(
      create: (_) => PrincipalModel(),
      child: Consumer<PrincipalModel>(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.indexA),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddHintPage()));
                    },
                    icon: const Icon(
                      Icons.question_mark,
                      color: Colors.blue,
                    ))
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  model.convertPoint();
                  int result = await model.save();
                  String title;
                  String content;

                  switch (result) {
                    case 0:
                      title = 'Succeeded';
                      content = 'Thank you for adding Information';
                      break;
                    case 1:
                      title = 'Failed';
                      content = 'Oops! Something went wrong...';
                      break;
                    case 2:
                      title = 'Failed';
                      content = 'Required fields are missing';
                      break;
                    default:
                      title = 'Unexpected Error';
                      content = 'Please try again later';
                      break;
                  }

                  if (!context.mounted) return;

                  model.showCustomDialog(context, title, content);
                },
                label: const Text('SAVE')),
            body: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/main.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                                child: Text(
                                  'WHAT',
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TffFormat(
                                  hintText: AppLocalizations.of(context)!.name,
                                  onChanged: (text) {
                                    model.setNewName(text);
                                  },
                                  tffColor1: const Color(0xFF2f4f4f),
                                  tffColor2: const Color(0x99e6e6fa),
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                                child: Text(
                                  'WHEN',
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: ShadowedContainer(
                                          child: CustomDropdownButton(
                                            selectedValue:
                                                model.selectedCalendar,
                                            options: model.periods,
                                            onChanged: (value) {
                                              model.setCalendar(value);
                                            },
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'year',
                                          onChanged: (value) {
                                            model.setNewYearD(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'Month 1-12 or 0',
                                          onChanged: (value) {
                                            model.setNewMonth(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 20, 8),
                                        child: TffFormat(
                                          hintText: 'Date 1-31 or 0',
                                          onChanged: (value) {
                                            model.setNewDay(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        )),
                                  )
                                ],
                              ))
                        ],
                      ),
                      Row(children: [
                        const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                              child: Text(
                                'WHERE',
                                style: TextStyle(fontSize: 24),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: ShadowedContainer(
                                            child: CustomDropdownButton(
                                              selectedValue: model.selectedArea,
                                              options: model.zone,
                                              onChanged: (value) {
                                                model.setArea(value);
                                              },
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ShadowedContainer(
                                            child: ButtonFormat(
                                              label: AppLocalizations.of(context)!
                                                  .showOptions,
                                              onPressed: () async {
                                                await model
                                                    .fetchStars(model.keyZone);
                                              },
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: BlankTextFormat(
                                          text: model.chosenStar,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FormatGrey(
                                          controller: model.starController,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .newWord,
                                          onChanged: (text) {
                                            model.setNewStar(text);
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 20, 8),
                                        child: ButtonFormat(
                                          label: AppLocalizations.of(context)!
                                              .addWord,
                                          onPressed: () async {
                                            model.addAndFetchStars();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
/*                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ShadowedContainer(
                                            child: ButtonFormat(
                                              label: AppLocalizations.of(context)!
                                                  .showOptions,
                                              onPressed: () {
                                                model.fetchSite();
                                              },
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: BlankTextFormat(
                                          text: model.chosenSite,
                                        )),
                                  ],
                                ),*/
/*                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FormatGrey(
                                          controller: model.launchSiteController,
                                          hintText:
                                          AppLocalizations.of(context)!.newSite,
                                          onChanged: (text) {
                                            model.setNewSite(text);
                                            }
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ButtonFormat(
                                        label: AppLocalizations.of(context)!.addWord,
                                        onPressed: () {
                                          model.addAndFetchSites();
                                        },
                                      ),
                                    ),
                                  ],
                                ),*/
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 50, 20, 20),
                                    child: ShadowedContainer(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(AppLocalizations.of(context)!
                                          .ifYouMayKnow),
                                    ))),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'HEC X, 1.2345+Ex7',
                                          onChanged: (value) {
                                            model.setHecX(value);
                                            print(model.hecX);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'HEC Y, 1.2345+Ex7',
                                          onChanged: (value) {
                                            model.setHecY(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'HEC Z, 1.2345+Ex7',
                                          onChanged: (value) {
                                            model.setHecZ(value);
                                            print(model.hecZ);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'JD, 2460529',
                                          onChanged: (value) {
                                            model.setJulianD(value);
                                            print(model.julianD);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'Galaxy Latitude',
                                          onChanged: (value) {
                                            model.setGLat(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'Galaxy Longitude',
                                          onChanged: (value) {
                                            model.setGLon(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TffFormat(
                                    hintText: 'Light Year',
                                    onChanged: (value) {
                                      model.setLightYear(value);
                                      print(model.lightYear);
                                    },
                                    tffColor1: Colors.black54,
                                    tffColor2: const Color(0x99e6e6fa),
                                  ),
                                ),
                              ],
                            ))
                      ]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 5.0,
                          children: model.currentDisplayList.map((item) {
                            return model.buildItemWidget(item);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
