import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              const Text('\$ 35,000 / \$ 50,000'),
              Padding(
                padding: const EdgeInsets.all(10),
                child: LinearProgressIndicator(
                  value: 0.7,
                  backgroundColor: Themes.secondaryColor.withOpacity(0.1),
                  color: Themes.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Themes.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 13,
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
