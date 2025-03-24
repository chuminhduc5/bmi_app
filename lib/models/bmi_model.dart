class BMIModel {
  final int? id;
  final String name;
  final double weight;
  final double height;
  final double bmi;
  final String evaluate;

  const BMIModel({
    this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.bmi,
    required this.evaluate,
  });

  // .fromMap chuyển đổi dữ liệu từ Map<String, dynamic> sang Object
  // .fromJson tác dụng tương tự
  // sử dụng sqflite là 1 dữ liệu cục bộ nên dùng .fromMap
  factory BMIModel.fromMap(Map<String, dynamic> json) {
    return BMIModel(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      height: json['height'],
      bmi: json['bmi'],
      evaluate: json['evaluate']
    );
  }

  // Sử dụng toMap để chuyển đổi từ Object sang Map<String, dynamic> (lưu vào sqflite)
  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "id": id,
      "name": name,
      "weight": weight,
      "height": height,
      "bmi": bmi,
      "evaluate": evaluate,
    };
  }
}
