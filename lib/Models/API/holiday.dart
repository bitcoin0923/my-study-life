import 'package:intl/intl.dart';

class Holiday {
  int? id;
  int? userId;
  String? title;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  String? startDate;
  String? endDate;
  String? newImagePath;

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

  String getFormattedStartDate() {
    DateTime? createdAtDate = DateTime.tryParse(startDate ?? "");

    if (createdAtDate != null) {
      String formattedDate =
          DateFormat('EEE, d MMM, yyyy').format(createdAtDate);
      return formattedDate;
    } else {
      return "Fri, 4 Mar 2023";
    }
  }

  String getFormattedEndDate() {
    DateTime? createdAtDate = DateTime.tryParse(endDate ?? "");

    if (createdAtDate != null) {
      String formattedDate =
          DateFormat('EEE, d MMM, yyyy').format(createdAtDate);
      return formattedDate;
    } else {
      return "Fri, 4 Mar 2023";
    }
  }

  DateTime getStartDate() {
    return DateTime.tryParse(startDate ?? "") ?? DateTime.now();
  }

  DateTime getEndDate() {
    return DateTime.tryParse(endDate ?? "") ?? DateTime.now();
  }

  Holiday(
      {this.id,
      this.userId,
      this.title,
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      this.startDate,
      this.endDate,
      this.newImagePath});

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
