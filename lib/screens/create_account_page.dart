import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});
  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      if(mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account Created Successfully!")));
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account"), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.indigo),
              const SizedBox(height: 20),
              Text("Join FixIt Pro", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(prefixIcon: const Icon(Icons.person), hintText: "Full Name", filled: true, fillColor: isDark ? Colors.black26 : Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(prefixIcon: const Icon(Icons.email), hintText: "Email Address", filled: true, fillColor: isDark ? Colors.black26 : Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (v) => v!.contains("@") ? null : "Invalid Email",
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(prefixIcon: const Icon(Icons.lock), hintText: "Password", filled: true, fillColor: isDark ? Colors.black26 : Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (v) => v!.length < 6 ? "Min 6 chars" : null,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
