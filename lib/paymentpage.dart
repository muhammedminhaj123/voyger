import 'package:flutter/material.dart';
import 'package:medicalapp/mybookings.dart';

class PaymentPage extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final String days;
  final String category;
  final String travelerName;

  const PaymentPage({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    required this.days,
    required this.category,
    required this.travelerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("Credit Card"),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("UPI / Wallet"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                bookedItems.add({
                  "title": title,
                  "image": image,
                  "price": price,
                  "days": days,
                  "category": category,
                  "traveler": travelerName,
                });

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Payment Successful"),
                    content: const Text("Your trip has been booked!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        },
                        child: const Text("Done"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Confirm Payment"),
            ),
          ],
        ),
      ),
    );
  }
}
