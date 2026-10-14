import 'package:flutter/material.dart';

/// Data model representing a real mobile phone device.
class MobileDevice {
  final String id;
  final String brand;
  final String modelName;
  final String imageUrl;
  final String? releaseYear;

  MobileDevice({
    required this.id,
    required this.brand,
    required this.modelName,
    required this.imageUrl,
    this.releaseYear,
  });

  factory MobileDevice.fromJson(Map<String, dynamic> json) {
    return MobileDevice(
      id: json['id']?.toString() ?? UniqueKey().toString(),
      brand: json['brand'] ?? 'Generic',
      modelName: json['modelName'] ?? json['title'] ?? 'Mobile Phone',
      imageUrl: json['imageUrl'] ?? json['thumbnail'] ?? 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',
      releaseYear: json['releaseYear']?.toString(),
    );
  }
}

/// Data model representing a mobile phone replacement component/part.
class RepairPart {
  final String id;
  final String partName;
  final String category;
  final IconData icon;

  RepairPart({
    required this.id,
    required this.partName,
    required this.category,
    required this.icon,
  });
}

/// Data model representing a local shop retailer offering parts/repair services.
class RetailerListing {
  final String id;
  final String shopName;
  final String city;
  final String locationNotes; // Detailed address inserted by retailer
  final double pricePkr;
  final bool inStock;
  final String contactPhone;
  final double rating;

  RetailerListing({
    required this.id,
    required this.shopName,
    required this.city,
    required this.locationNotes,
    required this.pricePkr,
    required this.inStock,
    required this.contactPhone,
    this.rating = 4.8,
  });
}
