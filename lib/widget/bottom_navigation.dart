import 'package:donation_tracker/donor/donor_campaigns/campaign_screen.dart';
import 'package:flutter/material.dart';
import '../donor/donor_dash.dart';
import '../donor/donor_profile.dart';
import '../theme/theme_colors.dart';
import '../donor/donate_history/donation_history.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int myIndex = 0;

  final List<Widget> widgetList = const [
    DonorDashboard(),
    CampaignScreen(),
    DonationHistory(),
    ProfilePage(),
  ];

  final List<String> appBarList = const [
    'Donor Dashboard',
    'Campaigns',
    'History',
    'Profile',
  ];

  final List<bool> appBarVisible = const [false, true, true, true];

  final List<BottomNavigationBarItem> navItems = const [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarVisible[myIndex]
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 2,
              title: Text(
                appBarList[myIndex],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Themes.secondaryColor,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: navItems,
      ),
      body: SafeArea(child: widgetList[myIndex]),
    );
  }
}
// class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
//   int myIndex = 0;

//   late List<Widget> widgetList;
//   late List<String> appBarList;
//   late List<bool> appBarVisible;
//   late List<BottomNavigationBarItem> navItems;

//   @override
//   void initState() {
//     super.initState();
//     _setupNavigationItems();
//   }

//   void _setupNavigationItems() {
//     if (widget.userRole == 'donor') {
//       widgetList = const [
//         DonorDashboard(),
//         CampaignScreen(),
//         DonationHistory(),
//         ProfilePage(),
//       ];
//       appBarList = const [
//         'Donor Dashboard',
//         'Campaigns',
//         'History',
//         'Profile',
//       ];
//       appBarVisible = const [false, true, true, true];
//       navItems = const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           label: 'Dashboard',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search_rounded),
//           label: 'Campaigns',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.alarm_rounded),
//           label: 'History',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person_2_outlined),
//           label: 'Profile',
//         ),
//       ];
//     } else if (widget.userRole == 'ngo') {
//       widgetList = [
        
//         NgoDashboard(),
//         const CampaignManagementScreen(),
//         const NgoDonationHistoryScreen(),
        
//       ];
//       appBarList = const [
//         'Admin Panel',
//         'Campaigns Management',
//         'Donation History',
//         'Profile',
//       ];
//       appBarVisible = [
//         true,
//         true,
//         true,
//         true,
//       ];
//       navItems = const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.dashboard_outlined),
//           label: 'Dashboard',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.flag_outlined),
//           label: 'Campaigns',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.history),
//           label: 'Donation History',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: appBarVisible[myIndex]
//           ? AppBar(
//               backgroundColor: Colors.white,
//               elevation: 2,
//               title: Text(
//                 appBarList[myIndex],
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : null,
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         fixedColor: Themes.secondaryColor,
//         onTap: (index) {
//           setState(() {
//             myIndex = index;
//           });
//         },
//         currentIndex: myIndex,
//         items: navItems,
//       ),
//       body: SafeArea(child: widgetList[myIndex]),
//     );
//   }
// }
