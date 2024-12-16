import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _completeIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          _buildPage('assets/Introduction1.jpg'),
          _buildPage('assets/Introduction2.jpg'),
          _buildPage('assets/Introduction3.jpg'),
        ],
      ),
      bottomSheet: _currentPage == 2
          ? ElevatedButton(
        onPressed: _completeIntro,
        child: Text(
          'Get Started',
          style: TextStyle(
            color: Colors.white, // Weißer Text
            fontWeight: FontWeight.bold, // Fetter Text
            fontSize: 30, // Optionale Schriftgröße
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 60),
          backgroundColor: Colors.blue,
        ),
      )
          : null, // Kein Bottom Sheet für die ersten beiden Seiten
    );
  }

  Widget _buildPage(String image) {
    return Center(
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: _currentPage == index ? 12 : 8,
      height: _currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}