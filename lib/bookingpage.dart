import 'package:flutter/material.dart';
import 'travelerdetailspage.dart';

class BookingDetailsPage extends StatefulWidget {
  final Map<String, String> package;

  const BookingDetailsPage({
    super.key,
    required this.package,
    required String title,
    required String image,
    required String price,
    required String days,
    required String category,
  });

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  bool addGuide = false;

  @override
  Widget build(BuildContext context) {
    final pkg = widget.package;

    return Scaffold(
      appBar: AppBar(
        title: Text(pkg['title']!),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image banner
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.network(
                pkg['image']!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pkg['title']!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pkg['category'] ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(width: 6),
                      Text(pkg['days']!, style: const TextStyle(fontSize: 16)),
                      const Spacer(),
                      Text(
                        pkg['price']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "What’s included",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "• Flights & Transfers\n• 4-Star Accommodation\n• Daily Breakfast\n• Guided City Tour\n• Free Cancellation",
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),

                  const SizedBox(height: 24),

                  SwitchListTile(
                    title: const Text("Add Tour Guide"),
                    subtitle: const Text(
                      "Optional: a local expert for your trip",
                    ),
                    value: addGuide,
                    onChanged: (value) {
                      setState(() {
                        addGuide = value;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TravelerDetailsPage(
                              packageName: pkg['title']!,
                              price: pkg['price']!,
                              title: pkg['title']!,
                              image: pkg['image']!,
                              days: pkg['days']!,
                              travelers: 1,
                              date: DateTime.now(),
                              category: '',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Book Now",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
