import 'package:flutter/material.dart';

List<Map<String, String>> bookedItems = [];

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: bookedItems.isEmpty
          ? const Center(child: Text("No bookings yet"))
          : ListView.builder(
              itemCount: bookedItems.length,
              itemBuilder: (context, index) {
                final booking = bookedItems[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(booking["image"]!, width: 60),
                    title: Text(booking["title"]!),
                    subtitle: Text(
                      "${booking["price"]!} | ${booking["days"]!}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
