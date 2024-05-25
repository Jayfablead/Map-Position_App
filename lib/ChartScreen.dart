

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class MyPiechartscreen extends StatefulWidget {
  const MyPiechartscreen({super.key});

  @override
  State<MyPiechartscreen> createState() => _MyPiechartscreenState();
}

class _MyPiechartscreenState extends State<MyPiechartscreen> {
  late List<GDPData1> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();

    _tooltipBehavior=TooltipBehavior(enable: true);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text("Circular Chart",style: TextStyle(color: Colors.black),),centerTitle: true ,),
        body:   SfCircularChart(
          title: ChartTitle(text: 'Containent wise GDP - 2023 \n (in billons of USD)'),
          legend: Legend(isVisible: true,overflowMode: LegendItemOverflowMode.wrap,alignment:ChartAlignment.near),
          tooltipBehavior: _tooltipBehavior,
          series: <RadialBarSeries<GDPData1, String>>[
            RadialBarSeries<GDPData1, String>(
              dataSource: getChartData(),
              xValueMapper: (GDPData1 data, _) => data.containent,
              yValueMapper: (GDPData1 data, _) => data.gdp,
            ),
          ],
        ),
    );
  }

  List<GDPData1> getChartData() {
    final List<GDPData1> chartData = [
      GDPData1('Oceania', 50000),
      GDPData1('Africa', 10000),
      GDPData1('s America', 1900),
      GDPData1('Europe', 3000),
      GDPData1('asia', 1200),
      GDPData1('N America', 5555555555555),
    ];
    return chartData;
  }
}

class GDPData1 {
  GDPData1(this.containent, this.gdp);
  final String containent;
  final int gdp;
}


