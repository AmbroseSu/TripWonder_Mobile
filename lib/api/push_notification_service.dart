
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class PushNotificationService{

  static Future<String> getAccessToken() async{

    final serviceAcountJson = {
      "type": "service_account",
      "project_id": "tripwonder-63139",
      "private_key_id": "5b4fce2bf80481d1dfbc85763e536b122fbf12c9",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCwbcY7tY/KsqtG\nW4KB9yvbxA1vGJefzzczgDZTZEYQvGpznESWToVMtPgOQEn0Z/n+N8j04ts14OSP\nodjD9onmd8RImEsuX0hbYRH5PA6rdZqId/jG8JaOL04l5B+p/O1GH1gp4lq4SSDA\n2TTQ5IalklnnwrOT/olDJzj18TjIDZnkWpHV2rg9cnlqnmPKIeuzpM7hqcHJDXte\nRLQQrX5D6GpOmTSg0vQtmWVe4nY19YlAozy20zCt4uNPEhi6YaKl0vc20oHwlJ0u\n3mE+aF29Zclg6XDiRbWyU7kFHWBEVRqTuGje1vMttDnqCzcmVCbgsipQ5l1vqpLu\nuX9+6H7vAgMBAAECggEACrz6kKTvf0RDhHNTsVFcjASV6U6Ou/jCwMiQGDKzEipF\noYstoF4Wh3z2j4nHUfksa4PP+6xGgsZsh3cvxg2ehn+lW5k0yjoK/Rlnru95Iay+\nekB58UQeTuZIeM5/sk1Aq9MVI35WAzaSg3yinyw74lUcCOP+RhkfqjJlO7UyBq+Q\n/roil2MG1xlYceJyvpC+xgacvi6Cf2gmpqqWpIq93jWy7PMMS3J5iXcdzSvU4Mn4\nhHKAoMxth2XKOYiE4K/gGHM43Hx0YKsr3BT6uKRjAIX8jLx+Suf9vu2lDQvKc0aE\nk8Qc03N6U2ywFHvofxeC+Q2qxbL+a0q3eGRrihf5wQKBgQDm4ZkMSNOmd3f/9CmQ\nrj7KWOqvXXGP7KJjPIHOeIlpk1p3Nhkib9//6vM1HmxXl5nL9/sgxWjQp8qgY7f+\noxIKfc7Mb+ARNXAf+kBsnaDKwjrk6rAYymDo2h38kOfNI/IoFgH5nbHj1Y6LQ/pG\nC2FARno+a6IZ3pqLtkbsvSsEcQKBgQDDn5dkCyd+Hg50RI9DOngV+QgGA5kibUF3\nTWo/AVw9CvuRQ5M5/Kh68q1Zp/pTIcwKsXpKMlVXEX0suGIIoWAVfFq0uaj7lBiE\nlpLGCkqvzZxKqVEUSSWBa9w3nVJEd3FHGN751dYwedvHseToQfzDB4m7rH4b4sWW\nP+rsCtfpXwKBgQDA8WblTTcStmQiEflqXzM6BnSZeI2eqTJLnBUeZrzu7aV8WklG\n7hdT1xTIH1SLHrX4LpQ/HropJQ/AWZU5xy0cd2aKkjO+Ldo13vxXyKLGzupIw5fG\nH9o8vYqxtqcAWDnWJg4gfBhdPeqRl41fW8M546vk3i3pUI32k61RygRZAQKBgAp1\njfKbZhEoKj2tLLu7dJA4MGWh654bmVR3nyafO/9HhwvNQSHokFmCgCI7CPdI50/r\nDU7KQiXVmYu6kANGHY0IiREAnDhXQrhUFKTiB/w+Ugzr4JnlD0xMKAoRL0TZ3gSf\nH8zb0gflfArBSCvi21DSJlsSbeuvxEC0Sis0qTahAoGAMO6I91D0FQNTDaPMGMgj\nfuLT0dbmMgykHdNh0ZLH6GmIxmYRdS1vHCszA7poXoweWwlSE6J+duVarSfSVPM6\nyPiKBBifKe+c76AElBpWUgUHPs/WDHk9oDYM8kZOKVscs8E134gC+W8ND35f52PU\n6/ZvpIe4ecycNuDs7BBCI3Q=\n-----END PRIVATE KEY-----\n",
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
    String endpointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/tripwonder-63139/messages:send';

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