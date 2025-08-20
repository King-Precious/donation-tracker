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
                   Text(
                    'Brought to you by: ${widget.campaign.ngoName}',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    widget.campaign.ngoName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    widget.campaign.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description: ${widget.campaign.description}',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.campaign.description,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Progress: \$${widget.campaign.donatedAmount} raised of \$${widget.campaign.targetAmount} target',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: widget.campaign.donatedAmount /
                        widget.campaign.targetAmount,
                    backgroundColor: Themes.borderColor,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Themes.secondaryColor),
                  ),
                  const SizedBox(height: 8),
                  CustomButton(
                    text: 'Donate Now',
                    onPressed: () {
                      if (_selectedNGO != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DonationScreen(selectedNGO: _selectedNGO!),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error: NGO not found.'),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
    );
  }
}
