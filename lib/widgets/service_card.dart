import 'package:flutter/material.dart';
import '../data_models/service.dart';
import '../screens/booking_page.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  const ServiceCard({super.key, required this.service});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Neon effect colors
    final borderColor = isDark ? service.color : service.color.withOpacity(0.5);
    final glowColor = service.color.withOpacity(isDark ? 0.3 : 0.1);

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPage(service: service))),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            // Shadow for depth
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
            // Neon Glow
            BoxShadow(color: glowColor, blurRadius: 12, spreadRadius: 1),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: service.name, 
              child: Container(
                padding: const EdgeInsets.all(16), 
                decoration: BoxDecoration(
                  color: service.color.withOpacity(0.1), 
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: service.color.withOpacity(0.2), blurRadius: 8)]
                ), 
                child: Icon(service.icon, size: 40, color: service.color)
              )
            ),
            const SizedBox(height: 15),
            Text(service.name, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
            const SizedBox(height: 5),
            Text(service.price, style: TextStyle(color: isDark ? Colors.white70 : Colors.grey[600], fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
