import 'package:donation_tracker/widget/custom_button.dart';
import 'package:flutter/material.dart';

class DonationSuccessScreen extends StatelessWidget {
  final String transactionHash;
  final double amount;

  const DonationSuccessScreen({
    required this.transactionHash,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donation Complete!')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),

              // Thank you + Amount donated
              Text(
                'Thank you for donating ${amount.toStringAsFixed(2)} USDT!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),
              const Text(
                'Transaction Hash:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              // Display hash
              Text(
                transactionHash,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              CustomButton(
                text: 'Go Back Home',
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
