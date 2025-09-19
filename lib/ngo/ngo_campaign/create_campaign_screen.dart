import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../firebase/authentication/firebase_auth_methods.dart';
import '../../theme/theme_colors.dart';
import '../../widget/custom_textfield.dart';

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({super.key});

  @override
  State<CreateCampaignScreen> createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  // final _imageUrlController = TextEditingController();
  final _targetAmountController = TextEditingController();

  String? _selectedCategory;
  bool _isCreating = false;

  final List<String> _categories = [
    'Health',
    'Education',
    'Environment',
    'Animal Welfare',
    'Disaster Relief',
    'Poverty',
    'Human Rights'
  ];

  Future<void> _createCampaign() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isCreating = true;
      });
      try {
        final authMethods =
            Provider.of<FirebaseAuthMethods>(context, listen: false);
        await authMethods.createCampaign(
          title: _titleController.text,
          description: _descriptionController.text,
          category: _selectedCategory!,
          targetAmount: double.parse(_targetAmountController.text),
          // imageUrl: _imageUrlController.text,
        );
        Navigator.pop(context); // Go back to the previous screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create campaign: $e')),
        );
      } finally {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    // _imageUrlController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Create New Campaign'),
      backgroundColor: Themes.primaryColor,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextfield(
              controller: _titleController,
              labeltext: 'Campaign Title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Description',
                contentPadding: const EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextfield(
              controller: _targetAmountController,
              labeltext: 'Target Amount (\$)',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a target amount';
                }
                if (int.tryParse(value) == null || int.parse(value) < 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _isCreating
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _createCampaign, // Use the correct function here
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Themes.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Create Campaign',
                        style: TextStyle(fontSize: 16)),
                  ),
          ],
        ),
      ),
    ),
  );
}
}