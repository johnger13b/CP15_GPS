import 'package:f_gps/ui/app.dart';
import 'package:f_gps/ui/controllers/gps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GpsController());
  runApp(const GpsApp());
}
