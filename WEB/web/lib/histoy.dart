import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:web/settings.dart';
import 'package:web/user_model.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<UserModel> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              users = snapshot.data as List<UserModel>;
              return Container(
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                child: DataTable2(
                  columnSpacing: 20.0,
                  headingRowHeight: 40.0,
                  dataRowHeight: 56.0,
                  minWidth: MediaQuery.of(context).size.width + 100,
                  border: TableBorder.all(
                    color: Colors.grey.shade300,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  columns: getColumns(),
                  rows: getUsersRows(users),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.blue,
              size: 60,
            );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text('History'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left, size: 40.0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Future<List<UserModel>> fetchData() async {
    final response = await http.get(Uri.parse('$apiURL/get_data'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<DataRow> getUsersRows(List<UserModel> users) {
    bool isEven = false;

    return users.map((user) {
      final color = isEven ? Colors.white : Colors.grey[200];
      isEven = !isEven;

      return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return color;
          },
        ),
        cells: [
          DataCell(Text(user.name)),
          DataCell(Text(user.address)),
          DataCell(Text(user.sex.toString())),
          DataCell(Text(user.age.toString())),
          DataCell(getSmokerCell(user.isSmoker == 1)),
          DataCell(Text(user.ciggPerDay.toString())),
          DataCell(Text(user.bPMeds.toString())),
          DataCell(Text(user.prevStroke.toString())),
          DataCell(Text(user.prevHyp.toString())),
          DataCell(Text(user.diabetes.toString())),
          DataCell(Text(user.totChol.toString())),
          DataCell(Text(user.sysBP.toString())),
          DataCell(Text(user.diaBP.toString())),
          DataCell(Text(user.bMI.toString())),
          DataCell(Text(user.heartRate.toString())),
          DataCell(Text(user.glucose.toString())),
          DataCell(getChdRiskCell(user.chdrisk)),
          DataCell(Text(user.addedOn.toString())),
        ],
      );
    }).toList();
  }

  getSmokerCell(bool isSmoker) {
    final color = !isSmoker ? Colors.red : Colors.green;
    return Text(
      isSmoker.toString(),
      style: TextStyle(color: color),
    );
  }

  getChdRiskCell(int chdRisk) {
    final color = chdRisk == 1 ? Colors.red : Colors.green;
    return Text(
      chdRisk.toString(),
      style: TextStyle(color: color),
    );
  }

  List<DataColumn> getColumns() {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);

    return [
      const DataColumn(
        label: FittedBox(child: Text('Name', style: headerStyle)),
        tooltip: 'User Name',
      ),
      const DataColumn(
        label: Text('Address', style: headerStyle),
        tooltip: 'User Address',
      ),
      const DataColumn(
        label: Text('Sex', style: headerStyle),
        tooltip: 'User Sex',
      ),
      const DataColumn(
        label: Text('Age', style: headerStyle),
        tooltip: 'User Age',
      ),
      const DataColumn(
        label: Text('Smoker', style: headerStyle),
        tooltip: 'Smoker Status',
      ),
      const DataColumn(
        label: Text('Cigarettes per Day', style: headerStyle),
        tooltip: 'Cigarettes per Day',
      ),
      const DataColumn(
        label: Text('Blood Pressure Meds', style: headerStyle),
        tooltip: 'BP Medications',
      ),
      const DataColumn(
        label: Text('Prev Stroke', style: headerStyle),
        tooltip: 'Previous Stroke',
      ),
      const DataColumn(
        label: Text('Prev Hypertension', style: headerStyle),
        tooltip: 'Previous Hypertension',
      ),
      const DataColumn(
        label: Text('Diabetes', style: headerStyle),
        tooltip: 'Diabetes Status',
      ),
      const DataColumn(
        label: Text('Total Cholesterol', style: headerStyle),
        tooltip: 'Total Cholesterol',
      ),
      const DataColumn(
        label: Text('Systolic BP', style: headerStyle),
        tooltip: 'Systolic Blood Pressure',
      ),
      const DataColumn(
        label: Text('Diastolic BP', style: headerStyle),
        tooltip: 'Diastolic Blood Pressure',
      ),
      const DataColumn(
        label: Text('BMI', style: headerStyle),
        tooltip: 'Body Mass Index',
      ),
      const DataColumn(
        label: Text('Heart Rate', style: headerStyle),
        tooltip: 'Heart Rate',
      ),
      const DataColumn(
        label: Text('Glucose', style: headerStyle),
        tooltip: 'Glucose Level',
      ),
      const DataColumn(
        label: Text('CHD risk', style: headerStyle),
        tooltip: 'CHD Risk Level',
      ),
      const DataColumn(
        label: Text('Added On', style: headerStyle),
        tooltip: 'Date Added',
      ),
    ];
  }
}
