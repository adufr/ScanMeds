import 'package:flutter/material.dart';
import 'screens/HomePage.dart';

// Main method
void main() => runApp(MaterialApp(
    // désactivation de la bannière "développement"
    debugShowCheckedModeBanner: false,
    home: HomePage()));
