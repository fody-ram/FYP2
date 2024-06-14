import 'package:flutter/material.dart';
import 'package:EyePeek/p3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class P2 extends StatefulWidget {
  const P2({Key? key}) : super(key: key);
  @override
  _P2State createState() => _P2State();
}

class _P2State extends State<P2> {
  bool _imageUploaded = false; // Tracks if an image uploaded
  String? _filePath; // image Path  
  String _buttonText = 'Upload OCT image'; // Initial button text

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        _imageUploaded = true; // Image is uploaded
        _filePath = result.files.single.path; // Save the path of the image
        _buttonText = 'Image Uploaded'; // Update button text
      });
    }
  }

  Future<void> _uploadImage(String filePath) async {
    // Read image as bytes
    final bytes = await File(filePath).readAsBytes();
    // Encode image 
    final imageData = base64Encode(bytes);
    // Construct the URL and headers for the request
    final url = Uri.parse('http://192.168.120.36:5000/classify');
    final headers = {'Content-Type': 'application/json'};
    // Construct request body
    final body = jsonEncode({'image': imageData});

    try {
      // Send the request and handle the response
      final response = await http.post(url, body: body, headers: headers);
      if (response.statusCode == 200) {
        // Decode the response and extract the predicted class
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        final predictedClass = decodedResponse['predicted_class'];
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => p3(
              predictedClass: predictedClass,
              imagePath: _filePath,
            ),
          ),
        );
      } else {
        print('Error uploading image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making request: $e');
    }
  }

  // Build method to render the widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container for the image and logo
              Container(
                width: 350.0,
                height: 500.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(
                    color: Color(0xFF72D0EF),
                    width: 6.0,
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/logo.jpeg',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          'Check your Eye Health.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF72D0EF)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              // Button to pick a file
              Container(
                width: double.infinity,
                height: 120.0,
                child: Center(
                  child: ElevatedButton(
                    child: Text(
                      _buttonText,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: _pickFile,
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
              SizedBox(height: 10.0),
              // Button to upload an image if one is chosen
              _imageUploaded
                  ? ElevatedButton(
                      child: Text(
                        'Next',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () {
                        if (_filePath != null) {
                          _uploadImage(_filePath!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        minimumSize: Size(300.0, 60.0),
                        backgroundColor: Color(0xFF72D0EF),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

