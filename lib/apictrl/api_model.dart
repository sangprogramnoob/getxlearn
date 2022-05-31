import 'dart:convert';

List<APIModel> apiModelFromJson(String str) => List<APIModel>.from(
      json.decode(str).map(
            (x) => APIModel.fromJson(x),
          ),
    );

String apiModelToJson(List<APIModel> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class APIModel {
  APIModel({
    required this.id,
    required this.activityType,
    required this.institution,
    required this.when,
    required this.objective,
    required this.remarks,
  });

  int id;
  String activityType;
  String institution;
  String when;
  String objective;
  String remarks;

  factory APIModel.fromJson(Map<String, dynamic> json) => APIModel(
        id: json["id"],
        activityType: json["activityType"],
        institution: json["institution"],
        when: json["when"],
        objective: json["objective"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activityType": activityType,
        "institution": institution,
        "when": when,
        "objective": objective,
        "remarks": remarks,
      };
}
