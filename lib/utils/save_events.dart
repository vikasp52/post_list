import 'dart:convert';
import 'dart:io';

import 'package:benshi/repository/model/model.dart';

enum EventActions { open, paginated }

class Events {
  static final Events _singleton = Events._internal();

  factory Events() {
    return _singleton;
  }

  Events._internal();

  List<EventData> events = [];

  void addEvents({required EventData eventData}) {
    print('addEvents called');
    print('addEvents is: $eventData');
    events.add(eventData);

    print('addEvents length: ${events.length}');

    events //convert list data  to json
        .map(
      (event) {
        event.toJson();
        print('addEvents length: ${event.toJson()}');
      },
    ).toList();
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
