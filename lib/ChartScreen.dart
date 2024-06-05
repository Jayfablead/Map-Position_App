import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData(this.category, this.value);
  final String category;
  final double value;
}

class DynamicChart extends StatefulWidget {
  @override
  _DynamicChartState createState() => _DynamicChartState();
}

class _DynamicChartState extends State<DynamicChart> {
  bool N1 = false;
  bool N2 = false;
  bool N3 = false;

  List<_ChartData> _chartData = [];

  List<_ChartData> _allChartData = [
    _ChartData('N1', 30),
    _ChartData('N2', 40),
    _ChartData('N3', 30),
  ];

  void _updateChartData() {
    setState(() {
      _chartData = [];
      if (N1) _chartData.add(_allChartData[0]);
      if (N2) _chartData.add(_allChartData[1]);
      if (N3) _chartData.add(_allChartData[2]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Chart with Checkboxes'),
      ),
      body: Column(
        children: [
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<_ChartData, String>(
                dataSource: _chartData,
                xValueMapper: (_ChartData data, _) => data.category,
                yValueMapper: (_ChartData data, _) => data.value,
                radius: '70%',
                explode: true,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 14, color: Colors.black),
                  labelPosition: ChartDataLabelPosition.inside,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: N1,
                    onChanged: (bool? value) {
                      setState(() {
                        N1 = value!;
                        _updateChartData();
                      });
                    },
                  ),
                  Text("N1", style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: N2,
                    onChanged: (bool? value) {
                      setState(() {
                        N2 = value!;
                        _updateChartData();
                      });
                    },
                  ),
                  Text("N2", style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: N3,
                    onChanged: (bool? value) {
                      setState(() {
                        N3 = value!;
                        _updateChartData();
                      });
                    },
                  ),
                  Text("N3", style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: DynamicChart()));
