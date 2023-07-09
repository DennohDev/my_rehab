import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_rehab/pages/verified_child.dart';

class VerifyEnrollKids extends StatefulWidget {
  const VerifyEnrollKids({super.key});

  @override
  State<VerifyEnrollKids> createState() => _VerifyEnrollKidsState();
}

class _VerifyEnrollKidsState extends State<VerifyEnrollKids> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> _authenticateWithBiometrics(BiometricType biometricType) async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with $biometricType',
      );
    } catch (e) {
      print('Error authenticating: $e');
    }

    return isAuthenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Enrolled Kids'),
        centerTitle: true,
        backgroundColor: Color(0XFF254C8F),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                bool isAuthenticated = await _authenticateWithBiometrics(
                    BiometricType.fingerprint);

                if (isAuthenticated) {
                  // Authentication with fingerprint succeeded
                  // Do something here, such as navigate to another page
                  await Fluttertoast.showToast(
                      msg: 'Authentication with fingerprint succeeded');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VerifiedChild()));
                  print('Authentication with fingerprint succeeded');
                } else {
                  // Authentication with fingerprint failed
                  Fluttertoast.showToast(msg: 'User not found in our database');
                  print('Authentication with fingerprint failed');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0XFF254C8F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Text(
                    'Verify with Fingerprint',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
