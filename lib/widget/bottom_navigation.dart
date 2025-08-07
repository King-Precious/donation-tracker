import 'package:donation_tracker/pages/campaigns/campaign_screen.dart';
import 'package:flutter/material.dart';
import '../pages/donor_dash.dart';
import '../pages/profile.dart';
import '../theme/theme_colors.dart';
import '../pages/donation_history.dart';


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int myIndex = 0;
  List<Widget> widgetList = const [
    DonorDashboard(),
    CampaignScreen(),
    DonationHistory(),
    ProfilePage(),
  ];

  List<String> appBarList = [
    'Donor Dashboard',
    'Campaigns',
    'History',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text(
            appBarList[myIndex],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: Themes.secondaryColor,
            onTap: (index) {
              setState(() {
                myIndex = index;
              });
            },
            currentIndex: myIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                label: 'Campaigns',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm_rounded),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: 'Profile',
              ),
            ]),
        body: Center(child: widgetList[myIndex]),);
  }
}
