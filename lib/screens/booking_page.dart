import 'package:flutter/material.dart';
import '../data_models/service.dart';
import '../data_models/booking.dart';

class BookingPage extends StatefulWidget {
  final Service service;
  const BookingPage({super.key, required this.service});
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _deviceController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isBooked = false;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2030));
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
      myBookings.add(Booking(
          service: widget.service, date: _selectedDate!, time: _selectedTime!, deviceName: _deviceController.text));
      setState(() => _isBooked = true);
    } else if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Date & Time required"), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(elevation: 0, leading: const BackButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: _isBooked
            ? Center(child: Column(children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 80),
          const SizedBox(height: 20),
          Text("Confirmed!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Back Home"))
        ]))
            : Form(
          key: _formKey,
          child: Column(
            children: [
              Hero(tag: widget.service.name, child: Icon(widget.service.icon, size: 80, color: widget.service.color)),
              const SizedBox(height: 20),
              Text("Book ${widget.service.name}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 30),
              TextFormField(
                controller: _deviceController,
                decoration: InputDecoration(hintText: "Device Model", filled: true, fillColor: isDark ? Colors.black26 : Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(child: OutlinedButton(onPressed: _pickDate, child: Text(_selectedDate == null ? "Pick Date" : "${_selectedDate!.day}/${_selectedDate!.month}"))),
                const SizedBox(width: 10),
                Expanded(child: OutlinedButton(onPressed: _pickTime, child: Text(_selectedTime == null ? "Pick Time" : _selectedTime!.format(context)))),
              ]),
              const SizedBox(height: 40),
              SizedBox(width: double.infinity, height: 50, child: ElevatedButton(
                  onPressed: _confirmBooking,
                  style: ElevatedButton.styleFrom(backgroundColor: widget.service.color),
                  child: const Text("Confirm", style: TextStyle(color: Colors.white))))
            ],
          ),
        ),
      ),
    );
  }
}
