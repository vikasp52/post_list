class EventData {
  String? appId;
  String? action;
  int? resourceId;
  int? userId;
  Meta? meta;

  EventData({this.appId, this.action, this.resourceId, this.userId, this.meta});

  EventData.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    action = json['action'];
    resourceId = json['resourceId'];
    userId = json['userId'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appId'] = appId;
    data['action'] = action;
    data['resourceId'] = resourceId;
    data['userId'] = userId;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Meta {
  String? timestamp;
  Location? location;

  Meta({this.timestamp, this.location});

  Meta.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  String? lat;
  String? long;

  Location({this.lat, this.long});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
