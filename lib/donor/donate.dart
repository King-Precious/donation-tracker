import 'package:donation_tracker/donor/donor_success.dart';
import 'package:flutter/material.dart';
import 'package:donation_tracker/theme/theme_colors.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_textfield.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:donation_tracker/sevices/wallet_service.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  final WalletService _walletService = WalletService();
  String? _walletAddress;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _walletService.connector.on('connect', (session) {
      if (mounted && session is SessionStatus) {
        setState(() {
          _walletAddress = session.accounts.first;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wallet Connected Successfully!')),
        );
      }
    });
    _walletService.connector.on('disconnect', (session) {
      if (mounted) {
        setState(() {
          _walletAddress = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wallet Disconnected.')),
        );
      }
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    remarkController.dispose();
    _walletService.dispose();
    super.dispose();
  }

  Future<void> _submitDonation() async {
    if (!formkey.currentState!.validate()) return;

    if (_walletAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please connect your wallet to donate.')),
      );
      return;
    }

    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final double amount = double.parse(amountController.text);
      final String remark = remarkController.text;
      const String ngoWalletAddress = '0x50E70fC7cc08AECf868Be7C7d370275289b73BF5'; // NGO wallet

      // 🔑 Send USDT donation
      final String txHash = await _walletService.sendUSDTDonation(
        toAddress: ngoWalletAddress,
        amount: amount,
      );

      if (mounted) {
        // Navigate to external success screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DonationSuccessScreen(
              transactionHash: txHash,
              amount: amount,
              
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transaction Failed: ${e.toString().split(':').last.trim()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = _walletAddress != null;
    final buttonText = _isProcessing
        ? 'Processing Transfer...'
        : isConnected
            ? 'Donate ${amountController.text.isNotEmpty ? '${amountController.text} USDT' : ''}'
            : 'Connect Wallet to Donate';

    String displayAddress = isConnected
        ? '${_walletAddress!.substring(0, 6)}...${_walletAddress!.substring(_walletAddress!.length - 4)}'
        : 'Not Connected';

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
                'Wallet Status: $displayAddress',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isConnected ? Colors.green[700] : Colors.red,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                'Donating to: King\'s Charity Foundation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              const Text(
                'Donation Amount (in USDT)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                controller: amountController,
                labeltext: 'Amount (e.g., 10)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid amount in USDT';
                  }
                  return null;
                },
                onChanged: (value) => setState(() {}),
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
                  text: buttonText,
                  onPressed: isConnected && !_isProcessing
                      ? _submitDonation
                      : !isConnected && !_isProcessing
                          ? () => _walletService.connectWallet(context)
                          : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
