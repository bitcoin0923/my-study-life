import 'package:intl/intl.dart';

class Xtra {
  String? imageUrl;
  int? id;
  int? userId;
  String? eventType;
  String? name;
  String? occurs;
  List<String>? days;
  String? startTime;
  String? endTime;
  String? startDate;
  String? endDate;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? newImagePath;

    // Calculated

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

  DateTime getFormattedStartingDate() {
    DateTime? createdAtDate = DateTime.tryParse(startDate ?? "");

    if (createdAtDate != null) {
      // String formattedDate =
      //     DateFormat('MM/dd/yyyy HH:mm:ss').format(createdAtDate);
      return createdAtDate;
    } else {
      return DateTime.now();
    }
  }

    DateTime getFormattedEndingDate() {
    DateTime? createdAtDate = DateTime.tryParse(endDate ?? "");

    if (createdAtDate != null) {
      // String formattedDate =
      //     DateFormat('MM/dd/yyyy HH:mm:ss').format(createdAtDate);
      return createdAtDate;
    } else {
      return DateTime.now();
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

  Xtra(
      {this.imageUrl,
      this.id,
      this.userId,
      this.eventType,
      this.name,
      this.occurs,
      this.days,
      this.startTime,
      this.endTime,
      this.startDate,
      this.endDate,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.newImagePath});

  Xtra.fromJson(Map<String, dynamic> json) {
       List<String> dayStrings = [];

    if (json['days'] != null) {
      List<dynamic> rawDays = json['days'];
      dayStrings = rawDays.map(
        (item) {
          return item as String;
        },
      ).toList();
    }

    imageUrl = json['imageUrl'];
    id = json['id'];
    userId = json['userId'];
    eventType = json['eventType'];
    name = json['name'];
    occurs = json['occurs'];
    days = dayStrings;
    startTime = json['startTime'];
    endTime = json['endTime'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    data['userId'] = userId;
    data['eventType'] = eventType;
    data['name'] = name;
    data['occurs'] = occurs;
    data['days'] = days;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}


  //  {
  //           "imageUrl": null,
  //           "id": 2,
  //           "userId": 3,
  //           "eventType": "test",
  //           "name": "Xtra 1",
  //           "occurs": "once",
  //           "days": null,
  //           "startTime": "11:00:00",
  //           "endTime": "12:00:00",
  //           "startDate": "2023-06-29",
  //           "endDate": "2023-06-29",
  //           "image": null,
  //           "createdAt": "2023-06-14T12:41:15.972Z",
  //           "updatedAt": "2023-06-14T12:41:15.972Z"
  //       },