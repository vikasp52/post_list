// import 'package:benshi/repository/model/model.dart';
// import 'package:benshi/screens/posts/cubit/post_cubit.dart';
// import 'package:benshi/screens/settings/cubit/settings_cubit.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_events/model/event.dart';

enum EventActions { open, paginated }

class Events {
  static final Events _singleton = Events._internal();

  factory Events() {
    return _singleton;
  }

  Events._internal();

  List<EventData> events = [];

  // void addEvents({required PostData post}) {
  //   final meta = Meta(
  //     timestamp: DateTime.now().microsecondsSinceEpoch.toString(),
  //     location: Location(
  //       lat: post.user.address?.geo.lat,
  //       long: post.user.address?.geo.lng,
  //     ),
  //   );

  //   final event = EventData(
  //     appId: post.user.email,
  //     action: EventActions.open.name,
  //     resourceId: post.post.id,
  //     userId: post.user.id,
  //     meta: meta,
  //   );
  //   events.add(event);
  // }

  // void sendEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? _recipientsEmail = prefs.getString(SettingsCubit.emailId);

  //   String emailBody = events
  //       .map(
  //         (event) {
  //           return event.toJson();
  //         },
  //       )
  //       .toList()
  //       .toString();

  //   final Email email = Email(
  //     body: emailBody,
  //     subject: 'Event data',
  //     recipients: [_recipientsEmail!],
  //     isHTML: false,
  //   );

  //   await FlutterEmailSender.send(email);
  // }
}
