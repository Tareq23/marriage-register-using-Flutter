// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
    required this.slug,
    required this.contactId,
    required this.address,
    required this.about,
    required this.website,
    required this.registrationNumber,
    required this.mapLink,
    required this.districtId,
    required this.subdistrictId,
    required this.divisionId,
    required this.updatedBy,
    required this.createdBy,
    required this.image,
  });

  int id;
  String name;
  String email;
  String phone;
  int type;
  String slug;
  int contactId;
  String address;
  String about;
  String website;
  String registrationNumber;
  String mapLink;
  int districtId;
  int subdistrictId;
  int divisionId;
  String updatedBy;
  String createdBy;

  String image;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    type: json["type"],
    slug: json["slug"],
    contactId: json["contact_id"],
    address: json["address"],
    about: json["about"],
    website: json["website"],
    registrationNumber: json["registration_number"],
    mapLink: json["map_link"],
    districtId: json["district_id"],
    subdistrictId: json["subdistrict_id"],
    divisionId: json["division_id"],
    updatedBy: json["updated_by"],
    createdBy: json["created_by"],

    image: json["image"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "type": type,
    "slug": slug,
    "contact_id": contactId,
    "address": address,
    "about": about,
    "website": website,
    "registration_number": registrationNumber,
    "map_link": mapLink,
    "district_id": districtId,
    "subdistrict_id": subdistrictId,
    "division_id": divisionId,
    "updated_by": updatedBy,
    "created_by": createdBy,
    "image": image,
  };
}