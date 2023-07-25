import 'package:flutter/material.dart';

import '../../design/color.dart';

class PlaylistContainer extends StatelessWidget {
  final String tag;
  final List<Widget> children;
  const PlaylistContainer({
    super.key,
    required this.tag,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: subColor.withOpacity(0.80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              tag,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
