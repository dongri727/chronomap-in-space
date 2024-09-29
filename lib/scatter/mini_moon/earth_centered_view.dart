import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'dart:convert';
import '../gl_script.dart' show glScript;

class EarthCenteredView extends StatefulWidget {
  const EarthCenteredView({super.key});

  @override
  EarthCenteredViewState createState() => EarthCenteredViewState();
}

class EarthCenteredViewState extends State<EarthCenteredView> {
  List<dynamic>? miniMoon;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String jsonString = await rootBundle.loadString('assets/json/2024pt5.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      miniMoon = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return miniMoon == null
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
                    var z = 0;
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
                    min: -50,
                    max: 50,
                    name: 'Pisces-Virgo',
                    axisLine: {
                      lineStyle: {color: '#E6E1E6'}
                    }
                  },
                  yAxis3D: {
                    type: 'value',
                    min: -50,
                    max: 50,
                    name: 'Gemini-Sagittarius',
                    axisLine: {
                      lineStyle: {color: '#E6E1E6'}
                    }
                  },
                  zAxis3D: {
                    type: 'value',
                    min: -200,
                    max: 200,
                    name: 'North Ecliptic Pole',
                    axisLine: {
                      lineStyle: {color: '#E6E1E6'}
                    }
                  },
                  series: [
                    {
                      type: 'scatter3D',
                      symbolSize: 5,
                      data: ${json.encode(miniMoon)},
                      label: {
                        show: true,
                        textStyle: {
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
                      data: generateOrbitData(3.84, 0.03),
                      itemStyle: { color: 'yellow' }
                    }
                  ]
                };
              })()
            ''',
    );
  }
}
