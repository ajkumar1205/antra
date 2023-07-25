import 'package:flutter/material.dart';

class PlaylistCard extends StatelessWidget {
  final String name;
  final Color color;

  const PlaylistCard({
    super.key,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final list = name.split(" ");
    final sym =
        list.length == 1 ? list[0][0] + list[0][1] : list[0][0] + list[1][0];
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 30,
                width: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.5),
                      color.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              top: 30,
              child: Text(
                sym,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
