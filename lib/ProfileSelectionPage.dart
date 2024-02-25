import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int selectedRadioTile;
  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              SizedBox(height: 1.0),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Please select your profile',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black)),
                    SizedBox(height: 30.0),
                    Container(
                      width: 350.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          value: 1,
                          groupValue: selectedRadioTile,
                          title: Row(
                            children: [
                              SvgPicture.asset('vectors/warehouse.svg',
                                  color: Colors.black, width: 40.0),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shipper',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.black)),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'Lorem ipsum dolor sit amet, \nconsectetur adipiscing',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                          color: Colors.grey[700]))
                                ],
                              )
                            ],
                          ),
                          onChanged: (val) {
                            setSelectedRadioTile(val!);
                          },
                          activeColor: Colors.indigo[900],
                          selected: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 350.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          value: 2,
                          groupValue: selectedRadioTile,
                          title: Row(
                            children: [
                              SvgPicture.asset('vectors/truck.svg',
                                  color: Colors.black, width: 40.0),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Transporter',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.black)),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'Lorem ipsum dolor sit amet, \nconsectetur adipiscing',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                          color: Colors.grey[700]))
                                ],
                              )
                            ],
                          ),
                          onChanged: (val) {
                            setSelectedRadioTile(val!);
                          },
                          activeColor: Colors.indigo[900],
                          selected: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.indigo[900],
                            minimumSize: Size(300.0, 50.0),
                            primary: Colors.white),
                        onPressed: () {},
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 1.0),
              SizedBox(height: 1.0)
            ])));
  }
}