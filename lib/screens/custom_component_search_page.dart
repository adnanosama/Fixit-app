import 'package:flutter/material.dart';
import '../data_models/device_model.dart';
import '../services/device_api_service.dart';

class CustomComponentSearchPage extends StatefulWidget {
  const CustomComponentSearchPage({super.key});

  @override
  State<CustomComponentSearchPage> createState() => _CustomComponentSearchPageState();
}

class _CustomComponentSearchPageState extends State<CustomComponentSearchPage> {
  // Mobile Device Autocomplete State
  final TextEditingController _deviceQueryController = TextEditingController();
  List<MobileDevice> _matchingDevices = [];
  MobileDevice? _selectedDevice;
  bool _isLoadingDevices = false;

  // Mobile Device Part Autocomplete State
  final TextEditingController _partQueryController = TextEditingController();
  final List<RepairPart> _allPartsCatalog = DeviceApiService.getAvailableParts();
  List<RepairPart> _matchingParts = [];
  RepairPart? _selectedPart;

  List<RetailerListing> _retailerOffers = [];

  @override
  void initState() {
    super.initState();
    _fetchDevices('');
    _filterParts('');
  }

  Future<void> _fetchDevices(String query) async {
    setState(() => _isLoadingDevices = true);
    final results = await DeviceApiService.fetchLiveDevices(query);
    if (mounted) {
      setState(() {
        _matchingDevices = results;
        _isLoadingDevices = false;
      });
    }
  }

  void _filterParts(String query) {
    final cleanQuery = query.trim().toLowerCase();
    setState(() {
      if (cleanQuery.isEmpty) {
        _matchingParts = List.from(_allPartsCatalog);
      } else {
        _matchingParts = _allPartsCatalog.where((part) {
          return part.partName.toLowerCase().contains(cleanQuery) ||
                 part.category.toLowerCase().contains(cleanQuery);
        }).toList();
      }
    });
  }

  void _onDeviceSelected(MobileDevice device) {
    setState(() {
      _selectedDevice = device;
      _deviceQueryController.text = device.modelName;
      _matchingDevices.clear(); // Close device suggestions list
      _updateRetailerOffers();
    });
  }

  void _onPartSelected(RepairPart part) {
    setState(() {
      _selectedPart = part;
      _partQueryController.text = part.partName;
      _matchingParts.clear(); // Close part suggestions list
      _updateRetailerOffers();
    });
  }

  void _updateRetailerOffers() {
    if (_selectedDevice != null && _selectedPart != null) {
      setState(() {
        _retailerOffers = DeviceApiService.getRetailerListingsForPart(
          _selectedDevice!.modelName,
          _selectedPart!.partName,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Custom Component", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STEP 1: Search & Autocomplete Mobile Device
            Text(
              "1. Search Mobile Phone Model",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.cyanAccent : Colors.indigo,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _deviceQueryController,
              onChanged: (val) {
                if (_selectedDevice != null && val != _selectedDevice!.modelName) {
                  setState(() => _selectedDevice = null);
                }
                _fetchDevices(val);
              },
              decoration: InputDecoration(
                hintText: "e.g., Samsung S24, iPhone 15, Redmi Note 13",
                prefixIcon: const Icon(Icons.phone_iphone),
                suffixIcon: _isLoadingDevices
                    ? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2))
                    : (_deviceQueryController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _deviceQueryController.clear();
                              setState(() {
                                _selectedDevice = null;
                                _retailerOffers.clear();
                              });
                              _fetchDevices('');
                            },
                          )
                        : null),
                filled: true,
                fillColor: isDark ? const Color(0xFF1E1E2E) : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),

            // Device Autocomplete Suggestions List
            if (_selectedDevice == null && _matchingDevices.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                constraints: const BoxConstraints(maxHeight: 220),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF26263A) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _matchingDevices.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final device = _matchingDevices[index];
                    return ListTile(
                      leading: Image.network(
                        device.imageUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Icon(Icons.smartphone, size: 30),
                      ),
                      title: Text(device.modelName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Text(device.brand, style: const TextStyle(fontSize: 12)),
                      onTap: () => _onDeviceSelected(device),
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            // SELECTED DEVICE HEADER CARD WITH IMAGE
            if (_selectedDevice != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF1E1E38), const Color(0xFF2D2D54)]
                        : [Colors.indigo.shade50, Colors.blue.shade50],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _selectedDevice!.imageUrl,
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Icon(Icons.smartphone, size: 50, color: Colors.indigo),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(_selectedDevice!.brand, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _selectedDevice!.modelName,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Selected Mobile Device",
                            style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // STEP 2: Search & Autocomplete Mobile Component / Part
            Text(
              "2. Search Mobile Phone Component / Part",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.cyanAccent : Colors.indigo,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _partQueryController,
              onChanged: (val) {
                if (_selectedPart != null && val != _selectedPart!.partName) {
                  setState(() => _selectedPart = null);
                }
                _filterParts(val);
              },
              decoration: InputDecoration(
                hintText: "e.g., OLED Display, Battery, Camera Module, Charging Port",
                prefixIcon: const Icon(Icons.build),
                suffixIcon: _partQueryController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _partQueryController.clear();
                          setState(() {
                            _selectedPart = null;
                            _retailerOffers.clear();
                          });
                          _filterParts('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark ? const Color(0xFF1E1E2E) : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),

            // Part Autocomplete Suggestions List
            if (_selectedPart == null && _matchingParts.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                constraints: const BoxConstraints(maxHeight: 220),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF26263A) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _matchingParts.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final part = _matchingParts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.withValues(alpha: 0.1),
                        child: Icon(part.icon, color: Colors.indigo, size: 20),
                      ),
                      title: Text(part.partName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Text(part.category, style: const TextStyle(fontSize: 12)),
                      onTap: () => _onPartSelected(part),
                    );
                  },
                ),
              ),

            const SizedBox(height: 30),

            // STEP 3: Available Local Retailers & Prices (Pakistan Network)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Local Retailers",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.indigo,
                  ),
                ),
                if (_retailerOffers.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                    child: Text("${_retailerOffers.length} Shops Found", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            if (_selectedDevice == null || _selectedPart == null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E2E) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.manage_search, size: 48, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      "Search and select both phone model and component above to compare local shop prices & exact shop locations.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _retailerOffers.length,
                itemBuilder: (context, index) {
                  final shop = _retailerOffers[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
                      border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.indigo,
                              radius: 20,
                              child: Icon(Icons.store, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shop.shopName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_city, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(shop.city, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.star, size: 14, color: Colors.amber),
                                      Text(" ${shop.rating}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Rs. ${shop.pricePkr.toStringAsFixed(0)}",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (shop.inStock ? Colors.green : Colors.orange).withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    shop.inStock ? "In Stock" : "1-Day Order",
                                    style: TextStyle(
                                      color: shop.inStock ? Colors.green : Colors.orange,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        // Retailer Exact Shop Location Notes
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.pin_drop, size: 18, color: Colors.redAccent),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Shop Address & Location Note:\n${shop.locationNotes}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? Colors.white70 : Colors.black87,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Contacting ${shop.shopName} at ${shop.contactPhone}"),
                                  backgroundColor: Colors.indigo,
                                ),
                              );
                            },
                            icon: const Icon(Icons.phone, size: 18, color: Colors.white),
                            label: const Text("Contact Retailer Shop", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
