import 'package:flutter/material.dart';

import '../../provider/offline_query_provider.dart';

void showCreatePlaylistDialog(BuildContext context, Query q) {
  TextEditingController nameController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.all(20),
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Create",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
