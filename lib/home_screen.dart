import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'otp_login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _location = "Location: Unknown";
  String _dateTime = "Date & Time: Unknown";

  Future<void> _getAttendance() async {
    // Check for location permissions
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _location = "Location services are disabled.";
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        setState(() {
          _location = "Location permissions are denied.";
        });
        return;
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String dateTime = DateFormat('yyyy-MM-dd – kk:mm:ss').format(DateTime.now());

    setState(() {
      _location = "Location: (${position.latitude}, ${position.longitude})";
      _dateTime = "Date & Time: $dateTime";
    });
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OTPScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATTENDENCE APP',),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        backgroundColor: const Color(0xff45d6d8),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.black,
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getAttendance,
              child: const Text('Attendance', style: TextStyle(fontSize: 18.0), ),
              style: ElevatedButton.styleFrom(
                 // Set the button color here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),

                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(_location, style: const TextStyle(color: Colors.black, fontSize: 20)),
            const SizedBox(height: 10),
            Text(_dateTime, style: const TextStyle(color: Colors.black, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
