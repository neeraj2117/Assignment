import 'dart:math';

import 'package:black_coffer/constants/common.dart';
import 'package:black_coffer/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class OTPScreen extends StatefulWidget {
  final String number;
  final String code;

  OTPScreen({
    super.key,
    required this.number,
    required this.code,
  });

  @override
  State<OTPScreen> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String vId = "";
  var otpCode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    onSendSms();
  }

  onSendSms() async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "${widget.code} ${widget.number}",
        timeout: const Duration(seconds: 5),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          mdShowAlert("Fail", error.toString(), () {});
        },
        codeSent: (verificationId, forceResendingToken) {
          vId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          vId = verificationId;
        },
      );
    } catch (e) {
      mdShowAlert("Fail", e.toString(), () {});
    }
  }

  void smsVerification() async {
    if (otpCode.length < 6) {
      mdShowAlert("Error", "Please enter valid code", () {});
      return;
    }

    try {
      final AuthCredential credential =
          PhoneAuthProvider.credential(verificationId: vId, smsCode: otpCode);

      final User? user = (await auth.signInWithCredential(credential)).user;

      if (user != null) {
        mdShowAlert(
            "Success", "Successfully signed in UID : ${user.uid}", () {});
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      } else {
        mdShowAlert("Fail", "invalid otp", () {});
      }
    } catch (e) {
      mdShowAlert("Fail", e.toString(), () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "OTP Verification",
              style: TextStyle(
                color: Colors.black,
                fontSize: 31,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Enter the 4-digit code sent to you at",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 19,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.code} ${widget.number}",
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Colors.black,
              focusedBorderColor: Colors.black,
              textStyle: TextStyle(color: Colors.black, fontSize: 16),
              showFieldAsBox: false,
              borderWidth: 4.0,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                otpCode = code;
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                otpCode = verificationCode;
                smsVerification();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  onPressed: () async {
                    smsVerification();
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpTimerButton(
                  height: 60,
                  onPressed: () {},
                  text: const Text(
                    'Resend OTP',
                    style: TextStyle(fontSize: 16),
                  ),
                  buttonType: ButtonType.text_button,
                  backgroundColor: Colors.black,
                  duration: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
