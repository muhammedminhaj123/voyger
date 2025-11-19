import 'package:flutter/material.dart';
import 'package:medicalapp/bookingdetailspage.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, String> package;
  final DateTimeRange dateRange;
  final int adults, children;
  final double estimatedPrice;
  final Map<String, dynamic> travelerDetails;
  final List<String> travelers;

  PaymentPage({
    required this.package,
    required this.dateRange,
    required this.adults,
    required this.children,
    required this.estimatedPrice,
    required this.travelerDetails,
    required this.travelers,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedMethod = 1;
  bool billingSameAsHome = true;
  final cardController = TextEditingController();
  final nameController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Methods")),
      body: ListView(
        padding: EdgeInsets.all(18),
        children: [
          Text(
            "Your Payment Methods",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => setState(() => selectedMethod = 1),
            child: Card(
              color: selectedMethod == 1 ? Colors.blue[50] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.credit_card,
                  color: selectedMethod == 1 ? Colors.blue : Colors.black54,
                ),
                title: Text("Mastercard  ** 5678"),
                trailing: selectedMethod == 1
                    ? Icon(Icons.check_circle, color: Colors.blue)
                    : null,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => selectedMethod = 2),
            child: Card(
              color: selectedMethod == 2 ? Colors.blue[50] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: selectedMethod == 2 ? Colors.blue : Colors.black54,
                ),
                title: Row(
                  children: [
                    Text("Apple Pay"),
                    SizedBox(width: 7),
                    if (selectedMethod == 2)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Default",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                  ],
                ),
                trailing: selectedMethod == 2
                    ? Icon(Icons.check_circle, color: Colors.blue)
                    : null,
              ),
            ),
          ),
          SizedBox(height: 18),
          _addNewMethodSection(),
          SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                final paymentData = {
                  "cardNumber": cardController.text,
                  "cardName": nameController.text,
                  "expiry": expiryController.text,
                  "cvv": cvvController.text,
                  "billingSame": billingSameAsHome.toString(),
                  "method": selectedMethod == 1 ? "Mastercard" : "Apple Pay",
                };
                final travelerStringMap = widget.travelerDetails.map(
                  (key, value) => MapEntry(key, value.toString()),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewPage(
                      package: widget.package,
                      traveler: travelerStringMap,
                      payment: paymentData,
                      dateRange: widget.dateRange,
                      adults: widget.adults,
                      children: widget.children,
                      estimatedPrice: widget.estimatedPrice,
                      travelers: widget.travelers,
                    ),
                  ),
                );
              },
              child: Text(
                "Save Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addNewMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Icon(Icons.add, color: Colors.blueAccent, size: 32),
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Add a New Way to Pay",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        TextField(
          controller: cardController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Card Number",
            prefixIcon: Icon(Icons.credit_card),
          ),
        ),
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: "Cardholder Name"),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: expiryController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: "Expiry Date"),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: cvvController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "CVV"),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Switch(
              value: billingSameAsHome,
              onChanged: (val) => setState(() => billingSameAsHome = val),
            ),
            Text("Billing address is same as home address"),
          ],
        ),
        SizedBox(height: 7),
        Row(
          children: [
            Icon(Icons.lock, size: 18, color: Colors.grey[600]),
            SizedBox(width: 5),
            Text(
              "Your payment information is stored securely.",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}
