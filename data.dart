import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Data {
  Data({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  int? id;
  String name;
  String email;
  String gender;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": gender,
        "status": status,
      };
}
