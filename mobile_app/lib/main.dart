import 'package:flutter/material.dart';
import 'screens/LoginPage.dart';

// Main method
void main() => runApp(MaterialApp(
    // désactivation de la bannière "développement"
    debugShowCheckedModeBanner: false,
    home: LoginPage()));
