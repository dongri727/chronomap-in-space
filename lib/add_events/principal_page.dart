import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../lists/area_list.dart';
import '../utils/blank_text_format.dart';
import '../utils/button_format.dart';
import '../utils/dropdown_button_format.dart';
import '../utils/format_grey.dart';
import '../utils/shadowed_container.dart';
import '../utils/tff_format.dart';
import 'principal_model.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<PrincipalModel>(
      create: (_) => PrincipalModel(),
      child: Consumer<PrincipalModel>(builder: (_, model, child) {

        return Scaffold(
          appBar: AppBar(
            title: const Text('Register an Event'),
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
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                            child: Text('WHAT',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          )),
                      Expanded(flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TffFormat(
                              hintText: 'Event(within 50 letters)',
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
                                    child: CustomDropdownButton(
                                      selectedValue: model.selectedCalendar,
                                      options: model.periods,
                                      onChanged: (value) {
                                        model.setCalendar(value);
                                      },
                                    ),
                                  )
                              ),
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
                                    padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
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
                  Row(
                      children: [
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
                                          child: CustomDropdownButton(
                                            selectedValue: model.selectedArea,
                                            options: model.zone,
                                            onChanged: (value) {
                                              model.setArea(value);
                                            },
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: OutlinedButton(
                                            child: const Text('Show Celestial Body Options'),
                                            onPressed: () async {
                                              await model.fetchStars(model.keyZone);
                                            },
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: BlankTextBlackFormat(
                                          text: model.chosenStar,
                                        )
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(padding: const EdgeInsets.all(8.0),
                                        child: FormatGrey(
                                          controller: model.starController,
                                          hintText: 'another Celestial Body You Want',
                                          onChanged: (text) {
                                            model.setNewStar(text);
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
                                        child: ButtonFormat(
                                          label: 'Add a New Celestial Body',
                                          onPressed: () async {
                                            model.addAndFetchStars();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //todo 将来的に以下を実装
/*                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: OutlinedButton(
                                          child: const Text('Launch Site'),
                                          onPressed: () {},
                                        ),
                                      )),
                                  const Expanded(
                                      flex: 1,
                                      child: BlankTextBlackFormat(
                                        text: 'text',
                                      )
                                  ),
                                ],
                              ),*/
/*                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(padding: const EdgeInsets.all(8.0),
                                      child: FormatGrey(
                                        controller: model.starController,
                                        hintText: 'another Launch Site You Want',
                                        onChanged: (text) {

                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ButtonFormat(
                                      label: 'Add a New Launch Site',
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),*/
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                    child: Text('Please enter the Heliocentric Ecliptic Coordinates and Julian Day if you may know')
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TffFormat(
                                    hintText: 'X, 50.1234',
                                    onChanged: (value) {
                                      model.setHecX(value);
                                      print(model.hecX);
                                    },
                                    tffColor1: Colors.black54,
                                    tffColor2: const Color(0x99e6e6fa),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TffFormat(
                                    hintText: 'Y, 50.1234',
                                    onChanged: (value) {
                                      model.setHecY(value);
                                    },
                                    tffColor1: Colors.black54,
                                    tffColor2: const Color(0x99e6e6fa),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TffFormat(
                                    hintText: 'Z, 50.1234',
                                    onChanged: (value) {
                                      model.setHecZ(value);
                                      print(model.hecZ);
                                    },
                                    tffColor1: Colors.black54,
                                    tffColor2: const Color(0x99e6e6fa),
                                  ),
                                ),
                                Padding(
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
                              ],
                            )
                        )
                      ]),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 5.0,
                      children: model.currentDisplayList.map((item){
                        return model.buildItemWidget(item);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },),
    );

  }
}