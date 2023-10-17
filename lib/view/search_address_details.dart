// To parse this JSON data, do
//
//     final searchAddressDetails = searchAddressDetailsFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

SearchAddressDetails searchAddressDetailsFromJson(String str) =>
    SearchAddressDetails.fromJson(json.decode(str));

String searchAddressDetailsToJson(SearchAddressDetails data) =>
    json.encode(data.toJson());

class SearchAddressDetails {
  SearchAddressDetails({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;

  factory SearchAddressDetails.fromJson(Map<String, dynamic> json) =>
      SearchAddressDetails(
        htmlAttributions: json["html_attributions"] == null
            ? null
            : List<dynamic>.from(json["html_attributions"].map((x) => x)),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions == null
            ? null
            : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "result": result == null ? null : result!.toJson(),
        "status": status == null ? null : status,
      };
}

class Result {
  Result({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.reference,
    this.types,
    this.url,
    this.utcOffset,
    this.vicinity,
  });

  List<AddressComponent>? addressComponents;
  String? adrAddress;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photo>? photos;
  String? placeId;
  String? reference;
  List<String>? types;
  String? url;
  int? utcOffset;
  String? vicinity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: json["address_components"] == null
            ? null
            : List<AddressComponent>.from(json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        adrAddress: json["adr_address"] == null ? null : json["adr_address"],
        formattedAddress: json["formatted_address"] == null
            ? null
            : json["formatted_address"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        icon: json["icon"] == null ? null : json["icon"],
        iconBackgroundColor: json["icon_background_color"] == null
            ? null
            : json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"] == null
            ? null
            : json["icon_mask_base_uri"],
        name: json["name"] == null ? null : json["name"],
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"] == null ? null : json["place_id"],
        reference: json["reference"] == null ? null : json["reference"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
        url: json["url"] == null ? null : json["url"],
        utcOffset: json["utc_offset"] == null ? null : json["utc_offset"],
        vicinity: json["vicinity"] == null ? null : json["vicinity"],
      );

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? null
            : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "adr_address": adrAddress == null ? null : adrAddress,
        "formatted_address": formattedAddress == null ? null : formattedAddress,
        "geometry": geometry == null ? null : geometry!.toJson(),
        "icon": icon == null ? null : icon,
        "icon_background_color":
            iconBackgroundColor == null ? null : iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri == null ? null : iconMaskBaseUri,
        "name": name == null ? null : name,
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "place_id": placeId == null ? null : placeId,
        "reference": reference == null ? null : reference,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
        "url": url == null ? null : url,
        "utc_offset": utcOffset == null ? null : utcOffset,
        "vicinity": vicinity == null ? null : vicinity,
      };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"] == null ? null : json["long_name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName == null ? null : longName,
        "short_name": shortName == null ? null : shortName,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        viewport: json["viewport"] == null
            ? null
            : Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location!.toJson(),
        "viewport": viewport == null ? null : viewport!.toJson(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: json["northeast"] == null
            ? null
            : Location.fromJson(json["northeast"]),
        southwest: json["southwest"] == null
            ? null
            : Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast == null ? null : northeast!.toJson(),
        "southwest": southwest == null ? null : southwest!.toJson(),
      };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"] == null ? null : json["height"],
        htmlAttributions: json["html_attributions"] == null
            ? null
            : List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference:
            json["photo_reference"] == null ? null : json["photo_reference"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "html_attributions": htmlAttributions == null
            ? null
            : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "photo_reference": photoReference == null ? null : photoReference,
        "width": width == null ? null : width,
      };
}
