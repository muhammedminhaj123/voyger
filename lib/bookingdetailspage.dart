import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  final Map<String, String> package;
  final Map<String, String> traveler;
  final Map<String, String> payment;
  final DateTimeRange dateRange;
  final int adults;
  final int children;
  final double estimatedPrice;
  final List<String> travelers;

  ReviewPage({
    required this.package,
    required this.traveler,
    required this.payment,
    required this.dateRange,
    required this.adults,
    required this.children,
    required this.estimatedPrice,
    required this.travelers,
  });

  String get formattedDate =>
      "${_formatDate(dateRange.start)} - ${_formatDate(dateRange.end)}";

  static String _formatDate(DateTime d) =>
      "${_monthShort(d.month)} ${d.day}, ${d.year}";

  static String _monthShort(int m) => [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ][m - 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Your Booking"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xfff7f9fb),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Package Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                  child: package["image"] == null || package["image"]!.isEmpty
                      ? Container(
                          height: 140,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.grey,
                          ),
                        )
                      : Image.network(
                          package["image"]!,
                          width: double.infinity,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package["title"] ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        package["days"] ?? "",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 7),
                      Text(
                        package["description"] ??
                            "An unforgettable journey through the heart of Paris.",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13),

          _infoRow(Icons.calendar_today, formattedDate, onEdit: () {}),
          _infoRow(
            Icons.people,
            "${adults + children} Travelers",
            onEdit: () {},
          ),
          _infoRow(
            Icons.hotel,
            package["hotel"] ?? "Select Hotel",
            onEdit: () {},
          ),
          SizedBox(height: 13),
          Text(
            "Travelers",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: travelers
                  .asMap()
                  .entries
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Text(
                        "${e.key + 1}. ${e.value}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 12),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            initiallyExpanded: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            title: Text(
              "Price Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(11),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _priceRow("Trip Base", "₹${package['price'] ?? ''}"),
                    _priceRow(
                      "Extra guest(s)",
                      children > 0
                          ? "+₹${(estimatedPrice - double.parse(package['price'] ?? "0")).toStringAsFixed(2)}"
                          : "Included",
                    ),
                    Divider(),
                    _priceRow(
                      "Total",
                      "₹${estimatedPrice.toStringAsFixed(2)}",
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "By proceeding, you agree to our "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Terms & Conditions",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: " and "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Cancellation Policy",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: "."),
                ],
              ),
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Total Price",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Spacer(),
              Text(
                "₹${estimatedPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                "Confirm & Proceed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Booking Confirmed!')));
                Navigator.popUntil(context, (r) => r.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {required VoidCallback onEdit}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue, size: 27),
          title: Text(
            text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          trailing: TextButton(
            onPressed: onEdit,
            child: Text(
              "Edit",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 15 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 15 : 14,
              color: isTotal ? Colors.blueAccent : null,
            ),
          ),
        ],
      ),
    );
  }
}
