import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sizer/sizer.dart';

class ProtectionChart extends StatefulWidget {
  @override
  _ProtectionChartState createState() => _ProtectionChartState();
}

class _ProtectionChartState extends State<ProtectionChart> {
  bool NE1 = false;
  bool NE2 = false;
  bool NE3 = false;
  bool N1 = false;
  bool N2 = false;
  bool N3 = false;
  bool E1 = false;
  bool E2 = false;
  bool E3 = false;

  List<RadarEntry> getRadarEntries() {
    List<RadarEntry> entries = [];

    if (NE1) entries.add(RadarEntry(value: 1));
    if (NE2) entries.add(RadarEntry(value: 2));
    if (NE3) entries.add(RadarEntry(value: 3));
    if (N1) entries.add(RadarEntry(value: 4));
    if (N2) entries.add(RadarEntry(value: 5));
    if (N3) entries.add(RadarEntry(value: 6));
    if (E1) entries.add(RadarEntry(value: 7));
    if (E2) entries.add(RadarEntry(value: 8));
    if (E3) entries.add(RadarEntry(value: 9));

    // Ensure there are at least 3 entries
    while (entries.length < 3) {
      entries.add(RadarEntry(value: 0)); // Adding default 0 values if less than 3
    }

    return entries;
  }

  Color getColor(String direction) {
    if (direction == "NE") {
      if (NE3) return Colors.green;
      if (NE2) return Colors.red;
      if (NE1) return Colors.yellow;
    }
    if (direction == "N") {
      if (N3) return Colors.green;
      if (N2) return Colors.red;
      if (N1) return Colors.yellow;
    }
    if (direction == "E") {
      if (E3) return Colors.green;
      if (E2) return Colors.red;
      if (E1) return Colors.yellow;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            Container(
              height: 50.h,
              child: RadarChart(
                RadarChartData(
                  dataSets: [
                    RadarDataSet(
                      fillColor: getColor("NE").withOpacity(0.5),
                      borderColor: getColor("NE"),
                      dataEntries: getRadarEntries(),
                    ),
                    RadarDataSet(
                      fillColor: getColor("N").withOpacity(0.5),
                      borderColor: getColor("N"),
                      dataEntries: getRadarEntries(),
                    ),
                    RadarDataSet(
                      fillColor: getColor("E").withOpacity(0.5),
                      borderColor: getColor("E"),
                      dataEntries: getRadarEntries(),
                    ),
                  ],
                  radarBackgroundColor: Colors.transparent,
                ),
              ),
            ),
            Column(
              children: [
                Text("Northeast (NE) : -"),
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: NE1,
                          onChanged: (bool? value) {
                            setState(() {
                              NE1 = value!;
                              NE2 = false;
                              NE3 = false;
                            });
                          },
                        ),
                        Text("Some protection"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: NE2,
                          onChanged: (bool? value) {
                            setState(() {
                              NE1 = false;
                              NE2 = value!;
                              NE3 = false;
                            });
                          },
                        ),
                        Text("Average protection"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: NE3,
                          onChanged: (bool? value) {
                            setState(() {
                              NE1 = false;
                              NE2 = false;
                              NE3 = value!;
                            });
                          },
                        ),
                        Text("Completely protected"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text("North(N) : -"),
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: N1,
                          onChanged: (bool? value) {
                            setState(() {
                              N1 = value!;
                              N2 = false;
                              N3 = false;
                            });
                          },
                        ),
                        Text("Some protection"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: N2,
                          onChanged: (bool? value) {
                            setState(() {
                              N1 = false;
                              N2 = value!;
                              N3 = false;
                            });
                          },
                        ),
                        Text("Average protection"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: N3,
                          onChanged: (bool? value) {
                            setState(() {
                              N1 = false;
                              N2 = false;
                              N3 = value!;
                            });
                          },
                        ),
                        Text("Completely protected"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text("East (E): -"),
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: E1,
                          onChanged: (bool? value) {
                            setState(() {
                              E1 = value!;
                              E2 = false;
                              E3 = false;
                            });
                          },
                        ),
                        Text("Some protection"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: E2,
                          onChanged: (bool? value) {
                            setState(() {
                              E1 = false;
                              E2 = value!;
                              E3 = false;
                            });
                          },
                        ),
                        Text("Average protection"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: E3,
                          onChanged: (bool? value) {
                            setState(() {
                              E1= false;
                              E2 = false;
                              E3 = value!;
                            });
                          },
                        ),
                        Text("Completely protected"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
