class TripModel {
  final Description description;
  final Route route;
  final Vehicle vehicle;

  TripModel({
    required this.description,
    required this.route,
    required this.vehicle,
  });

  TripModel copyWith({
    Description? description,
    Route? route,
    Vehicle? vehicle,
  }) =>
      TripModel(
        description: description ?? this.description,
        route: route ?? this.route,
        vehicle: vehicle ?? this.vehicle,
      );

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        description: json["description"] == null
            ? throw FormatException()
            : Description.fromJson(json["description"]),
        route: json["route"] == null
            ? throw FormatException()
            : Route(
                routeNodes: List<RouteNode>.from(
                    json["route"]!.map((x) => RouteNode.fromJson(x)).toList()),
              ),
        vehicle: json["vehicle"] == null
            ? throw FormatException()
            : Vehicle.fromJson(json["vehicle"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description.toJson(),
        "route": List<dynamic>.from(route.routeNodes.map((x) => x.toJson())),
        "vehicle": vehicle.toJson(),
      };
}

class Description {
  final String? routeNumber;

  Description({
    this.routeNumber,
  });

  Description copyWith({
    String? routeNumber,
  }) =>
      Description(
        routeNumber: routeNumber ?? this.routeNumber,
      );

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        routeNumber: json["route_number"],
      );

  Map<String, dynamic> toJson() => {
        "route_number": routeNumber,
      };
}

class Route {
  Route({required this.routeNodes});

  final List<RouteNode> routeNodes;
}

class RouteNode {
  final num id;
  final bool allowBoarding;
  final bool allowDropOff;
  final num bookingCutOffMins;
  final bool preBookedOnly;
  final bool skipped;
  final NodeSchedule arrival;
  final NodeSchedule departure;
  final Location location;

  RouteNode({
    required this.id,
    required this.allowBoarding,
    required this.allowDropOff,
    required this.bookingCutOffMins,
    required this.preBookedOnly,
    required this.skipped,
    required this.arrival,
    required this.departure,
    required this.location,
  });

  RouteNode copyWith({
    num? id,
    bool? allowBoarding,
    bool? allowDropOff,
    String? bookable,
    num? bookingCutOffMins,
    bool? preBookedOnly,
    bool? skipped,
    NodeSchedule? arrival,
    NodeSchedule? departure,
    Location? location,
  }) =>
      RouteNode(
        id: id ?? this.id,
        allowBoarding: allowBoarding ?? this.allowBoarding,
        allowDropOff: allowDropOff ?? this.allowDropOff,
        bookingCutOffMins: bookingCutOffMins ?? this.bookingCutOffMins,
        preBookedOnly: preBookedOnly ?? this.preBookedOnly,
        skipped: skipped ?? this.skipped,
        arrival: arrival ?? this.arrival,
        departure: departure ?? this.departure,
        location: location ?? this.location,
      );

  factory RouteNode.fromJson(Map<String, dynamic> json) => RouteNode(
        id: json["id"],
        allowBoarding: json["allow_boarding"],
        allowDropOff: json["allow_drop_off"],
        bookingCutOffMins: json["booking_cut_off_mins"],
        preBookedOnly: json["pre_booked_only"],
        skipped: json["skipped"],
        arrival: json["arrival"] == null
            ? throw FormatException()
            : NodeSchedule.fromJson(json["arrival"]),
        departure: json["departure"] == null
            ? throw FormatException()
            : NodeSchedule.fromJson(json["departure"]),
        location: json["location"] == null
            ? throw FormatException()
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "allow_boarding": allowBoarding,
        "allow_drop_off": allowDropOff,
        "booking_cut_off_mins": bookingCutOffMins,
        "pre_booked_only": preBookedOnly,
        "skipped": skipped,
        "arrival": arrival.toJson(),
        "departure": departure.toJson(),
        "location": location.toJson(),
      };
}

class NodeSchedule {
  final DateTime? actual;
  final DateTime? estimated;
  final DateTime scheduled;

  NodeSchedule({
    this.actual,
    this.estimated,
    required this.scheduled,
  });

  NodeSchedule copyWith({
    DateTime? actual,
    DateTime? estimated,
    DateTime? scheduled,
  }) =>
      NodeSchedule(
        actual: actual ?? this.actual,
        estimated: estimated ?? this.estimated,
        scheduled: scheduled ?? this.scheduled,
      );

  factory NodeSchedule.fromJson(Map<String, dynamic> json) => NodeSchedule(
        actual: json["actual"] == null ? null : DateTime.parse(json["actual"]),
        estimated: json["estimated"] == null
            ? null
            : DateTime.parse(json["estimated"]),
        scheduled: json["scheduled"] == null
            ? throw FormatException()
            : DateTime.parse(json["scheduled"]),
      );

  Map<String, dynamic> toJson() => {
        "actual": actual?.toIso8601String(),
        "estimated": estimated?.toIso8601String(),
        "scheduled": scheduled.toIso8601String(),
      };
}

class Location {
  final String? atcoCode;
  final DateTime? bookableFrom;
  final DateTime? bookableUntil;
  final String? description;
  final String detailedName;
  final String? direction;
  final String? googlePlaceId;
  final num id;
  final num? lat;
  final num? lon;
  final String name;
  final String regionName;
  final String? timezone;
  final String type;

  Location({
    this.atcoCode,
    this.bookableFrom,
    this.bookableUntil,
    this.description,
    required this.detailedName,
    this.direction,
    this.googlePlaceId,
    required this.id,
    this.lat,
    this.lon,
    required this.name,
    required this.regionName,
    this.timezone,
    required this.type,
  });

  Location copyWith({
    String? atcoCode,
    DateTime? bookableFrom,
    DateTime? bookableUntil,
    String? description,
    String? detailedName,
    String? direction,
    String? googlePlaceId,
    num? id,
    num? lat,
    num? lon,
    String? name,
    String? regionName,
    String? timezone,
    String? type,
  }) =>
      Location(
        atcoCode: atcoCode ?? this.atcoCode,
        bookableFrom: bookableFrom ?? this.bookableFrom,
        bookableUntil: bookableUntil ?? this.bookableUntil,
        description: description ?? this.description,
        detailedName: detailedName ?? this.detailedName,
        direction: direction ?? this.direction,
        googlePlaceId: googlePlaceId ?? this.googlePlaceId,
        id: id ?? this.id,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        name: name ?? this.name,
        regionName: regionName ?? this.regionName,
        timezone: timezone ?? this.timezone,
        type: type ?? this.type,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        atcoCode: json["atco_code"],
        bookableFrom: json["bookable_from"] == null
            ? null
            : DateTime.parse(json["bookable_from"]),
        bookableUntil: json["bookable_until"] == null
            ? null
            : DateTime.parse(json["bookable_until"]),
        description: json["description"],
        detailedName: json["detailed_name"],
        direction: json["direction"],
        googlePlaceId: json["google_place_id"],
        id: json["id"],
        lat: json["lat"],
        lon: json["lon"],
        name: json["name"],
        regionName: json["region_name"],
        timezone: json["timezone"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "atco_code": atcoCode,
        "bookable_from": bookableFrom?.toIso8601String(),
        "bookable_until": bookableUntil?.toIso8601String(),
        "description": description,
        "detailed_name": detailedName,
        "direction": direction,
        "google_place_id": googlePlaceId,
        "id": id,
        "lat": lat,
        "lon": lon,
        "name": name,
        "region_name": regionName,
        "timezone": timezone,
        "type": type,
      };
}

class Vehicle {
  final num? id;
  final num? ownerId;
  final String? name;
  final String? brand;
  final String? colour;
  final String? plateNumber;
  final bool? isBackupVehicle;
  final bool? hasToilet;
  final bool? hasWifi;
  final num? bicycle;
  final num? wheelchair;
  final num? seat;
  final Gps? gps;
  final SecondaryGps? secondaryGps;

  Vehicle({
    this.id,
    this.ownerId,
    this.name,
    this.brand,
    this.colour,
    this.plateNumber,
    this.isBackupVehicle,
    this.hasToilet,
    this.hasWifi,
    this.bicycle,
    this.wheelchair,
    this.seat,
    this.gps,
    this.secondaryGps,
  });

  Vehicle copyWith({
    num? id,
    num? ownerId,
    String? name,
    String? brand,
    String? colour,
    String? plateNumber,
    bool? isBackupVehicle,
    bool? hasToilet,
    bool? hasWifi,
    num? bicycle,
    num? wheelchair,
    num? seat,
    Gps? gps,
    SecondaryGps? secondaryGps,
  }) =>
      Vehicle(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        name: name ?? this.name,
        brand: brand ?? this.brand,
        colour: colour ?? this.colour,
        plateNumber: plateNumber ?? this.plateNumber,
        isBackupVehicle: isBackupVehicle ?? this.isBackupVehicle,
        hasToilet: hasToilet ?? this.hasToilet,
        hasWifi: hasWifi ?? this.hasWifi,
        bicycle: bicycle ?? this.bicycle,
        wheelchair: wheelchair ?? this.wheelchair,
        seat: seat ?? this.seat,
        gps: gps ?? this.gps,
        secondaryGps: secondaryGps ?? this.secondaryGps,
      );

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        ownerId: json["owner_id"],
        name: json["name"],
        brand: json["brand"],
        colour: json["colour"],
        plateNumber: json["plate_number"],
        isBackupVehicle: json["is_backup_vehicle"],
        hasToilet: json["has_toilet"],
        hasWifi: json["has_wifi"],
        bicycle: json["bicycle"],
        wheelchair: json["wheelchair"],
        seat: json["seat"],
        gps: json["gps"] == null ? null : Gps.fromJson(json["gps"]),
        secondaryGps: json["secondary_gps"] == null
            ? null
            : SecondaryGps.fromJson(json["secondary_gps"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "name": name,
        "brand": brand,
        "colour": colour,
        "plate_number": plateNumber,
        "is_backup_vehicle": isBackupVehicle,
        "has_toilet": hasToilet,
        "has_wifi": hasWifi,
        "bicycle": bicycle,
        "wheelchair": wheelchair,
        "seat": seat,
        "gps": gps?.toJson(),
        "secondary_gps": secondaryGps?.toJson(),
      };
}

class Gps {
  final Acceleration? acceleration;
  final num? elevation;
  final num? heading;
  final String? lastUpdated;
  final num? latitude;
  final num? longitude;
  final num? speed;

  Gps({
    this.acceleration,
    this.elevation,
    this.heading,
    this.lastUpdated,
    this.latitude,
    this.longitude,
    this.speed,
  });

  Gps copyWith({
    Acceleration? acceleration,
    num? elevation,
    num? heading,
    String? lastUpdated,
    num? latitude,
    num? longitude,
    num? speed,
  }) =>
      Gps(
        acceleration: acceleration ?? this.acceleration,
        elevation: elevation ?? this.elevation,
        heading: heading ?? this.heading,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        speed: speed ?? this.speed,
      );

  factory Gps.fromJson(Map<String, dynamic> json) => Gps(
        acceleration: json["acceleration"] == null
            ? null
            : Acceleration.fromJson(json["acceleration"]),
        elevation: json["elevation"],
        heading: json["heading"],
        lastUpdated: json["last_updated"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        speed: json["speed"],
      );

  Map<String, dynamic> toJson() => {
        "acceleration": acceleration?.toJson(),
        "elevation": elevation,
        "heading": heading,
        "last_updated": lastUpdated,
        "latitude": latitude,
        "longitude": longitude,
        "speed": speed,
      };
}

class Acceleration {
  final String? x;
  final String? y;
  final String? z;

  Acceleration({
    this.x,
    this.y,
    this.z,
  });

  Acceleration copyWith({
    String? x,
    String? y,
    String? z,
  }) =>
      Acceleration(
        x: x ?? this.x,
        y: y ?? this.y,
        z: z ?? this.z,
      );

  factory Acceleration.fromJson(Map<String, dynamic> json) => Acceleration(
        x: json["x"],
        y: json["y"],
        z: json["z"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "z": z,
      };
}

class SecondaryGps {
  final num? heading;
  final String? lastUpdated;
  final num? latitude;
  final num? longitude;

  SecondaryGps({
    this.heading,
    this.lastUpdated,
    this.latitude,
    this.longitude,
  });

  SecondaryGps copyWith({
    num? heading,
    String? lastUpdated,
    num? latitude,
    num? longitude,
  }) =>
      SecondaryGps(
        heading: heading ?? this.heading,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory SecondaryGps.fromJson(Map<String, dynamic> json) => SecondaryGps(
        heading: json["heading"],
        lastUpdated: json["last_updated"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "last_updated": lastUpdated,
        "latitude": latitude,
        "longitude": longitude,
      };
}
