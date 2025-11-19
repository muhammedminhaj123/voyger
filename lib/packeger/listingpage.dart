import 'package:flutter/material.dart';

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.shade300,
              child: const Text("N", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 10),
            const Text(
              "Good morning, Nomad",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP CARDS ───────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _buildStatCard("Total Revenue", "\$12,850", "+5.2%"),
                ),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard("Bookings", "32", "+10.1%")),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatCard("Listing Views", "4.2k", "-1.5%", isSmall: true),
            const SizedBox(height: 20),

            /// ACTION BUTTONS
            Row(
              children: [
                _actionButton(Icons.add, "Add Listing"),
                const SizedBox(width: 12),
                _actionButton(Icons.calendar_month, "Calendar"),
                const SizedBox(width: 12),
                _actionButton(Icons.support_agent, "Support"),
              ],
            ),

            const SizedBox(height: 25),

            /// MY LISTINGS ─────────────────────────────────────────────
            _sectionHeader("My Listings"),
            const SizedBox(height: 10),

            _listingCard(
              status: "Published",
              title: "Mountain Escape in the Alps",
              price: "\$1,200 / night",
              image:
                  "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
              button: "Manage",
            ),

            _listingCard(
              status: "Draft",
              title: "Sunny Beachfront Villa",
              price: "\$2,500 / night",
              image:
                  "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
              button: "Continue",
            ),

            const SizedBox(height: 20),

            /// RECENT BOOKINGS ─────────────────────────────────────────
            _sectionHeader("Recent Bookings"),
            const SizedBox(height: 10),

            _bookingTile(
              name: "Sarah L.",
              subtitle: "Booked Mountain Escape",
              date: "Nov 15",
              nights: "3 nights",
            ),
            _bookingTile(
              name: "Mike T.",
              subtitle: "Booked Sunny Villa",
              date: "Nov 12",
              nights: "7 nights",
            ),
            _bookingTile(
              name: "Emily C.",
              subtitle: "Booked Mountain Escape",
              date: "Nov 10",
              nights: "5 nights",
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String change, {
    bool isSmall = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: isSmall ? const EdgeInsets.only(right: 0) : null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              color: change.contains("+") ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text("View All", style: TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget _listingCard({
    required String status,
    required String title,
    required String price,
    required String image,
    required String button,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(price, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(button),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_right_alt),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookingTile({
    required String name,
    required String subtitle,
    required String date,
    required String nights,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 22, backgroundColor: Colors.blueAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(nights, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
