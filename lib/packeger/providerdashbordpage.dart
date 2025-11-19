import 'package:flutter/material.dart';
import 'package:medicalapp/listingpage.dart';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookings = [
    {
      "name": "Sarah Lane",
      "price": 1200,
      "time": "Today",
      "trip": "Bali Wellness Retreat",
      "image": "https://randomuser.me/api/portraits/women/44.jpg",
    },
    {
      "name": "Michael Chen",
      "price": 2500,
      "time": "Yesterday",
      "trip": "Andean Adventure Trek",
      "image": "https://randomuser.me/api/portraits/men/32.jpg",
    },
    {
      "name": "Emily Rodriguez",
      "price": 1200,
      "time": "3 days ago",
      "trip": "Bali Wellness Retreat",
      "image": "https://randomuser.me/api/portraits/women/68.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/11.jpg",
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Welcome, Alex!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Stack(
                  children: const [
                    Icon(Icons.notifications, size: 28),
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Stats Row
            Row(
              children: [
                statCard("Monthly Revenue", "\$12,500", "+5.2%"),
                const SizedBox(width: 12),
                statCard("New Bookings", "15", "+8.0%"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                statCard("Listing Views", "2.1k", "+12.1%"),
                const SizedBox(width: 12),
                statCard("Unread Messages", "3", "vs last week"),
              ],
            ),

            const SizedBox(height: 25),

            // Buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: const Text(
                "Add New Listing",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ListingPage()),
                );
              },
              child: const Text("View All Bookings"),
            ),

            const SizedBox(height: 22),

            const Text(
              "My Listings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                expandedListing(
                  "Bali Wellness Retreat",
                  "Active · 25 Bookings",
                  "https://images.unsplash.com/photo-1587502536900-c0f1a6f1b9a8",
                ),
                const SizedBox(width: 12),
                expandedListing(
                  "Andean Adventure",
                  "Active · 12 Bookings",
                  "https://images.unsplash.com/photo-1469474968028-56623f02e42e",
                ),
              ],
            ),

            const SizedBox(height: 22),

            const Text(
              "Recent Bookings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...bookings.map((b) => bookingTile(b)).toList(),
          ],
        ),
      ),
    );
  }

  Widget statCard(String title, String value, String change) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(change, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }

  Widget expandedListing(String title, String subtitle, String image) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                image,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingTile(Map data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(data["image"]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Booked: ${data["trip"]}",
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${data["price"]}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data["time"], style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}
