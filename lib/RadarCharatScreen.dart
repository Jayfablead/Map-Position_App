import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:sizer/sizer.dart';



class RadarChartWithCheckboxes extends StatefulWidget {
  @override
  _RadarChartWithCheckboxesState createState() =>
      _RadarChartWithCheckboxesState();
}

class _RadarChartWithCheckboxesState extends State<RadarChartWithCheckboxes> {
  bool N1 = false;
  bool N2 = false;
  bool N3 = false;

  bool NE1 = false;
  bool NE2 = false;
  bool NE3 = false;

  bool E1 = false;
  bool E2 = false;
  bool E3 = false;

  bool SE1 = false;
  bool SE2 = false;
  bool SE3 = false;

  bool S1 = false;
  bool S2 = false;
  bool S3 = false;

  bool SW1 = false;
  bool SW2 = false;
  bool SW3 = false;

  bool W1 = false;
  bool W2 = false;
  bool W3 = false;

  bool NW1 = false;
  bool NW2 = false;
  bool NW3 = false;

  List<List<int>> data = [
    [0, 0, 0, 0, 0, 0, 0, 0],
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50.h,
            child: RadarChart.light(
              ticks: [2, 4, 6, 8, 10],
              features: ["N", "NE", "E", "SE", "S", "SW", "W", "NW"],
              data: data,
              // graphColors: [Colors.blue, Colors.green],
              // featuresTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          buildCheckboxRow('North (N)', [
            buildCheckbox('Some protection', N1, (val) {
              setState(() {
                N1 = val;
                updateData();
              });
            }),
            buildCheckbox('Average protection', N2, (val) {
              setState(() {
                N2 = val;
                updateData();
              });
            }),
            buildCheckbox('Completely protected', N3, (val) {
              setState(() {
                N3 = val;
                updateData();
              });
            }),
          ]),
          buildCheckboxRow('Northeast (NE)', [
            buildCheckbox('Some protection', NE1, (val) {
              setState(() {
                NE1 = val;
                updateData();
              });
            }),
            buildCheckbox('Average protection', NE2, (val) {
              setState(() {
                NE2 = val;
                updateData();
              });
            }),
            buildCheckbox('Completely protected', NE3, (val) {
              setState(() {
                NE3 = val;
                updateData();
              });
            }),
          ]),
          buildCheckboxRow('East (E)', [
            buildCheckbox('Some protection', E1, (val) {
              setState(() {
                E1 = val;
                updateData();
              });
            }),
            buildCheckbox('Average protection', E2, (val) {
              setState(() {
                E2 = val;
                updateData();
              });
            }),
            buildCheckbox('Completely protected', E3, (val) {
              setState(() {
                E3 = val;
                updateData();
              });
            }),
          ]),
          buildCheckboxRow('Southeast (SE)', [
            buildCheckbox('Some protection', SE1, (val) {
              setState(() {
                SE1 = val;
                updateData();
              });
            }),
            buildCheckbox('Average protection', SE2, (val) {
              setState(() {
                SE2 = val;
                updateData();
              });
            }),
            buildCheckbox('Completely protected', SE3, (val) {
              setState(() {
                SE3 = val;
                updateData();
              });
            }),
          ]),
          buildCheckboxRow('South (S)', [
            buildCheckbox('Some protection', S1, (val) {
              setState(() {
                S1 = val;
                updateData();
              });
            }),
            buildCheckbox('Average protection', S2, (val) {
              setState(() {
                S2 = val;
                updateData();
              });
            }),
            buildCheckbox('Completely protected', S3, (val) {
              setState(() {
                S3 = val;
                updateData();
              });
            }),
          ]),
          buildCheckboxRow('Southwest (SW)', [
            buildCheckbox('Some protection', SW1, (val) {
              setState(() {
                SW1 = val;
                updateData();
              });
            }),
            buildCheckbox('Average protection', SW2, (val) {
              setState(() {
                SW2 = val;
                updateData();
              });
            }),
            buildCheckbox('Completely protected', SW3, (val) {
              setState(() {
                SW3 = val;
                updateData();
              });
            }),
          ]),
          buildCheckboxRow('West (W)', [
            buildCheckbox('Some protection', W1, (val) {
              setState(() {
                W1 = val;
                updateData();
              });
            }),
            buildCheckbox('Average protection', W2, (val) {
              setState(() {
                W2 = val;
                updateData();
              });
            }),
            buildCheckbox('Completely protected', W3, (val) {
              setState(() {
                W3 = val;
                updateData();
              });
            }),
          ]),
          buildCheckboxRow('West (W)', [
            buildCheckbox('Some protection', NW1, (val) {
              setState(() {
                NW1 = val;
                updateData();
              });
            }),
            buildCheckbox('Average protection', NW2, (val) {
              setState(() {
                NW2 = val;
                updateData();
              });
            }),
            buildCheckbox('Completely protected', NW3, (val) {
              setState(() {
                NW3 = val;
                updateData();
              });
            }),
          ]),
          // Repeat for other directions...
        ],
      ),
    );
  }

  void updateData() {
    data[0] = [
      (N1 ? 3 : 0) + (N2 ? 3 : 0) + (N3 ? 4 : 0),
      (NE1 ? 3 : 0) + (NE2 ? 3 : 0) + (NE3 ? 4 : 0),
      (E1 ? 3 : 0) + (E2 ? 3 : 0) + (E3 ? 4 : 0),
      (SE1 ? 3 : 0) + (SE2 ? 3 : 0) + (SE3 ? 4 : 0),
      (S1 ? 3 : 0) + (S2 ? 3 : 0) + (S3 ? 4 : 0),
      (SW1 ? 3 : 0) + (SW2 ? 3 : 0) + (SW3 ? 4 : 0),
      (W1 ? 3 : 0) + (W2 ? 3 : 0) + (W3 ? 4 : 0),
      (NW1 ? 3 : 0) + (NW2 ? 3 : 0) + (NW3 ? 4 : 0),
    ];
  }

  Widget buildCheckboxRow(String label, List<Widget> checkboxes) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$label: -",
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "volken"),
            ),
          ],
        ),
        Column(children: checkboxes),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildCheckbox(
      String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? val) {
            onChanged(val!);
          },
        ),
        Text(
          label,
          style: TextStyle(
              letterSpacing: 1,
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "volken"),
        ),
      ],
    );
  }
}
