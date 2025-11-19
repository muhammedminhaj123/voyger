import 'package:flutter/material.dart';
import 'package:medicalapp/bookingpage.dart';
import 'package:medicalapp/travelerdetailspage.dart';

class packegedetailsscreen extends StatelessWidget {
  final Map<String, String> package;
  final String title, image, price, days, category;

  const packegedetailsscreen({
    super.key,
    required this.package,
    required this.title,
    required this.image,
    required this.price,
    required this.days,
    required this.category,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text(title),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.share, color: Colors.blueAccent),
          onPressed: () {},
        ),
      ],
    ),
    body: ListView(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
          child: Image.network(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 4),
                  Text(
                    "4.8 (212 reviews)",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                category,
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 17, color: Colors.blue),
                  SizedBox(width: 6),
                  Text(days, style: TextStyle(fontSize: 15)),
                ],
              ),
              Divider(height: 24),
              Text(
                "Explore the vibrant culture, ancient temples, and cityscapes of Japan's capital.",
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
              SizedBox(height: 22),
              Text(
                "What's Included",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 7,
                children: [
                  _includedChip(Icons.flight, "Flights"),
                  _includedChip(Icons.hotel, "6 Nights"),
                  _includedChip(Icons.directions_bus, "All Transfers"),
                  _includedChip(Icons.breakfast_dining, "Breakfast"),
                  _includedChip(Icons.person, "Expert Guide"),
                  _includedChip(Icons.confirmation_num, "Entrance Fees"),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Starting from",
                    style: TextStyle(color: Colors.grey[700], fontSize: 15),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingDatesPage(package: package),
                      ),
                    );
                  },
                  child: Text(
                    "Book Now",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _includedChip(IconData icon, String label) => Chip(
    avatar: Icon(icon, color: Colors.blueAccent, size: 18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
    backgroundColor: Colors.blue[50],
    label: Text(
      label,
      style: TextStyle(color: Colors.blueAccent, fontSize: 14),
    ),
  );
}
