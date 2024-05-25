//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
//
// class MyPiechartscreen extends StatefulWidget {
//   const MyPiechartscreen({super.key});
//
//   @override
//   State<MyPiechartscreen> createState() => _MyPiechartscreenState();
// }
//
// class _MyPiechartscreenState extends State<MyPiechartscreen> {
//   late List<GDPData1> _chartData;
//   late TooltipBehavior _tooltipBehavior;
//
//   @override
//   void initState() {
//     _chartData = getChartData();
//
//     _tooltipBehavior=TooltipBehavior(enable: true);
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title:Text("Circular Chart",style: TextStyle(color: Colors.black),),centerTitle: true ,),
//         body:   SfCircularChart(
//           title: ChartTitle(text: 'Containent wise GDP - 2023 \n (in billons of USD)'),
//           legend: Legend(isVisible: true,overflowMode: LegendItemOverflowMode.wrap,alignment:ChartAlignment.near),
//           tooltipBehavior: _tooltipBehavior,
//           series: <RadialBarSeries<GDPData1, String>>[
//             RadialBarSeries<GDPData1, String>(
//               dataSource: getChartData(),
//               xValueMapper: (GDPData1 data, _) => data.containent,
//               yValueMapper: (GDPData1 data, _) => data.gdp,
//             ),
//           ],
//         ),
//     );
//   }
//
//   List<GDPData1> getChartData() {
//     final List<GDPData1> chartData = [
//       GDPData1('Oceania', 50000),
//       GDPData1('Africa', 10000),
//       GDPData1('s America', 1900),
//       GDPData1('Europe', 3000),
//       GDPData1('asia', 1200),
//       GDPData1('N America', 5555555555555),
//     ];
//     return chartData;
//   }
// }
//
// class GDPData1 {
//   GDPData1(this.containent, this.gdp);
//   final String containent;
//   final int gdp;
// }
//
//

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
//
//
//
// class MyPiechart extends StatefulWidget {
//   const MyPiechart({super.key});
//
//   @override
//   State<MyPiechart> createState() => _MyPiechartState();
// }
//
// class _MyPiechartState extends State<MyPiechart> {
//
//   late TooltipBehavior _tooltipBehavior;
//
//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Circular Chart", style: TextStyle(color: Colors.black),),
//           centerTitle: true,),
//         body:Stack(
//
//           alignment: Alignment.center,
//           children: [
//             Text("Abc"),
//             PieChart(
//                 swapAnimationDuration:Duration(milliseconds: 750) ,
//                 swapAnimationCurve: Curves.easeInOutQuint,
//                 PieChartData(
//                   sections: [
//                     PieChartSectionData(
//                       value: 20,
//                       color: Colors.blue,
//                     ),
//                     PieChartSectionData(
//                       value: 200,
//                       color: Colors.red,
//                     ),
//                     PieChartSectionData(
//                       value: 20,
//                       color: Colors.amber,
//                     ),
//                     PieChartSectionData(
//                       value: 20,
//                       color: Colors.green,
//                     ),
//                     PieChartSectionData(
//                       value: 20,
//                       color: Colors.black,
//                     ),
//                     // You can add more sections here
//                   ],
//                 )
//             )
//           ],
//         )
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartsScreen extends StatefulWidget {
  const PieChartsScreen({super.key});

  @override
  State<PieChartsScreen> createState() => _PieChartsScreenState();
}

class _PieChartsScreenState extends State<PieChartsScreen> {
  List chartdata=[
    [40,"rent",Color.fromRGBO(82, 98, 255, 1)],
    [10,"N1",Color.fromRGBO(82, 98, 255, 1)],
    [35,"N2",Color.fromRGBO(82, 98, 255, 1)],
    [60,"n3",Color.fromRGBO(82, 98, 255, 1)],
    [70,"N4",Color.fromRGBO(82, 98, 255, 1)],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SfCircularChart(
        series: [
          PieSeries(
            dataSource:chartdata,
            yValueMapper: (data,_)=>data[0],
            xValueMapper: (data,_)=>data[1] ,
            radius: "70%",
            explode: true,
            // pointColorMapper: (data,_)=>data[2],
            // dataLabelMapper: (data,_)=>data[0].toString(),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(fontSize: 14,color: Colors.black),
              labelPosition: ChartDataLabelPosition.inside
            ),


          )
        ],
      ) ,
    );
  }
}
