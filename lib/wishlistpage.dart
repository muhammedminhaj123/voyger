import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  final List<Map<String, String>> wishlist;
  const WishlistPage({super.key, required this.wishlist});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<Map<String, String>> wishlist;

  @override
  void initState() {
    super.initState();
    wishlist = List.from(widget.wishlist);
  }

  void removeFromWishlist(Map<String, String> pkg) {
    setState(() {
      wishlist.removeWhere((item) => item["title"] == pkg["title"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Wishlist"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.5,
      ),
      body: wishlist.isEmpty
          ? Center(
              child: Text(
                "Your wishlist is empty.Click the heart on packages to add them!",

                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final pkg = wishlist[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 3,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        pkg['image'] ?? '',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      pkg['title'] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      pkg['days'] ?? '',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.redAccent),
                      onPressed: () => removeFromWishlist(pkg),
                      tooltip: 'Remove from wishlist',
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
    );
  }
}
