import 'package:black_coffer/auth/otpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<PhoneAuth> {
  FlCountryCodePicker countryCodePicker = const FlCountryCodePicker();
  TextEditingController phoneController = TextEditingController();
  late CountryCode countryCode;

  @override
  void initState() {
    super.initState();

    countryCode = countryCodePicker.countryCodes
        .firstWhere((element) => element.name == "India");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //     leading: IconButton(
          //   icon: const Icon(
          //     Icons.arrow_back,
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // )
          ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter mobile number",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    final code =
                        await countryCodePicker.showPicker(context: context);
                    if (code != null) {
                      countryCode = code;
                      setState(() {});
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 20,
                        child: countryCode.flagImage(),
                      ),
                      Text(
                        "   ${countryCode.dialCode} ",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "7715949586"),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Divider(),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "By continuing, I confirm that i have read & agree to the",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Terms & conditions",
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
                Text(
                  " and ",
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
                Text(
                  "Privacy policy",
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => OTPScreen(
                              number: phoneController.text,
                              code: countryCode.dialCode,
                            )),
                      ),
                    );
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                    child: Text(
                      'VERIFY',
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
          ],
        ),
      ),
    );
  }
}
