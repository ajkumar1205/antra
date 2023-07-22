import 'package:flutter/material.dart';

import '../design/color.dart';
import '../widgets/home/body_widget.dart';
import '../widgets/home/rounded_bottom_bar.dart';

class HomeTabsManagingScreen extends StatelessWidget {
  const HomeTabsManagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-dark.jpg'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.grey,
              Colors.black87,
              Colors.black,
            ],
          ),
        ),
        child: const Body(),
      ),
      bottomNavigationBar: const RoundedBottomBar(),
    );
  }
}
