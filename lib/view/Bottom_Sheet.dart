import 'package:flutter/material.dart';

class Bottom_Sheet extends StatelessWidget {
  const Bottom_Sheet({super.key});

  @override
  Widget build(BuildContext context) {
    _showCustomBottomSheet(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // _showCustomBottomSheet(context);
          },
          child: Text('Open Bottom Sheet'),
        ),
      ),
    );
  }
  void _showCustomBottomSheet(BuildContext context) {
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
                    onPressed: () {
                      // Handle Accept button action
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    icon: Icon(Icons.check),
                    label: Text('Accept'),
                  ),
                  ElevatedButton.icon(
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