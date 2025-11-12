import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String _errorText = "";
  bool _has8Chars = false;
  bool _hasNumber = false;
  bool _hasUppercase = false;

  void _validatePassword(String value) {
    setState(() {
      _has8Chars = value.length >= 8;
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
    });
  }

  void _updatePassword() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorText = "Passwords do not match";
      });
      return;
    }
    if (!_has8Chars || !_hasNumber || !_hasUppercase) {
      setState(() {
        _errorText = "Please meet all password requirements";
      });
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strengthColor = _has8Chars && _hasNumber && _hasUppercase
        ? Colors.green
        : Colors.grey;

    return Scaffold(
      appBar: AppBar(title: const Text("Set New Password"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              const Text(
                "Your new password must be different from previous passwords.",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: _newPasswordController,
                obscureText: _obscureNew,
                onChanged: _validatePassword,
                decoration: InputDecoration(
                  labelText: "New Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNew ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => _obscureNew = !_obscureNew),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Password Strength",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),

              LinearProgressIndicator(
                value:
                    (_has8Chars ? 0.3 : 0) +
                    (_hasNumber ? 0.3 : 0) +
                    (_hasUppercase ? 0.4 : 0),
                color: strengthColor,
                backgroundColor: Colors.grey[300],
                minHeight: 5,
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              if (_errorText.isNotEmpty)
                Text(_errorText, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 15),

              _buildRequirement("At least 8 characters", _has8Chars),
              SizedBox(height: 20),
              _buildRequirement("Contains a number", _hasNumber),
              SizedBox(height: 20),
              _buildRequirement("Includes an uppercase letter", _hasUppercase),

              const SizedBox(height: 340),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _updatePassword,
                  child: const Text(
                    "Update Password",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool met) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle : Icons.radio_button_unchecked,
          color: met ? Colors.green : Colors.grey,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: met ? Colors.black87 : Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
