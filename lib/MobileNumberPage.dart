import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'ProfileSelectionPage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class MobileNumberPage extends StatefulWidget {
  const MobileNumberPage({Key? key}) : super(key: key);

  @override
  _MobileNumberPageState createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();
  var codeSent = false;
  var isNumberScreen = true;
  var isOTPScreen = false;
  String verificationCode = '';
  late String smsCode = '';
  bool isVerifying = false;

  @override
  void initState() {
    super.initState();
    _listenForCode();
  }

  void _listenForCode() async {
    try {
      String code = (await SmsAutoFill().listenForCode) as String;
      if (code != null) {
        setState(() {
          smsCode = code;
        });
      }
    } catch (error) {
      print("Error listening for SMS code: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? returnOTPScreen() : returnNumberScreen();
  }

  Widget returnNumberScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:
                      const Icon(Icons.close, color: Colors.black, size: 28.0),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Please enter your mobile number.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  const Text(
                    'You will receive a 6-digit code to verify next.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: 355.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              'vectors/India.svg',
                              width: 34.0,
                            ),
                          ),
                          const Text(
                            '+91   -   ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: 220.0,
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.phone,
                                  controller: numberController,
                                  decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Montserrat',
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  validator: (number) {
                                    if (numberController.text.length < 10) {
                                      return 'Input a 10-digit mobile number.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      minimumSize: Size(220.0, 50.0),
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          sendOTP();
                          isNumberScreen = false;
                          isOTPScreen = true;
                        });
                      }
                    },
                    child: const Text(
                      'CONTINUE',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SvgPicture.asset('vectors/Vector4.svg', width: 430.0),
                SvgPicture.asset('vectors/Vector3.svg', width: 430.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget returnOTPScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isOTPScreen = false;
                      isNumberScreen = true;
                      smsCode = '';
                    });
                  },
                  child: const Icon(Icons.arrow_back,
                      color: Colors.black, size: 28.0),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Verify Phone',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    codeSent
                        ? 'Please enter the OTP sent to ' +
                            numberController.text
                        : 'Sending OTP code SMS to ' + numberController.text,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  codeSent
                      ? PinInputTextField(
                          pinLength: 6,
                          decoration: BoxLooseDecoration(
                            strokeColorBuilder: PinListenColorBuilder(
                              Colors.black, // Provide a valid color here
                              Colors.black,
                            ),
                            textStyle: const TextStyle(fontSize: 20.0,color: Colors.black),
                          ),
                          controller: TextEditingController(text: smsCode),
                          onChanged: (pin) {
                            if (pin.length == 6) {
                              verifyOTP(pin);
                            }
                          },
                        )
                      : Container(),
                  SizedBox(height: 30.0),
                  codeSent
                      ? isVerifying
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                const Text(
                                  'Did not receive code?',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      codeSent = false;
                                    });
                                    sendOTP();
                                  },
                                  child: const Text(
                                    'Resend code.',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            )
                      : Container(),
                  codeSent
                      ? TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.indigo[900],
                            minimumSize: Size(300.0, 50.0),
                          ),
                          onPressed: () async {
                            if (smsCode.isNotEmpty) {
                              setState(() {
                                isVerifying = true;
                              });
                              try {
                                await auth.signInWithCredential(
                                  PhoneAuthProvider.credential(
                                    verificationId: verificationCode,
                                    smsCode: smsCode,
                                  ),
                                );
                                setState(() {
                                  isOTPScreen = false;
                                  isNumberScreen = false;
                                });
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProfilePage(key: UniqueKey()),
                                  ),
                                  (route) => false,
                                );
                              } catch (e) {
                                // Handle sign in error
                                print(e.toString());
                                setState(() {
                                  isVerifying = false;
                                });
                              }
                            }
                          },
                          child: const Text(
                            'VERIFY AND CONTINUE',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            const SizedBox(height: 1.0),
          ],
        ),
      ),
    );
  }

  Future<void> sendOTP() async {
    var phoneNumber = '+91' + numberController.text;
    var verifyPhone = auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        smsCode = phoneAuthCredential.smsCode!;
        verificationCode = phoneAuthCredential.verificationId!;

        // Now you can sign in the user
        try {
          await auth.signInWithCredential(phoneAuthCredential);
          setState(() {
            isOTPScreen = false;
            isNumberScreen = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ProfilePage(key: UniqueKey()),
            ),
            (route) => false,
          );
        } catch (e) {
          // Handle sign in error
          print(e.toString());
        }
      },
      verificationFailed: (authException) {
        print('Verification failed: ${authException.message}');
      },
      codeSent: (verificationID, [forceResendToken]) {
        setState(() {
          verificationCode = verificationID;
          codeSent = true;
        });
      },
      codeAutoRetrievalTimeout: (verificationID) {
        setState(() {
          verificationCode = verificationID;
        });
      },
      timeout: const Duration(seconds: 10),
    );
    await verifyPhone;
  }

  Future<void> verifyOTP(String pin) async {
    try {
      await auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationCode,
          smsCode: pin,
        ),
      );
      setState(() {
        isOTPScreen = false;
        isNumberScreen = false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ProfilePage(key: UniqueKey()),
        ),
        (route) => false,
      );
    } catch (e) {
      // Handle sign in error
      print(e.toString());
    }
  }
}

class OTPProvider with ChangeNotifier {
  String smsCode = '';

  void initSMSListener() async {
    try {
      String code = (SmsAutoFill().listenForCode) as String;
      if (code != null) {
        setSMSCode(code);
      }
    } catch (error) {
      print("Error listening for SMS code: $error");
    }
  }

  void setSMSCode(String code) {
    smsCode = code;
    notifyListeners();
  }
}
