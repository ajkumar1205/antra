import 'package:flutter/material.dart';

import '../../design/color.dart';

class MusicPlayerTagCard extends StatelessWidget {
  const MusicPlayerTagCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade600,
            Colors.grey.shade800,
            Colors.grey.shade900,
            Colors.black,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
        child: Column(
          children: [
            Text(
              "Explore your offline Music with default Playlists",
              style: TextStyle(
                // shadows: [
                //   Shadow(
                //     color: Colors.white,
                //     blurRadius: 10,
                //     offset: const Offset(-5, 5),
                //   ),
                // ],
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              "Or create your own for more customization",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
