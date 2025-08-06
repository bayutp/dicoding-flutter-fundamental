import 'package:flutter/material.dart';
import 'package:tourism_app/model/tourism.dart';
import 'package:tourism_app/screen/home/tourism_card_widget.dart';
import 'package:tourism_app/static/navigation_route.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmark List")),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final tourism = bookmarkTourismList[index];
          return TourismCard(
            tourism: tourism,
            onTap: () {
              Navigator.pushNamed(
                context,
                Navigationroute.detailRoute.name,
                arguments: tourism,
              );
            },
          );
        },
        itemCount: bookmarkTourismList.length,
      ),
    );
  }
}
