import 'package:flutter/material.dart';
import 'paymentpage.dart';

class TravelerDetailsPage extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final String days;
  final String category;

  const TravelerDetailsPage({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    required this.days,
    required this.category,
    required DateTime date,
    required int travelers,
    required String packageName,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Traveler Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentPage(
                      title: title,
                      image: image,
                      price: price,
                      days: days,
                      category: category,
                      travelerName: nameController.text,
                    ),
                  ),
                );
              },
              child: const Text("Proceed to Payment"),
            ),
          ],
        ),
      ),
    );
  }
}
