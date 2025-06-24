import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class CampaignCard extends StatefulWidget {
  const CampaignCard({
    super.key,
    required this.campaignname,
    required this.amountRaised,
    });



 final String campaignname;
 final String amountRaised;

  @override
  State<CampaignCard> createState() => _CampaignCardState();
}

class _CampaignCardState extends State<CampaignCard> {
   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 140,
        width: 320,
        decoration: BoxDecoration(
          color: Themes.secondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.campaignname,
                  style: const TextStyle(
                    color: Themes.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Raised',
                    style: TextStyle(
                      color: Themes.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.amountRaised,
                    style: const TextStyle(
                      color: Themes.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: LinearProgressIndicator(
                  color: Themes.primaryColor,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Text(
                '\$5000 raised out of \$6000',
                style: TextStyle(
                  color: Themes.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
