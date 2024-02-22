import 'package:flutter/material.dart';

class LogoutComponent extends StatelessWidget {
  const LogoutComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        // Handle the button press
      },
      icon: Icon(
        Icons.exit_to_app, // This is the Material icon for "logout"
        color: Colors.white, // Assuming the arrow is white
      ),
      label: Text(''), // No text, just the icon
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Set the background color to transparent
        minimumSize: Size(0, 50), // Button minimum size
        shape: RoundedRectangleBorder( // Assuming the button has rounded corners
          borderRadius: BorderRadius.circular(12), // Adjust the corner radius if needed
        ),
      ),
    );
  }
}
