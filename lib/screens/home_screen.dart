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
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: AnimatedContainer(
      //     duration: const Duration(milliseconds: 500),
      //     margin: const EdgeInsets.only(top: 25, left: 30, right: 30),
      //     decoration: BoxDecoration(
      //       color: subColor,
      //       borderRadius: BorderRadius.circular(30),
      //     ),
      //   ),
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
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
