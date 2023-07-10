import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintRow extends StatefulWidget {
  @override
  _FingerprintRowState createState() => _FingerprintRowState();
}

class _FingerprintRowState extends State<FingerprintRow> {
  bool isChecked = false;
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    checkFingerprintStatus();
  }

  Future<void> checkFingerprintStatus() async {
    try {
      bool isFingerprintAvailable = await _localAuthentication.canCheckBiometrics;
      if (isFingerprintAvailable) {
        List<BiometricType> availableBiometrics = await _localAuthentication.getAvailableBiometrics();
        bool isFingerprintRecorded = availableBiometrics.contains(BiometricType.fingerprint);

        setState(() {
          isChecked = isFingerprintRecorded;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> scanFingerprint() async {
    try {
      bool isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Scan fingerprint to authenticate',
        // useErrorDialogs: true,
        // stickyAuth: true,
      );

      if (isAuthenticated) {
        setState(() {
          isChecked = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        GestureDetector(
          onTap: () {
            scanFingerprint();
          },
          child: Text(
            'Scan fingerprint',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
