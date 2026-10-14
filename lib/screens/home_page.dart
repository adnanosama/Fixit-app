import 'package:flutter/material.dart';
import '../data_models/service.dart';
import '../widgets/app_drawer.dart';
import '../widgets/chat_support_sheet.dart';
import '../widgets/service_card.dart';
import 'custom_component_search_page.dart';
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
    Service("Screen Replace", Icons.phone_iphone, "", Colors.blue),
    Service("Battery Fix", Icons.battery_charging_full, "", Colors.green),
    Service("Water Damage", Icons.water_drop, "", Colors.cyan),
    Service("Camera Repair", Icons.camera_alt, "", Colors.purple),
    Service("Speaker Fix", Icons.speaker, "", Colors.orange),
    Service("Software Update", Icons.system_update, "", Colors.teal),
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
      drawer: AppDrawer(
        animController: _animController,
        onClose: () => _animController.reverse(),
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
                          "FixIt Consumer",
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
                                const SizedBox(height: 55),
                                const Text("Pakistan Retailer Network,", style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          child: const Icon(Icons.menu),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  // Custom Component Search Top Action Icon
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CustomComponentSearchPage()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withValues(alpha: 0.3),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyBookingsPage()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
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
                        color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                        blurRadius: 15,
                        offset: const Offset(0, -5),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Custom Search Banner Prompt
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CustomComponentSearchPage()),
                          ),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.indigo, Color(0xFF3F51B5)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                            ),
                            child: const Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white24,
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Search Custom Device Parts",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      Text(
                                        "Type model name to compare local shop prices",
                                        style: TextStyle(color: Colors.white70, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          "General Repair Services",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 16),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: services.length,
                          itemBuilder: (context, index) => ServiceCard(service: services[index]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Floating Action Buttons (Custom Device Search + Support Chat)
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  backgroundColor: Colors.indigo,
                  heroTag: 'searchBtn',
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Custom Part", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomComponentSearchPage()),
                  ),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
