import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chronomap_in_cosmos/hints/db_view_hint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../fetch/fetch_space.dart';
import '../my_home_page.dart';
import '../utils/navi_button.dart';
import 'gl_script.dart' show glScript;

class DBView extends StatefulWidget {
  const DBView({super.key});

  @override
  DBViewState createState() => DBViewState();
}

class DBViewState extends State<DBView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>>? spaceData;
  final FetchSpaceRepository fetchSpaceRepository = FetchSpaceRepository();


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  String keyBody = 'Neptune';


  Future<void> _loadData() async {
    await fetchSpaceRepository.fetchAllSpace();
    setState(() {
      spaceData = fetchSpaceRepository.listSpace.map((space) => {
        "value": [space.hecX, space.hecY, space.julianD],
        "name": space.affair,
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: const NavigationButton(
            destinationPage: MyHomePage(),
            buttonText: 'INDEX'),
        leadingWidth: 100,
        title: Text(AppLocalizations.of(context)!.indexC),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DbViewHint()));
              },
              icon: const Icon(Icons.question_mark, color: Colors.blue,))
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/space.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 1200,
            height: 1000,
            child: spaceData == null
                ? const CircularProgressIndicator()
                : Echarts(
              extensions: const [glScript],
              option: '''
                      (function() {
                        function generateOrbitData(radius, interval) {
                          var data = [];
                          for (var t = 0; t < 2 * Math.PI; t += interval) {
                            var x = radius * Math.cos(t);
                            var y = radius * Math.sin(t);
                            var z = 2450000;  //時間軸対応
                            data.push([x, y, z]);
                          }
                          return data;
                        }

                        return {
                          tooltip: {
                            show: true,
                            formatter: function(params) {
                              var data = params.data;
                              return 'Name: ' + data.name;
                            }
                          },
                          grid3D: {
                            viewControl: {
                              alpha: 40,
                              beta: -60
                            }
                          },
                          xAxis3D: {
                            type: 'value',
                            min: -30,
                            max: 30,
                            splitLine: {show: false},
                            name: 'Pisces-Virgo',
                            axisLine: {
                              lineStyle: {color: '#E6E1E6'}
                            }
                          },
                          yAxis3D: {
                            type: 'value',
                            min: -30,
                            max: 30,
                            splitLine: {show: false},                  
                            name: 'Gemini-Sagittarius',
                            axisLine: {
                              lineStyle: {color: '#E6E1E6'}
                            }
                          },
                          zAxis3D: {
                            type: 'value',
                            min: 2450000,
                            max: 2460000,
                            splitLine: {show: false},
                            name: 'timeline(JulianD)',
                            axisLine: {
                              lineStyle: {color: '#E6E1E6'}
                            }                                 
                          },
                          series: [
                            {
                              type: 'scatter3D',
                              symbolSize: 10,
                              data: ${json.encode(spaceData)},
                                label: {
                                  show: true,
                                  textStyle: {
                                    color: '#ffffff',
                                    fontSize: 12,
                                    borderWidth: 1
                                  },
                                  formatter: function(param) {
                                    return param.data.name;
                                  }
                                },
                                itemStyle: {opacity: 0.8}    
                              },
                              {
                                type: 'scatter3D',
                                symbolSize: 2,
                                data: generateOrbitData(5.82, 0.01), // 水星
                                itemStyle: { color: '#FF6347' } 
                              },
                              {
                                type: 'scatter3D',
                                symbolSize: 2,
                                data: generateOrbitData(10.75, 0.01), // 金星
                                itemStyle: { color: '#FF6347' } 
                              },
                              {
                                type: 'scatter3D',
                                symbolSize: 2,
                                data: generateOrbitData(14.93, 0.01), // 地球
                                itemStyle: { color: 'blue' } 
                              },
                              {
                                type: 'scatter3D',
                                symbolSize: 2,
                                data: generateOrbitData(22.68, 0.01), // 火星
                                itemStyle: { color: '#FF6347' } 
                              },
                              {
                                type: 'scatter3D',
                                symbolSize: 2,
                                data: generateOrbitData(40.31, 0.01), // 小惑星帯
                                itemStyle: { color: '#FF6347' } 
                              },      
                            ]
                          };
                      })()
                      ''',
            ),
          ),
        ),
      ),
    );
  }
}
