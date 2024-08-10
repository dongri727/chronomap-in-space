import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'gl_script.dart' show glScript;

class Paths extends StatefulWidget {
  const Paths({super.key});

  @override
  PathsState createState() => PathsState();
}

class PathsState extends State<Paths> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic>? voyager1;
  List<dynamic>? voyager2;
  List<dynamic>? pioneer10;
  List<dynamic>? interstellar;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final voyager1Data = await rootBundle.loadString('assets/json/voyager1.json');
    final voyager2Data = await rootBundle.loadString('assets/json/voyager2.json');
    final pioneer10Data = await rootBundle.loadString('assets/json/pioneer10.json');
    setState(() {
      List<dynamic> combineData = [];
      combineData.addAll(json.decode(voyager1Data));
      combineData.addAll(json.decode(voyager2Data));
      combineData.addAll(json.decode(pioneer10Data));

      interstellar = combineData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Interstellar Missions'),
      ),
      body: Center(
        child: SizedBox(
          width: 1200,
          height: 1000,
          child: interstellar == null
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
          var z = 0;  // z軸は0で固定
          data.push([x, y, z]);
        }
        return data;
      }

      return {
        grid3D: {
          viewControl: {
            alpha: 40,
            beta: -60
          }
        },
        xAxis3D: {
          type: 'value',
          min: -600,
          max: 600,
          splitLine: {show: false},
          name: 'Pisces-Virgo',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }
        },
        yAxis3D: {
          type: 'value',
          min: -600,
          max: 600,
          splitLine: {show: false},                  
          name: 'Gemini-Sagittarius',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }
        },
        zAxis3D: {
          type: 'value',
          min: -600,
          max: 600,
          splitLine: {show: false},
          name: 'North Ecliptic Pole',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }                                 
        },
        series: [
          {
            type: 'scatter3D',
            symbolSize: 5,
            data: ${json.encode(interstellar)},
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
            data: generateOrbitData(14.96, 0.1), // 地球
            itemStyle: { color: '#FF6347' } 
          },
          {
            type: 'scatter3D',
            symbolSize: 2,
            data: generateOrbitData(22.8, 0.1), // 火星
            itemStyle: { color: '#FF6347' } 
          },
          {
            type: 'scatter3D',
            symbolSize: 2,
            data: generateOrbitData(77.85, 0.05), // 木星
            itemStyle: { color: '#FF6347' } 
          }, 
          {
            type: 'scatter3D',
            symbolSize: 2,
            data: generateOrbitData(143.20, 0.05), // 土星
            itemStyle: { color: '#FF6347' }
          }, 
          {
            type: 'scatter3D',
            symbolSize: 2,
            data: generateOrbitData(286.7, 0.01), // 天王星
            itemStyle: { color: '#FF6347' }
          }, 
          {
            type: 'scatter3D',
            symbolSize: 2,
            data: generateOrbitData(451.5, 0.01), // 海王星
            itemStyle: { color: '#FF6347' }       
          },
              {
              type: 'scatter3D',
              symbolSize: 3,
              data: (function () {
                var data = [];
                var radius = 1100;
                for (var phi = 0; phi < Math.PI; phi += Math.PI / 36) {
                  for (var theta = 0; theta < 2 * Math.PI; theta += Math.PI / 36) {
                    var x = radius * Math.sin(phi) * Math.cos(theta);
                    var y = radius * Math.sin(phi) * Math.sin(theta);
                    var z = radius * Math.cos(phi);
                    data.push([x, y, z]);
                  }
                }
                return data;
              })(),
              itemStyle: { color: 'grey' }  // 半径1100の球
            }
        ]
      };
    })()
    ''',
          ),
        ),
      ),
    );
  }
}
