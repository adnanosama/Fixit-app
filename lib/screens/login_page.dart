import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSignUp = false;
  bool _isLoading = false;

  Future<void> _submitAuth() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final String? error = _isSignUp
        ? await AuthService.signUp(email, password)
        : await AuthService.signIn(email, password);

    if (mounted) {
      setState(() => _isLoading = false);

      if (error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isSignUp ? "Account Created Successfully!" : "Welcome back to FixIt!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.security, size: 60, color: Colors.indigo),
              ),
              const SizedBox(height: 20),
              Text(
                _isSignUp ? "Create Consumer Account" : "Welcome Back to FixIt",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isSignUp
                    ? "Connect with local repair shops and prices"
                    : "Sign in to access your bookings & local retailer deals",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: "Email Address",
                  filled: true,
                  fillColor: isDark ? const Color(0xFF1E1E2E) : Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
                validator: (v) => v != null && v.contains("@") ? null : "Enter a valid email",
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: "Password",
                  filled: true,
                  fillColor: isDark ? const Color(0xFF1E1E2E) : Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
                validator: (v) => v != null && v.length >= 6 ? null : "Password must be at least 6 characters",
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitAuth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          _isSignUp ? "Sign Up" : "Sign In",
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () => setState(() => _isSignUp = !_isSignUp),
                child: Text(
                  _isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up",
                  style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
