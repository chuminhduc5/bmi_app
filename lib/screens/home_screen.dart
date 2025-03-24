import 'package:bmi_app/models/bmi_model.dart';
import 'package:bmi_app/services/database_helper.dart';
import 'package:bmi_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../data/advice_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _result = "";
  String _advice = "";

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _checkBMI() async {
    // Convert dữ liệu nhập vào sang dạng double
    double weight = double.tryParse(_weightController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    String evaluate = "";
    String advice = "";

    // Kiểm tra giá trị người dùng nhập vào
    if (weight <= 0 || height <= 0) {
      setState(() {
        _result = "Bạn hãy nhập vào chỉ số chiều cao và cân nặng";
      });
      return;
    }

    // Tính chỉ số bmi
    double bmi = weight / (height * height);

    // Ở đây không dùng switch-case vì trong Dart switch-case chỉ hỗ trợ cho 1 giá trị cụ thể
    // Các chỉ số này lấy theo bảng đánh giá quốc tế
    if (bmi < 18.5) {
      evaluate = "Gầy";
    } else if (bmi <= 24.9) {
      evaluate = "Bình thường";
    } else if (bmi <= 29.9) {
      evaluate = "Tăng cân";
    } else if (bmi <= 34.9) {
      evaluate = "Béo phì độ 1";
    } else if (bmi <= 39.9) {
      evaluate = "Béo phì độ 2";
    } else if (bmi >= 40) {
      evaluate = "Béo phì độ 3";
    }

    // Lưu các thông tin và database
    await DatabaseHelper.instance.insertBMI(BMIModel(
      name: _nameController.text,
      weight: weight,
      height: height,
      bmi: bmi,
      evaluate: evaluate,
    ));

    // Sử dụng firstWhere để tìm kiếm giá trị phù hợp
    // firstWhere sẽ duyệt qua danh sách và lays giá trị đầu tiên khớp
    advice = advices.firstWhere((a) => a.bmi == evaluate).advice;

    setState(() {
      // chỉ số bmi lúc này đang ở dạng double nên chưa thể hiện ra ở dạng text
      // Sử dụng .toStringAsFixed để convert từ double sang String
      // số 2 trong ngoặc có nghĩa là giữ lại 2 số sau dấu phẩy khi convert
      _result = "Chỉ số BMI của bạn là: ${bmi.toStringAsFixed(2)} - $evaluate";
      _advice = "Lời khuyên dành cho bạn:\n$advice";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Ứng dụng đo chỉ số BMI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
            icon: Icon(Icons.history),
          )
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget(
              label: "Họ và tên",
              controller: _nameController,
              type: TextInputType.text,
            ),
            TextFieldWidget(
              label: "Cân nặng (kg)",
              controller: _weightController,
              type: TextInputType.number,
            ),
            TextFieldWidget(
              label: "Chiều cao",
              controller: _heightController,
              type: TextInputType.number,
            ),
            _buildButton(
              title: 'Kiểm tra',
              onPressed: () async {
                _checkBMI();
              },
            ),
            Text("Kết quả: $_result"),
            Expanded(
              child: ListView(
                children: [
                  Text(_advice),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required String title, required Function()? onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightBlueAccent,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
