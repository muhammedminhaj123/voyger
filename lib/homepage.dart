import 'package:flutter/material.dart';
import 'package:medicalapp/packegedetails.dart';
import 'package:medicalapp/wishlistpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required void Function() onWishlistChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> allPackages = [
    {
      "image": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
      "title": "Bali Beach Paradise",
      "price": "\$899",
      "days": "5 Days, 4 Nights",
      "category": "Beach",
      "reviews": "4.8 (212 reviews)",
    },
    {
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
      "title": "Swiss Alps Adventure",
      "price": "\$1299",
      "days": "7 Days, 6 Nights",
      "category": "Mountain",
      "reviews": "4.9 (405 reviews)",
    },
    {
      "image": "https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1",
      "title": "Maldives Escape",
      "price": "\$999",
      "days": "4 Days, 3 Nights",
      "category": "Luxury",
      "reviews": "5.0 (180 reviews)",
    },
    {
      "image": "https://images.unsplash.com/photo-1524492449092-0c3e84ef3e1c",
      "title": "Dubai Desert Safari",
      "price": "\$750",
      "days": "3 Days, 2 Nights",
      "category": "Adventure",
      "reviews": "4.6 (97 reviews)",
    },
  ];

  String selectedCategory = "All";
  List<Map<String, String>> wishlist = [];

  List<Map<String, String>> get filteredPackages {
    if (selectedCategory == "All") return allPackages;
    return allPackages
        .where((pkg) => pkg["category"] == selectedCategory)
        .toList();
  }

  void toggleWishlist(Map<String, String> package) {
    setState(() {
      final exists = wishlist.any((item) => item["title"] == package["title"]);
      if (exists) {
        wishlist.removeWhere((item) => item["title"] == package["title"]);
      } else {
        wishlist.add(package);
      }
    });
  }

  bool isInWishlist(String title) {
    return wishlist.any((item) => item["title"] == title);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ["All", "Beach", "Adventure", "Mountain", "Luxury"];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Explore"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.favorite, color: Colors.redAccent),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (_) => WishlistPage(wishlist: wishlist),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search destinations, tours...",
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            // Category chips (as tabBar filter)
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = cat == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 2),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: Colors.blueAccent.withOpacity(0.15),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.blueAccent : Colors.black,
                      ),
                      onSelected: (_) => setState(() => selectedCategory = cat),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.blueAccent
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: filteredPackages.length,
                itemBuilder: (context, index) {
                  final pkg = filteredPackages[index];
                  final wish = isInWishlist(pkg["title"]!);

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => packegedetailsscreen(
                              image: pkg["image"]!,
                              title: pkg["title"]!,
                              price: pkg["price"]!,
                              days: pkg["days"]!,
                              category: pkg["category"]!,
                              package: {},
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.network(
                                  pkg["image"]!,
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 13,
                                top: 13,
                                child: GestureDetector(
                                  onTap: () => toggleWishlist(pkg),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(
                                      wish
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: wish ? Colors.red : Colors.grey,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      pkg["reviews"] ?? "",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  pkg["days"]!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  pkg["price"]!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  pkg["category"]!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[500],
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
