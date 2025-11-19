import 'package:flutter/material.dart';
import 'package:medicalapp/paymentpage.dart';
// import your PaymentPage and/or ReviewPage as needed

class TravelerDetailsPage extends StatefulWidget {
  final Map<String, String> package;
  final DateTimeRange dateRange;
  final int adults, children;
  final double estimatedPrice;

  const TravelerDetailsPage({
    Key? key,
    required this.package,
    required this.dateRange,
    required this.adults,
    required this.children,
    required this.estimatedPrice,
  }) : super(key: key);

  @override
  State<TravelerDetailsPage> createState() => _TravelerDetailsPageState();
}

class _TravelerDetailsPageState extends State<TravelerDetailsPage> {
  final nameCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  bool addInsurance = false;
  bool newsletter = false;

  @override
  Widget build(BuildContext context) {
    final imgUrl = widget.package['image'] ?? '';
    final title = widget.package['title'] ?? '';
    final category = widget.package['category'] ?? '';
    final days = widget.package['days'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text("Traveler Details"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF7F9FB),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // Package summary card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 18),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imgUrl.isEmpty
                      ? Container(
                          width: 70,
                          height: 55,
                          color: Colors.grey[200],
                          child: Icon(Icons.image, color: Colors.grey),
                        )
                      : Image.network(
                          imgUrl,
                          width: 70,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
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
                      Text(
                        "Travel: ${_formatDate(widget.dateRange.start)} - ${_formatDate(widget.dateRange.end)}",
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      Text(
                        "Travelers: ${widget.adults + widget.children} • ₹${widget.estimatedPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Traveler form
          Text(
            "Lead Traveler",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 9),
          _formField(
            "Full Name (as on passport)",
            nameCtrl,
            TextInputType.text,
            Icons.person_outline,
          ),
          const SizedBox(height: 10),
          _formField(
            "Date of Birth (DD/MM/YYYY)",
            dobCtrl,
            TextInputType.datetime,
            Icons.cake,
            datePicker: true,
          ),
          const SizedBox(height: 10),
          _formField(
            "Email Address",
            emailCtrl,
            TextInputType.emailAddress,
            Icons.email_outlined,
          ),
          const SizedBox(height: 10),
          _formField(
            "Phone Number",
            phoneCtrl,
            TextInputType.phone,
            Icons.phone_outlined,
          ),

          // Add-ons
          const SizedBox(height: 16),
          Text(
            "Add-ons",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SwitchListTile(
            title: Text("Add travel insurance"),
            value: addInsurance,
            onChanged: (v) => setState(() => addInsurance = v),
            activeColor: Colors.blueAccent,
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            title: Text("Sign up for newsletter"),
            value: newsletter,
            onChanged: (v) => setState(() => newsletter = v),
            activeColor: Colors.blueAccent,
            contentPadding: EdgeInsets.zero,
          ),

          // Security
          const SizedBox(height: 19),
          Row(
            children: [
              Icon(Icons.lock, size: 19, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                "Your information is secure",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),

          // Continue button
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                elevation: 0,
              ),
              child: Text(
                "Continue to Payment",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onPressed: () {
                // Build travelers list
                final travelersList = [
                  "${nameCtrl.text} (Lead)", // Add more as needed if UI supports more travelers
                ];
                // Pass to PaymentPage (or ReviewPage if you want)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentPage(
                      package: widget.package,
                      dateRange: widget.dateRange,
                      adults: widget.adults,
                      children: widget.children,
                      estimatedPrice: widget.estimatedPrice,
                      travelerDetails: {
                        "name": nameCtrl.text,
                        "dob": dobCtrl.text,
                        "email": emailCtrl.text,
                        "phone": phoneCtrl.text,
                        "addInsurance": addInsurance.toString(),
                        "newsletter": newsletter.toString(),
                      },
                      travelers: travelersList,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _formField(
    String label,
    TextEditingController ctrl,
    TextInputType keyboard,
    IconData icon, {
    bool datePicker = false,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      readOnly: datePicker,
      onTap: datePicker
          ? () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().subtract(
                  const Duration(days: 365 * 18),
                ),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                ctrl.text =
                    "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
              }
            }
          : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: datePicker ? 'DD/MM/YYYY' : null,
        suffixIcon: datePicker ? Icon(Icons.calendar_today, size: 18) : null,
      ),
    );
  }

  String _formatDate(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}";
}
