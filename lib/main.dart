
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tasaya_partner_application/view/Bottom_Sheet.dart';
import 'package:tasaya_partner_application/view/Dashboard.dart';
import 'package:tasaya_partner_application/view/DeliveryScreen.dart';
import 'package:tasaya_partner_application/view/login_page.dart';

import 'constants/AppColors.dart';

void main() {
  // Flogger.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Dashboard(),
    DeliveryScreen(),
    Bottom_Sheet(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black54,
        selectedItemColor: Colors.white, // Set selected item text color
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            // If "New Order" tab is clicked, show the bottom sheet
            _showNewOrderBottomSheet(context);
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, color: AppColors.primaryColor),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: AppColors.primaryColor),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: AppColors.primaryColor),
            label: 'New Order',
          ),
        ],
      ),
    );
  }

  void _showNewOrderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'NEW ORDER!!!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'PickUp Location: Airport Road',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Delivery Location: Vijay Nagar',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Expected Payment: 500 RS (Cash)',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black54,
                      onPrimary: AppColors.primaryColor, // Set the text color of the button
                    ),
                    onPressed: () {
                      // Handle Accept button action
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    icon: Icon(Icons.check),
                    label: Text('Accept'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black54,
                      onPrimary: AppColors.primaryColor, // Set the text color of the button
                    ),
                    onPressed: () {
                      // Handle Reject button action
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    icon: Icon(Icons.close),
                    label: Text('Reject'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
