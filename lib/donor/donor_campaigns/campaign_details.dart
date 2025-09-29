import 'package:donation_tracker/donor/donate.dart';
import 'package:donation_tracker/models/camp_model.dart' show Campaign;
import 'package:donation_tracker/models/ngo_model.dart';
import 'package:flutter/material.dart';
import 'package:donation_tracker/firebase/authentication/firebase_auth_methods.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_colors.dart';

class CampaignDetailsScreen extends StatefulWidget {
  final Campaign campaign;

  const CampaignDetailsScreen({
    super.key,
    required this.campaign,
  });

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  NGO? _selectedNGO;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNGO();
  }

  Future<void> fetchNGO() async {
    final authMethods =
        Provider.of<FirebaseAuthMethods>(context, listen: false);
    final fetchedNgo = await authMethods.getNGOById(widget.campaign.ngoId);
    setState(() {
      _selectedNGO = fetchedNgo;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: const Text(
            'Campaign Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Brought to you by: King\'s Charity Foundation',
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        // color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                        child: Image.asset(
                            'lib/assets/images/charity.png')),
                    const SizedBox(height: 20),
                    Text(
                      widget.campaign.title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Description: ${widget.campaign.description}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Progress: \$${widget.campaign.donatedAmount} raised of \$${widget.campaign.targetAmount} target',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: widget.campaign.donatedAmount /
                          widget.campaign.targetAmount,
                      backgroundColor: Themes.borderColor,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Themes.secondaryColor),
                    ),
                    const SizedBox(height: 48),
                    Center(
                      child: CustomButton(text: 'Donate Now', 
                      onPressed: () {
                       Navigator.pushNamed(context, '/donate_screen');
                      },),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ));
  }
}
