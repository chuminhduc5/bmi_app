import 'package:flutter/material.dart';
import '../models/bmi_model.dart';
import '../services/database_helper.dart';


class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<BMIModel>> _bmiList;

  @override
  void initState() {
    super.initState();
    _bmiList = DatabaseHelper.instance.getAllBMI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Lịch sử ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<BMIModel>>(
        future: _bmiList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.map((bmi) {
              return ListTile(
                title: Text("Họ và tên: ${bmi.name}"),
                subtitle: Text("Chỉ số BMI: ${bmi.bmi.toStringAsFixed(2)} - ${bmi.evaluate}"),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

