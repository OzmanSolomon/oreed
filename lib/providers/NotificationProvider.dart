import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oreeed/resources/NotificationRepo.dart';

class NotificationProvider with ChangeNotifier {
  bool _notifyTripStart = false;
  bool _notifyTripEnd = false;
  bool _notifyWhenTripComplete = false;

  List<SingleNotificationObj> notifications = [];
  String fCMToken;
  bool _isFetching = false;
  String responseMessage = "";
  int page = 1;
  int newNotifications = 0;
  List<SingleNotificationObj> get getNotifications => notifications;
  String get getFCMToken => fCMToken;
  bool get isFetching => _isFetching;
  bool get notifyBeforeTrip => _notifyTripStart;
  bool get notifyAfterTrip => _notifyTripEnd;
  bool get notifyWhenTripComplete => _notifyWhenTripComplete;

  void updateNotificationSettings(int index, bool status) {
    switch (index) {
      case 2:
        _notifyTripStart = status;
        break;
      case 3:
        _notifyTripEnd = status;
        break;
      case 4:
        _notifyWhenTripComplete = status;
        break;
      default:
        print(
            "sorry but You Must be out Off Logic To Retch This fare ! Idiot ");
        break;
    }
    notifyListeners();
  }

  void updateFCMToken(String token) {
    fCMToken = token;
    print("Token Updated successfully");
    notifyListeners();
  }

  void incrementer(List<SingleNotificationObj> list) {
    for (int i = 0; i < notifications.length; i++) {
      if (notifications[i].data.isRead == false) {
        newNotifications = newNotifications + 1;
      }
      notifyListeners();
    }
  }

  void loadNotifications() async {
    _isFetching = true;
    incrementer(notifications);
    NotificationRepo().getNotifications().then((value) {
      _isFetching = false;
      switch (value.code) {
        case 0:
          responseMessage = value.msg.toString();
          break;
        case 1:
          responseMessage = value.msg.toString();
          List<SingleNotificationObj> list = value.object;
          for (int i = 0; i < list.length; i++) {
            if (!notifications.contains(list[i])) {
              notifications.add(list[i]);
            }
          }
          break;
        case 2:
          responseMessage = value.msg.toString();
          break;
        default:
          responseMessage = value.msg.toString();
          break;
      }
    });
    notifyListeners();
  }

  void addNotification(SingleNotificationObj notificationObj) {
    if (notifications != null) {
      notifications.add(notificationObj);
    }
    notifyListeners();
  }

  void messageIsRead(int index) {
    if (notifications.isNotEmpty) {
      notifications[index].data.isRead = true;
    }
    notifyListeners();
  }

  void deleteMessage(int index) {
    if (notifications.isNotEmpty) {
      notifications.removeAt(index);
    }
    notifyListeners();
  }

  void clearAllMessage(int index) {
    if (notifications.isNotEmpty) {
      notifications.clear();
    }
    notifyListeners();
  }
}

// To parse this JSON data, do
// final notificationObj = notificationObjFromMap(jsonString);

NotificationObj notificationObjFromMap(String str) =>
    NotificationObj.fromMap(json.decode(str));

String notificationObjToMap(NotificationObj data) => json.encode(data.toMap());

class NotificationObj {
  NotificationObj({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    this.data,
  });

  int responseCode;
  String responseStatus;
  String responseMessage;
  List<SingleNotificationObj> data;

  factory NotificationObj.fromMap(Map<String, dynamic> json) => NotificationObj(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        data: List<SingleNotificationObj>.from(
            json["data"].map((x) => SingleNotificationObj.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ResponseCode": responseCode,
        "ResponseStatus": responseStatus,
        "ResponseMessage": responseMessage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class SingleNotificationObj {
  SingleNotificationObj({
    this.notification,
    this.data,
  });

  Notification notification;
  Data data;

  factory SingleNotificationObj.fromMap(Map<String, dynamic> json) =>
      SingleNotificationObj(
        notification: Notification.fromMap(json["notification"]),
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "notification": notification.toMap(),
        "data": data.toMap(),
      };
}

class Data {
  Data({
    this.title,
    this.isRead,
    this.date,
    this.dateHuman,
    this.other,
  });

  String title;
  bool isRead;
  DateTime date;
  String dateHuman;
  List<dynamic> other;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        title: json["title"],
        isRead: json["isRead"],
        date: DateTime.parse(json["date"]),
        dateHuman: json["date_human"],
        other: List<dynamic>.from(json["other"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "isRead": isRead,
        "date": date.toIso8601String(),
        "date_human": dateHuman,
        "other": List<dynamic>.from(other.map((x) => x)),
      };
}

class Notification {
  Notification({
    this.title,
    this.body,
  });

  String title;
  String body;

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "body": body,
      };
}
