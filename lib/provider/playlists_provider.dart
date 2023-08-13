import 'package:flutter/material.dart';

import './offline_query_provider.dart';

class Playlists extends ChangeNotifier {
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
                onPressed: () async {
                  String name =
                      nameController.text.trim().replaceAll("  ", " ");
                  await q.createPlaylist(name).then(
                    (created) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        !created
                            ? SnackBar(
                                content: Text(
                                  "Something Went Wrong",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              )
                            : SnackBar(
                                content: Text(
                                  "Playlist Created $name",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                              ),
                      );
                      notifyListeners();
                      nameController.clear();
                      Navigator.pop(context);
                    },
                  );
                },
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
    notifyListeners();
  }
}
