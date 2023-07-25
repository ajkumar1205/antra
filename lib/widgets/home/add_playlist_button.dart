import 'package:flutter/material.dart';

import '../../design/color.dart';

class AddPlaylistButton extends StatelessWidget {
  final Function onTap;

  const AddPlaylistButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 140,
        width: 140,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.add, size: 50, color: Colors.white),
      ),
    );
  }
}
