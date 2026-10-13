import 'package:flutter/material.dart';
import '../app_config/theme.dart';
import '../data_models/service.dart';
import '../widgets/service_card.dart';
import '../widgets/chat_support_sheet.dart';
import 'create_account_page.dart';
import 'my_bookings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animController;

  final List<Service> services = [
    Service("Screen Replace", Icons.phone_iphone, "\$80", Colors.blue),
    Service("Battery Fix", Icons.battery_charging_full, "\$45", Colors.green),
    Service("Water Damage", Icons.water_drop, "\$100", Colors.cyan),
    Service("Camera Repair", Icons.camera_alt, "\$60", Colors.purple),
    Service("Speaker Fix", Icons.speaker, "\$35", Colors.orange),
    Service("Software Update", Icons.system_update, "\$25", Colors.teal),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
  }

  void _toggleDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.closeDrawer();
      _animController.reverse();
    } else {
      _scaffoldKey.currentState!.openDrawer();
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Builder(
          builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.75,
              margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2D2D44) : const Color(0xFFF1F4F9),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 20)],
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
                            _animController.reverse();
                          },
                          child: RotationTransition(
                            turns: Tween(begin: 0.0, end: 0.25).animate(_animController),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black26 : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.menu),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text("Menu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const CircleAvatar(radius: 40, backgroundColor: Colors.indigo, child: Text("A", style: TextStyle(fontSize: 30, color: Colors.white))),
                  const SizedBox(height: 10),
                  const Text("Adnan Developer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text("adnan@fixitpro.com", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 30),
                  _buildDrawerItem(Icons.person, "My Account", () {}),
                  _buildDrawerItem(Icons.person_add, "Create Account", () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountPage()));
                  }),
                  _buildDrawerItem(Icons.settings, "Settings", () {}),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.w500)),
                        Switch(
                          value: themeNotifier.value == ThemeMode.dark,
                          onChanged: (val) => themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
      onDrawerChanged: (isOpen) {
        if (isOpen) {
          _animController.forward();
        } else {
          _animController.reverse();
        }
      },
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  titlePadding: const EdgeInsets.only(left: 0, bottom: 16),
                  centerTitle: true,
                  title: LayoutBuilder(
                    builder: (context, constraints) {
                      final top = constraints.biggest.height;
                      final opacity = (top - kToolbarHeight) / (200 - kToolbarHeight);
                      return Opacity(
                        opacity: (1 - opacity).clamp(0.0, 1.0),
                        child: Text(
                          "FixIt",
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                  background: LayoutBuilder(
                    builder: (context, constraints) {
                      final top = constraints.biggest.height;
                      final opacity = (top - kToolbarHeight) / (200 - kToolbarHeight);
                      return Opacity(
                        opacity: opacity.clamp(0.0, 1.0),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 60),
                                const Text("Welcome Back,", style: TextStyle(fontSize: 16, color: Colors.grey)),
                                Text(
                                  "FixIt Support",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leadingWidth: 70,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: _toggleDrawer,
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.25).animate(_animController),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          child: const Icon(Icons.menu),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBookingsPage())),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                        child: const Icon(Icons.calendar_month, color: Colors.indigo),
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                        blurRadius: 15,
                        offset: const Offset(0, -5),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 100),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.85),
                      itemCount: services.length,
                      itemBuilder: (context, index) => ServiceCard(service: services[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              heroTag: 'chatBtn',
              child: const Icon(Icons.chat_bubble, color: Colors.white),
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (c) => const ChatSupportSheet(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }
}
