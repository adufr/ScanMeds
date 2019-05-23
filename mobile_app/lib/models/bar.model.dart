import 'package:flutter/material.dart';
import 'dart:convert';

Bars barsFromJson(String str) {
    final jsonData = json.decode(str);
    return Bars.fromJson(jsonData);
}

String barsToJson(Bars data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class Bars {
    List<Bar> bars;

    Bars({
        this.bars,
    });

    factory Bars.fromJson(Map<String, dynamic> json) => new Bars(
        bars: new List<Bar>.from(json["bars"].map((x) => Bar.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "bars": new List<dynamic>.from(bars.map((x) => x.toJson())),
    };
}

class Bar {
    String logo;
    int temperature;
    String id;
    String name;
    String description;
    String addressCity;
    String addressCountry;
    String addressZipcode;
    String addressStreet;
    String addressStreetNumber;
    int v;
    String likeValue;

    Bar({
        this.logo,
        this.temperature,
        this.id,
        this.name,
        this.description,
        this.addressCity,
        this.addressCountry,
        this.addressZipcode,
        this.addressStreet,
        this.addressStreetNumber,
        this.v,
        this.likeValue,
    });

    factory Bar.fromJson(Map<String, dynamic> json) => new Bar(
        logo: json["logo"],
        temperature: json["temperature"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        addressCity: json["address_city"],
        addressCountry: json["address_country"],
        addressZipcode: json["address_zipcode"],
        addressStreet: json["address_street"],
        addressStreetNumber: json["address_street_number"],
        v: json["__v"],
        likeValue: json["likeValue"]
    );

    Map<String, dynamic> toJson() => {
        "logo": logo,
        "temperature": temperature,
        "_id": id,
        "name": name,
        "description": description,
        "address_city": addressCity,
        "address_country": addressCountry,
        "address_zipcode": addressZipcode,
        "address_street": addressStreet,
        "address_street_number": addressStreetNumber,
        "__v": v,
        "likeValue": likeValue,
    };
}
