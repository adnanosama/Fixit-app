import 'package:flutter/material.dart';
import '../screens/create_account_page.dart';
import '../screens/custom_component_search_page.dart';
import '../screens/login_page.dart';
import '../screens/my_bookings_page.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  final AnimationController animController;
  final VoidCallback onClose;

  const AppDrawer({
    super.key,
    required this.animController,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userEmail = AuthService.currentUserEmail ?? "consumer@fixitpro.com";

    return Container(
      width: MediaQuery.of(context).size.width * 0.78,
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D44) : const Color(0xFFF1F4F9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    onClose();
                  },
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.25).animate(animController),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black26 : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.menu),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                const Text("FixIt Menu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 38,
            backgroundColor: Colors.indigo,
            child: Text("F", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          const Text("FixIt User", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(userEmail, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.indigo.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Consumer Portal",
              style: TextStyle(color: Colors.indigo, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(indent: 20, endIndent: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  Icons.search,
                  "Custom Device Search",
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomComponentSearchPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  Icons.calendar_month,
                  "My Bookings",
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyBookingsPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  Icons.login,
                  "Login Account",
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  Icons.person_add,
                  "Create Account",
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
                    );
                  },
                ),
                const Divider(indent: 20, endIndent: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.w500)),
                      Switch(
                        value: ThemeController.isDarkMode,
                        onChanged: (val) => ThemeController.setThemeMode(val ? ThemeMode.dark : ThemeMode.light),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      onTap: onTap,
    );
  }
}
