import 'package:flutter/material.dart';
import '../data_models/booking.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});
  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Appointments")),
      body: myBookings.isEmpty
          ? const Center(child: Text("No bookings yet.", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: myBookings.length,
        itemBuilder: (context, index) {
          final booking = myBookings[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                myBookings.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Booking removed")));
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: CircleAvatar(backgroundColor: booking.service.color.withOpacity(0.1), child: Icon(booking.service.icon, color: booking.service.color)),
                title: Text(booking.service.name),
                subtitle: Text("${booking.deviceName} • ${booking.time.format(context)}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
