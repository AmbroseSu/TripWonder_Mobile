
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class PushNotificationService{

  static Future<String> getAccessToken() async{

    final serviceAcountJson = {
      "type": "service_account",
      "project_id": "tripwonder-63139",
      "private_key_id": "4743e1e9139fe8532e3845057f441c310e1ab6f9",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCRMbtjg4aXCpu3\nM6Pp1rTzG66RXg9rM/JEKaKYthanqLeK6KA+mV8A1z/iAVTDwrSu1bcgz9K9JUPw\nwg0+Er2wQdECVtzstSpE+yN6Cl0cjUKfrVrQ0wObhuttW3ppwE1g1/+DEMpyrp3F\n9xWIzLYG5jMqt+dwOYmMCsTe3tBA4fAAy3ohr2ei0VJiUdDtFcpP/VDLimRqN1/D\ndhhOk7Wgo8bGqPdJajvFnbKe+8+pl+Rj7w7dxRcEPrk5NrX7lKFnuftKUatVQuUO\n/QAyoSBbWeFiGRdFpUFVLuQyFIrpOBm4o8GXJU3S2goTWGBUoyYUc6Kwee3KU2W+\nTrp/p/ctAgMBAAECggEAEmr16PWyM6QLhKhu+Sax5XTJfB8ruDRACG16TAItIC9t\nY5gxW5TQ/FD8WuBDBGIafA3Cy81mX3VEB7JV7l3U5MWJ4dDATYvdmh/RVushoebk\nC0/43oHQn1X0tKE6B1gheKYYVLk4imZOv+H2lVfXxKBG3/sGx1xFGm1InozdFfMM\n28hPO1pY5sUW58H/PSUdxnfvzmW4nbt0Yr0BKBiMrFJH2gZ+FrEBH8eBkxKMT9sH\nvhBQ0/By5JuZM34sZMf4RVWuvJTK+KjbvdL4RQ5FrDCpngp4IyAFiAwC0Qc8WAAv\nY+3WWx8hKbvBOrjyXdIftX+fiEXcQsH+dkIVdGwZcQKBgQDH2McFWNRGj39ZjC/P\nq+VMVHxZVY+b+11hiU6+RfJZHTjKfSz5mtZe+CBXciS1SqOIPbxDNkFVQMg2uhwV\nz4KNBs3h2UXoabxYkkC5/jK40dccaQ8gWtHbYOaOfvI5UV7Osbe5eNe8TBFIIGGv\nasazO0Vpswze8KmgIpTVuZSUywKBgQC5/btxgqNnqWj0Sz68WAHM/eohL8N3Znkx\npaSqZHd/wX1VVWa4F6IdkaXhW3AbKLyIYGrqZju8MCZ41ay3J/Qdk5xHhYxz4PAO\nj2pr0EsXmjtaoUtNv4EOQEaFqkjKFRokrMK9EyvkRiE6ykorrOpHgI5Eklfv/woE\nQYD0TH6c5wKBgQCs/ncRptpiljc8MgD1OSzNjVjzEAC3mrk0BGMYjH4ELCqMBh2X\nmDQ3k3yTleg20vyKpD5CxEV74g8uaJ6FNtMg9yHjfmxoipcS6M+E8YnAuU0Hd94z\nOMrup4wND9DoUwrJy8dpkzTU99gB4p4M9lY4snccz3S1zAhZ6XWDKRl4TwKBgFSO\nkYBalzWSpH+kEeKI1FDBA4eQ8nm/Icw7dXBt+pIfgn6gM/Hv9KkixVp+OqpuS8Bo\nrVLhpbi531PCOSKPzIEB0eQGSEOKeTj1ZLmdWfZiDSf3+odfUCoNeMJeF3egPmF8\nFZDmPWcrpwHWZAAVPfHB9WwhaE9ZENG8ggcPG+TzAoGASm7NWgblTjgUCRRXIRfm\nIhyRQL8NKVY85mTxeGMpgpOeZdf1T7nqNH1E77bVBfH+cV82itCTNb3daD0QINtq\nB9hIVkPjQJVtQNO07TNaW192ZGw/TfurdCqi8DV1vH6Fok8plX9HSEr43sL26wPP\nVaEFMdFFq1XDRu8v1A8I1Nk=\n-----END PRIVATE KEY-----\n",
      "client_email": "tripwonder@tripwonder-63139.iam.gserviceaccount.com",
      "client_id": "112223751822951882383",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/tripwonder%40tripwonder-63139.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes =
        [
          //"https://www.googleapis.com/auth/userinfo.email",
          //"https://www.googleapis.com/auth/firebase.database",
          "https://www.googleapis.com/auth/firebase.messaging"
        ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAcountJson),
      scopes,
    );

    //get the access token
    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAcountJson),
      scopes,
        client
    );

    client.close();

    return credentials.accessToken.data;

  }
  static sendNotificationToSelectedDrived(String? deviceToken, BuildContext context, String title, String body) async {
    final String serverAccessTokenKey = await getAccessToken();
    if (serverAccessTokenKey == null) {
      print('Failed to get access token.');
      return;
    } else {
      print(
          '0000000000000000000000000000000000000000000000000000000000000000000$serverAccessTokenKey');
      print(
          '99999999999999999999999999999999999999999999999999999999$deviceToken');
    }
    String endpointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/ticket-resell-app-33551/messages:send';

    final Map<String, dynamic> message =
    // {
    //   'message' :
    //       {
    //         'token' : deviceToken,
    //         'notification' :
    //         {
    //           'title' : "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh",
    //           'body' : 'tgshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh'
    //         }
    //       }
    // };
    {
      "message": {
        "token": deviceToken,
        "notification": {
          "body": body,
          "title": title
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessTokenKey'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print(response.body);
      print("Notification send Successfully");
    } else {
      print(
          "Failed Notification not send111111111111111111111111111111111111111111111: ${response
              .statusCode}");
      print("Response body: ${response.body}");
    }
  }
}