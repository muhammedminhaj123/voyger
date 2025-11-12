import 'package:flutter/material.dart';
import 'package:medicalapp/bottamnavigationpage.dart';
import 'package:medicalapp/packagedetailspage.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onWishlistChanged;
  const HomePage({super.key, this.onWishlistChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Demo travel package data
  final List<Map<String, String>> allPackages = [
    {
      "image": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
      "title": "Bali Beach Paradise",
      "price": "\$899",
      "days": "5 Days, 4 Nights",
      "category": "Beach",
    },
    {
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
      "title": "Swiss Alps Adventure",
      "price": "\$1299",
      "days": "7 Days, 6 Nights",
      "category": "Mountain",
    },
    {
      "image": "https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1",
      "title": "Maldives Escape",
      "price": "\$999",
      "days": "4 Days, 3 Nights",
      "category": "Luxury",
    },
    {
      "image": "https://images.unsplash.com/photo-1524492449092-0c3e84ef3e1c",
      "title": "Dubai Desert Safari",
      "price": "\$750",
      "days": "3 Days, 2 Nights",
      "category": "Adventure",
    },
  ];

  // Add/remove wishlist
  void toggleWishlist(Map<String, String> package) {
    setState(() {
      final exists = wishlist.any((item) => item["title"] == package["title"]);
      if (exists) {
        wishlist.removeWhere((item) => item["title"] == package["title"]);
      } else {
        wishlist.add(package);
      }
    });
    widget.onWishlistChanged?.call();
  }

  bool isInWishlist(String title) {
    return wishlist.any((item) => item["title"] == title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Explore Packages",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search destinations...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🏝️ Package List
            Expanded(
              child: GridView.builder(
                itemCount: allPackages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final pkg = allPackages[index];
                  final wish = isInWishlist(pkg["title"]!);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PackageDetailPage(
                            image: pkg["image"]!,
                            title: pkg["title"]!,
                            price: pkg["price"]!,
                            days: pkg["days"]!,
                            category: pkg["category"]!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image + wishlist button
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.network(
                                  pkg["image"]!,
                                  height: 130,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: GestureDetector(
                                  onTap: () => toggleWishlist(pkg),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 16,
                                    child: Icon(
                                      wish
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: wish ? Colors.red : Colors.grey,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pkg["title"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  pkg["category"]!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  pkg["days"]!,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  pkg["price"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PackageDetailPage(
                                            image: pkg["image"]!,
                                            title: pkg["title"]!,
                                            price: pkg["price"]!,
                                            days: pkg["days"]!,
                                            category: pkg["category"]!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("View Details"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
