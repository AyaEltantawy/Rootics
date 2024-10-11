import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rootics_final/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final defaultText = TextStyle(color: Colors.black);
  final linkText = TextStyle(color: AppColors().lightGreen);

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white10,
        body: Center(
          child: Container(
            width: double.infinity,
            height: 250,
            color: AppColors().darkGreen,
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: [
                    TextSpan(
                      text: "للتواصل معنا ",
                      style: defaultText,
                    ),
                    TextSpan(
                      text: "اضغط هنا",
                      style: linkText,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await _launchUrl("https://rootics.vercel.app/");
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
