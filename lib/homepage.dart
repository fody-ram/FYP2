import 'package:flutter/material.dart';
import 'package:EyePeek/p2.dart'; 

class Myhome extends StatelessWidget {
  const Myhome({Key? key}) : super(key: key);

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The scaffold body
      body: Container(
        // The border decoration
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF72D0EF),
            width: 18.0,
            style: BorderStyle.solid,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              // The main axis alignment
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // The logo image
                Image.asset(
                  'assets/logo.jpeg',
                  width: 300.0,
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
                // Vertical spacing
                SizedBox(height: 100.0),
                // The information container
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.zero,
                    color: Color(0xFF72D0EF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'One image, One click, endless clarity.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),
                // Vertical spacing
                SizedBox(height: 10.0),
                // The button container
                Container(
                  width: double.infinity,
                  height: 120.0,
                  child: Center(
                    child: ElevatedButton(
                      child: Text(
                        'Get Started !',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      // The button action
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => P2(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        minimumSize: Size(300.0, 60.0),
                        backgroundColor: Color(0xFF72D0EF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
