import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'home_screen.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOTPRequested = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/phone_verification1.png', // Make sure this image is in the assets directory
                  height: 200.0,
                ),
                SizedBox(height: 40.0),
                Text(
                  'Your Phone!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'We will send you a one-time password on this mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 30.0),
                if (!_isOTPRequested) ...[
                  TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(

                      prefixIcon: Icon(Icons.phone, color: Colors.black),
                      labelText: 'Enter Phone Number',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\+\d{0,13}')), // Restrict to + and numbers up to 13 digits
                    ],
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 25.0),
                  ElevatedButton(
                    onPressed: _phoneNumberController.text.length == 13
                        ? () {
                      Provider.of<AuthenticationService>(context, listen: false)
                          .sendOTP(_phoneNumberController.text);
                      setState(() {
                        _isOTPRequested = true;
                      });
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent, // Background color
                      onPrimary: Colors.black, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    ),
                    child: Text('Receive OTP'),
                  ),
                ] else ...[
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: _otpController.text.isNotEmpty
                        ? () {
                      Provider.of<AuthenticationService>(context, listen: false)
                          .verifyOTP(_otpController.text, context);
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent, // Background color
                      onPrimary: Colors.black, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    ),
                    child: Text('Verify OTP'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'authentication_service.dart';
// import 'home_screen.dart';
//
// class OTPScreen extends StatefulWidget {
//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   bool _isOTPRequested = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (!_isOTPRequested) ...[
//                 TextField(
//                   controller: _phoneNumberController,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     labelStyle: TextStyle(color: Colors.black),
//                     border: OutlineInputBorder(
//
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide(
//                         color: Colors.teal,
//                       ),
//                     ),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(
//                         RegExp(r'^\+\d{0,13}')), // Restrict to + and numbers up to 13 digits
//                   ],
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: _phoneNumberController.text.length == 13
//                       ? () {
//                     Provider.of<AuthenticationService>(context, listen: false)
//                         .sendOTP(_phoneNumberController.text);
//                     setState(() {
//                       _isOTPRequested = true;
//                     });
//                   }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.teal, // Background color
//                     onPrimary: Colors.black, // Text color
//                   ),
//                   child: Text('Request OTP'),
//                 ),
//               ] else ...[
//                 TextField(
//
//                   controller: _otpController,
//                   decoration: InputDecoration(
//                     labelText: 'OTP',
//                     labelStyle: TextStyle(color: Colors.black),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide(
//                         color: Colors.teal,
//                       ),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: _otpController.text.isNotEmpty
//                       ? () {
//                     Provider.of<AuthenticationService>(context, listen: false)
//                         .verifyOTP(_otpController.text, context);
//                   }
//                       : null,
//                   child: Text('Verify OTP'),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
