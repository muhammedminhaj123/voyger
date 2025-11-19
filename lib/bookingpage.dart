import 'package:flutter/material.dart';
import 'package:medicalapp/travelerdetailspage.dart';

class BookingDatesPage extends StatefulWidget {
  final Map<String, String> package;
  BookingDatesPage({required this.package});

  @override
  State<BookingDatesPage> createState() => _BookingDatesPageState();
}

class _BookingDatesPageState extends State<BookingDatesPage> {
  DateTime _selectedStart = DateTime.now().add(Duration(days: 3));
  DateTime _selectedEnd = DateTime.now().add(Duration(days: 8));
  int _adults = 2;
  int _children = 1;

  // Calculate the base price per adult from package string (e.g. "$1450" -> 1450.0), default 1450
  double get basePrice {
    final priceString = widget.package['price'] ?? '1450';
    // Remove any non-numeric (keep decimal)
    return double.tryParse(priceString.replaceAll(RegExp(r'[^d.]'), '')) ??
        1450;
  }

  double get totalPrice =>
      (_adults * basePrice) +
      (_children * basePrice * 0.6); // children = 60% price

  @override
  Widget build(BuildContext context) {
    final imgUrl = widget.package['image'] ?? '';
    final title = widget.package['title'] ?? '';
    final category = widget.package['category'] ?? '';
    final days = widget.package['days'] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text("Book Your Trip")),
      body: ListView(
        padding: EdgeInsets.all(18),
        children: [
          // Progress indicator
          Row(
            children: [
              Text(
                "Step 1",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(" of 3", style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(value: 1 / 3),
          SizedBox(height: 14),

          // Package Card with image and details
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imgUrl.isEmpty
                      ? SizedBox(width: 70, height: 55) // blank space
                      : Image.network(
                          imgUrl,
                          width: 70,
                          height: 55,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              SizedBox(width: 70, height: 55),
                        ),
                ),
                SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (category.isNotEmpty)
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500],
                          ),
                        ),
                      if (days.isNotEmpty)
                        Text(
                          days,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 22),

          // Select dates
          Text(
            "Select Travel Dates",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 9),
          InkWell(
            onTap: () async {
              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                initialDateRange: DateTimeRange(
                  start: _selectedStart,
                  end: _selectedEnd,
                ),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
              if (picked != null) {
                setState(() {
                  _selectedStart = picked.start;
                  _selectedEnd = picked.end;
                });
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 11),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_selectedStart.day}/${_selectedStart.month}/${_selectedStart.year} - "
                    "${_selectedEnd.day}/${_selectedEnd.month}/${_selectedEnd.year}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.calendar_today, color: Colors.blueAccent),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          // Travelers
          Text(
            "Number of Travelers",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Adults", style: TextStyle(fontWeight: FontWeight.w500)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (_adults > 1) setState(() => _adults--);
                    },
                  ),
                  Text(_adults.toString(), style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () => setState(() => _adults++),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Children", style: TextStyle(fontWeight: FontWeight.w500)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (_children > 0) setState(() => _children--);
                    },
                  ),
                  Text(_children.toString(), style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () => setState(() => _children++),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),

          // Dynamic estimated price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Estimated Price",
                style: TextStyle(color: Colors.grey[700]),
              ),
              Text(
                "₹${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TravelerDetailsPage(
                      package: widget.package,
                      dateRange: DateTimeRange(
                        start: _selectedStart,
                        end: _selectedEnd,
                      ),
                      adults: _adults,
                      children: _children,
                      estimatedPrice: totalPrice,
                    ),
                  ),
                );
              },
              child: Text(
                "Continue",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
