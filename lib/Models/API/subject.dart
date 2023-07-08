import 'package:intl/intl.dart';

class Subject {
  int? id;
  int? userId;
  String? subjectName;
  String? colorHex;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  bool? selected = false;
  String? newImageUrl;

  // Calculated

  String getFormattedDate() {
    DateTime? createdAtDate = DateTime.tryParse(createdAt ?? "");

    if (createdAtDate != null) {
      String formattedDate =
          DateFormat('MM/dd/yyyy HH:mm:ss').format(createdAtDate);
      return formattedDate;
    } else {
      return "";
    }
  }

  Subject(
      {this.id,
      this.userId,
      this.subjectName,
      this.colorHex,
      this.imageUrl,  
      this.createdAt,
      this.updatedAt,
      this.selected,
      this.newImageUrl});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        id: json['id'],
        userId: json['userId'],
        subjectName: json['subject'],
        colorHex: json['color'],
        imageUrl: json['imageUrl'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['subject'] = subjectName;
    data['color'] = colorHex;
    data['imageUrl'] = imageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
