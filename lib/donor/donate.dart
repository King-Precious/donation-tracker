import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation_tracker/theme/theme_colors.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_textfield.dart';
import 'package:donation_tracker/models/ngo_model.dart';
import 'package:donation_tracker/models/wallet_service.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class DonationScreen extends StatefulWidget {
  final NGO selectedNGO;

  const DonationScreen({super.key, required this.selectedNGO});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  final WalletService _walletService = WalletService();
  String? _walletAddress;

  @override
  void initState() {
    super.initState();
    _walletService.connector.on('connect', (SessionStatus session) {
      setState(() {
        _walletAddress = session.accounts.first;
      });
    });
    _walletService.connector.on('disconnect', (session) {
      setState(() {
        _walletAddress = null;
      });
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    remarkController.dispose();
    _walletService.dispose();
    super.dispose();
  }

  void _submitDonation() {
    if (formkey.currentState!.validate()) {
      // Here you will handle the donation logic
      // This is where you would call your BlockchainMethods to send the transaction
      // For now, it will just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Donating \$${amountController.text} to ${widget.selectedNGO.name} with remark: ${remarkController.text}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Donation'),
        backgroundColor: Themes.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Donating to: ${widget.selectedNGO.name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Donation Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                controller: amountController,
                labeltext: 'Amount (\$)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a donation amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Add a Remark (Optional)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                controller: remarkController,
                labeltext: 'Your message to the NGO',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 30),
              Center(
                child: CustomButton(
                  text: 'Donate',
                  onPressed: _submitDonation,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  text: _walletAddress != null
                      ? 'Connected: $_walletAddress'
                      : 'Connect Wallet',
                  onPressed: _walletAddress != null
                      ? null
                      : () async {
                          await _walletService.connectWallet(context);
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}