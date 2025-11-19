import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String selectedFilter = "All";

  final List<Map<String, dynamic>> bookings = [
    {
      "name": "Eleanor Vance",
      "image": "https://randomuser.me/api/portraits/women/21.jpg",
      "location": "Andaman Islands Adventure",
      "date": "Oct 25 - Nov 2, 2024",
      "status": "Pending",
    },
    {
      "name": "Marcus Holloway",
      "image": "https://randomuser.me/api/portraits/men/41.jpg",
      "location": "Bali Spiritual Retreat",
      "date": "Nov 15 - Nov 22, 2024",
      "status": "Confirmed",
    },
    {
      "name": "Sofia Chen",
      "image": "https://randomuser.me/api/portraits/women/52.jpg",
      "location": "Himalayan Trek Expedition",
      "date": "Dec 1 - Dec 14, 2024",
      "status": "Cancelled",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6fa),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, size: 28),
                  Text(
                    "Bookings",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(Icons.search, size: 28),
                ],
              ),

              const SizedBox(height: 16),

              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by name, package, or ID",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // FILTER CHIPS
              Row(
                children: [
                  filterChip("All"),
                  filterChip("Pending"),
                  filterChip("Confirmed"),
                  filterChip("Cancelled"),
                ],
              ),

              const SizedBox(height: 20),

              // BOOKING LIST
              Column(
                children: bookings
                    .where(
                      (b) =>
                          selectedFilter == "All" ||
                          b["status"] == selectedFilter,
                    )
                    .map((b) => bookingCard(b))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FILTER CHIP WIDGET
  Widget filterChip(String label) {
    final isSelected = label == selectedFilter;

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        selected: isSelected,
        selectedColor: Colors.blue,
        backgroundColor: Colors.white,
        onSelected: (v) {
          setState(() {
            selectedFilter = label;
          });
        },
      ),
    );
  }

  // BOOKING CARD UI
  Widget bookingCard(Map data) {
    Color badgeColor;

    switch (data["status"]) {
      case "Pending":
        badgeColor = Colors.amber.shade400;
        break;
      case "Confirmed":
        badgeColor = Colors.green.shade400;
        break;
      case "Cancelled":
        badgeColor = Colors.red.shade300;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(data["image"]),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["name"],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      data["location"],
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(data["date"], style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),

              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data["status"],
                  style: TextStyle(
                    color: badgeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // BUTTONS
          if (data["status"] == "Pending")
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    child: Text("Confirm"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    child: Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.chat_bubble_outline),
                ),
              ],
            ),

          if (data["status"] != "Pending")
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "View Details",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.chat_bubble_outline),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.more_vert),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
