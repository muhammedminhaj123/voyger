import 'package:flutter/material.dart';
import 'package:medicalapp/packagedetailspage.dart';
import 'homepage.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, String>> wishlist;
  const WishlistPage({super.key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wishlist")),
      body: wishlist.isEmpty
          ? const Center(
              child: Text(
                "No items in wishlist",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final package = wishlist[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        package["image"]!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      package["title"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      package["price"]!,
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                    trailing: ElevatedButton(
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
                              image: package["image"]!,
                              title: package["title"]!,
                              price: package["price"]!,
                              days: package["days"]!,
                              category: package["category"]!,
                            ),
                          ),
                        );
                      },
                      child: const Text("Book Now"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
