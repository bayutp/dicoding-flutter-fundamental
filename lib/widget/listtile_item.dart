import 'package:flutter/material.dart';
import 'package:tourism_app/model/dicoding_course.dart';

class ListtileItem extends StatelessWidget {
  final DicodingCourse course;
  const ListtileItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(course.title),
      subtitle: Text(
        course.description,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: true,
      onTap: () {},
    );
  }
}
