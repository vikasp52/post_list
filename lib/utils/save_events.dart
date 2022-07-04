import 'dart:convert';
import 'dart:io';

import 'package:benshi/repository/model/model.dart';
import 'package:benshi/screens/posts/cubit/post_cubit.dart';
import 'package:benshi/screens/settings/cubit/settings_cubit.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EventActions { open, paginated }

class Events {
  static final Events _singleton = Events._internal();

  factory Events() {
    return _singleton;
  }

  Events._internal();

  List<EventData> events = [];
  String emailbody = '';

  void addEvents({required PostData post}) {
    final meta = Meta(
      timestamp: DateTime.now().microsecondsSinceEpoch.toString(),
      location: Location(
        lat: post.user.address?.geo.lat,
        long: post.user.address?.geo.lng,
      ),
    );

    final event = EventData(
      appId: post.user.email,
      action: EventActions.open.name,
      resourceId: post.post.id,
      userId: post.user.id,
      meta: meta,
    );
    events.add(event);

    print('addEvents length: ${events.length}');

    events //convert list data  to json
        .map(
      (event) {
        event.toJson();
        print('addEvents length: ${event.toJson()}');
      },
    ).toList();
  }

  void sendEmail() async {
    print('sendEmail called');
    final prefs = await SharedPreferences.getInstance();
    String? _recipientsEmail = prefs.getString(SettingsCubit.emailId);

    String emailBody = events
        .map(
          (event) {
            event.toJson();
            print('addEvents length: ${event.toJson()}');
          },
        )
        .toList()
        .toString();

    print('_recipientsEmail is: $_recipientsEmail');
    print('emailBody is: $emailBody');

    final Email email = Email(
      body: emailBody,
      subject: 'Event data',
      recipients: [_recipientsEmail!],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  saveEvents1() async {
    final Future<File> filePath =
        File('vikas/events.json').create(recursive: true); //load the json file

    final file = await filePath;

    await readPlayerData(file); //read data from json file

    EventData event = EventData();

    events.add(event);

    print(events.length);

    events //convert list data  to json
        .map(
          (player) => player.toJson(),
        )
        .toList();

    file.writeAsStringSync(json.encode(events)); //w
  }

  Future<void> readPlayerData(File file) async {
    String contents = await file.readAsString();
    var jsonResponse = jsonDecode(contents);

    for (var p in jsonResponse) {
      EventData player = EventData();
      events.add(player);
    }
  }
}
