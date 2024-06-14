import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

/// takes in the predicted class and the path to the image.
class p3 extends StatelessWidget {
  final String predictedClass;
  final String? imagePath;

  const p3({Key? key, required this.predictedClass, this.imagePath})
      : super(key: key);

  String getDiseaseDefinition(String predictedClass) {
    switch (predictedClass) {
      case 'CNV':
        return 'Choroidal neovascularization (CNV) is the growth of new blood vessels beneath the retina, which can lead to vision loss.';
      case 'DRUSEN':
        return 'Drusen are yellow deposits under the retina, which can be a sign of age-related macular degeneration.';
      case 'DME':
        return 'Diabetic macular edema (DME) is swelling in the macula due to fluid leakage, common in diabetic retinopathy.';
      default:
        return 'Your OCT retinal image appears normal.';
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the disease definition based on the predicted class
    String diseaseDefinition = getDiseaseDefinition(predictedClass);

    return Scaffold(
      // Set the background color to white
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Add vertical spacing
          Image.asset(
            'assets/logo.jpeg',
            width: 200,
            height: 100,
          ),
          SizedBox(height: 20), // Add vertical spacing
          Expanded(
            child: imagePath == null
                ? Center(child: Text('No image selected.'))
                : Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 233, 229, 229),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 50), // Add vertical spacing
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF72D0EF),
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                Text(
                  'OCT Analysis Result:\n$predictedClass detected.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20), // Add vertical spacing
                Text(
                  diseaseDefinition,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20), // Add vertical spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display a learn more button for the predicted class
                    if (predictedClass == 'CNV')
                      ElevatedButton(
                        onPressed: () => _launchInBrowser(Uri.parse(
                            'https://eyewiki.aao.org/Choroidal_Neovascularization:_OCT_Angiography_Findings')),
                        child: Text('Learn more about CNV'),
                      ),
                    if (predictedClass == 'DRUSEN')
                      ElevatedButton(
                        onPressed: () => _launchInBrowser(Uri.parse(
                            'https://www.aao.org/eye-health/diseases/what-are-drusen')),
                        child: Text('Learn more about Drusen'),
                      ),
                    if (predictedClass == 'DME')
                      ElevatedButton(
                        onPressed: () => _launchInBrowser(Uri.parse(
                            'https://eyewiki.aao.org/Diabetic_Macular_Edema')),
                        child: Text('Learn more about DME'),
                      ),
                    if (predictedClass == 'NORMAL')
                      ElevatedButton(
                        onPressed: () => _launchInBrowser(Uri.parse(
                            'https://www.nei.nih.gov/learn-about-eye-health/nei-for-kids/healthy-vision-tips')),
                        child: Text('Explore eye care tips'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
