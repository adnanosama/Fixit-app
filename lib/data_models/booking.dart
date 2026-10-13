import 'package:flutter/material.dart';
import 'service.dart';

class Booking {
  final Service service;
  final DateTime date;
  final TimeOfDay time;
  final String deviceName;
  Booking({required this.service, required this.date, required this.time, required this.deviceName});
}

// Global Booking List (In-memory storage)
List<Booking> myBookings = [];
