import 'package:flutter/material.dart';
import 'package:medicalapp/bottamnavigationpage.dart';
import 'package:medicalapp/packegedetails.dart';

class PackageDetailPage extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final String days;
  final String category;
  final String description;

  const PackageDetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.days,
    required this.category,
    this.description =
        "Experience a beautiful trip filled with fun, culture, and relaxation!",
  });

  @override
  State<PackageDetailPage> createState() => _PackageDetailPageState();
}

class _PackageDetailPageState extends State<PackageDetailPage> {
  bool isWishlisted = false;

  @override
  void initState() {
    super.initState();
    isWishlisted = wishlist.any((item) => item["title"] == widget.title);
  }

  void toggleWishlist() {
    setState(() {
      if (isWishlisted) {
        wishlist.removeWhere((item) => item["title"] == widget.title);
      } else {
        wishlist.add({
          "image": widget.image,
          "title": widget.title,
          "price": widget.price,
          "days": widget.days,
          "category": widget.category,
        });
      }
      isWishlisted = !isWishlisted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.network(
                    widget.image,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                      color: Colors.redAccent,
                    ),
                    onPressed: toggleWishlist,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.11),
                    blurRadius: 7,
                    spreadRadius: 3,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Category
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Text(
                        "4.8",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "(212 reviews)",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.category,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  Divider(height: 24, thickness: 1),
                  // Days and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 17,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 7),
                          Text(widget.days, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // About Section
                  Text(
                    "About This Package",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Inclusions Section
                  Text(
                    "What's Included",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: [
                      _buildIncludedItem(Icons.flight, "Flights"),
                      _buildIncludedItem(Icons.hotel, "6 Nights Accommodation"),
                      _buildIncludedItem(Icons.directions_bus, "All Transfers"),
                      _buildIncludedItem(
                        Icons.breakfast_dining,
                        "Daily Breakfast",
                      ),
                      _buildIncludedItem(Icons.person, "Expert Guide"),
                      _buildIncludedItem(
                        Icons.confirmation_num,
                        "Entrance Fees",
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Book Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => packegedetailsscreen(
                              title: widget.title,
                              image: widget.image,
                              price: widget.price,
                              days: widget.days,
                              category: widget.category,
                              package: {
                                "title": widget.title,
                                "image": widget.image,
                                "price": widget.price,
                                "days": widget.days,
                                "category": widget.category,
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[600],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "Book Now",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncludedItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blueAccent, size: 20),
        SizedBox(width: 4),
        Text(text, style: TextStyle(color: Colors.black87, fontSize: 15)),
      ],
    );
  }
}
