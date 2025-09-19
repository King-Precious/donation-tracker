import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class ReusableCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final int targetAmount;
  final int donatedAmount;
  final VoidCallback? onTap;

  const ReusableCard({
    super.key,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.donatedAmount,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    double progressValue = targetAmount > 0
        ? donatedAmount / targetAmount
        : 0.0; // Avoid division by zero
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 150,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 3),
             Text('\$ $donatedAmount / \$ $targetAmount'),
             const SizedBox(height: 3),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Themes.secondaryColor.withOpacity(0.1),
                  color: Themes.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Themes.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Themes.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
