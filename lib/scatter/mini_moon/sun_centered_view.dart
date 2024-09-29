import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'dart:convert';
import '../gl_script.dart' show glScript;

class SunCenteredView extends StatefulWidget {
  const SunCenteredView({super.key});

  @override
  SunCenteredViewState createState() => SunCenteredViewState();
}

class SunCenteredViewState extends State<SunCenteredView> {
  List<dynamic>? pt5;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String jsonString = await rootBundle.loadString('assets/json/2024pt5_with_sun.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      pt5 = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return pt5 == null
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
                    min: -20,
                    max: 20,
                    name: 'Pisces-Virgo',
                    axisLine: {
                      lineStyle: {color: '#E6E1E6'}
                    }
                  },
                  yAxis3D: {
                    type: 'value',
                    min: -20,
                    max: 20,
                    name: 'Gemini-Sagittarius',
                    axisLine: {
                      lineStyle: {color: '#E6E1E6'}
                    }
                  },
                  zAxis3D: {
                    type: 'value',
                    min: -10,
                    max: 10,
                    name: 'timeline(JulianD)',
                    axisLine: {
                      lineStyle: {color: '#E6E1E6'}
                    }
                  },
                  series: [
                    {
                      type: 'scatter3D',
                      symbolSize: 5,
                      data: ${json.encode(pt5)},
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
                      data: generateOrbitData(14.93, 0.01), // Earth's orbit
                      itemStyle: { color: 'blue' }
                    },
                    {
                      type: 'scatter3D',
                      symbolSize: 2,
                      data: generateOrbitData(10.75, 0.01), // Venus's orbit
                      itemStyle: { color: '#FF6347' }
                    }
                  ]
                };
              })()
            ''',
    );
  }
}
