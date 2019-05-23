import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:mobile_app/models/bar.model.dart';
import 'package:mobile_app/screens/home/bar.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:advanced_share/advanced_share.dart' show AdvancedShare;

class BarsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://cdn.discordapp.com/attachments/364699138144600065/576417244821716993/unknown.png'),
          fit: BoxFit.cover
        ) ,
      ),
    );
  }
}