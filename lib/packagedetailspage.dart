import 'package:flutter/material.dart';
import 'package:medicalapp/bottamnavigationpage.dart';
import 'bookingpage.dart';

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
      body: CustomScrollView(
        slivers: [
          // Top image with AppBar overlay
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(widget.image, fit: BoxFit.cover),
                  Container(color: Colors.black.withOpacity(0.3)),
                ],
              ),
              title: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: Colors.redAccent,
                ),
                onPressed: toggleWishlist,
              ),
            ],
          ),

          // Package details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.category,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.days,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "About This Package",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingDetailsPage(
                              title: widget.title,
                              image: widget.image,
                              price: widget.price,
                              days: widget.days,
                              category: widget.category,
                              package: {},
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
