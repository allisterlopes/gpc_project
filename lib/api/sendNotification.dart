import 'dart:convert';
import 'package:http/http.dart' as http;

class Notify {
  static Notify _instance;
  static Notify getInstance() => _instance ??= Notify();

  final postUrl = 'https://fcm.googleapis.com/fcm/send';



  Future<bool> sendNotification({String title, String body, String type}) async {

    final data = {
      "topic": "ComputerGpc",
//      "to": "d9Frv689jwY:APA91bFPgodKI8BC6goax4YEbIlnbioY3v-xe1YarWE5mmpNltiPr6CVp1NSLG_-MehYQfbTdt5b5TUaVea5ACnWgUjJXXF9rvgjDO_Z74JqIQlpcxz7LJgVYIR37OQCMSkUefdQ90lL",
      "notification": {"body": body, "title": title},
      "priority": "high",
      "data": {
        "type": type,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        "sound": 1,
        "vibrate":1,
      },
    };
  final headers = {
  'content-type': 'application/json',
  'Authorization': 'key=AAAAzNy-MoE:APA91bG2jpoQWGDm3SwarAZ-ZxBN3sXQZAHro4kc5BMe1c1vkc9BYBxnyX-PUEVIeaT8f4rVAA5bu4-8JniKdIoVJ9ipvZE59R0_mf1S6IsMUblkpnHAKu4kCE_2qPE9xvjp_g3FY3wc'
  };

  final response = await http.post(postUrl,
  body: json.encode(data),
  encoding: Encoding.getByName('utf-8'),
  headers: headers);
  print(response.body);
  }

}
