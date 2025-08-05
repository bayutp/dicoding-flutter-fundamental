import 'package:flutter/material.dart';
import 'package:tourism_app/model/dicoding_course.dart';
import 'package:tourism_app/utils/sliver_header_delegate.dart';
import 'package:tourism_app/widget/listtile_item.dart';

class LearningPathScreen extends StatelessWidget {
  const LearningPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.medium(title: Text("Dicoding Learning Path")),
          _header(context, "Multiplatform Developer"),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  ListtileItem(course: multiplatformPath[index]),
              childCount: multiplatformPath.length,
            ),
          ),
          _header(context, "IOS Developer"),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListtileItem(course: iosPath[index]),
              childCount: iosPath.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
          _header(context, "Android Developer"),
          SliverList.builder(
            itemBuilder: (context, index) =>
                ListtileItem(course: androidPath[index]),
            itemCount: androidPath.length,
          ),
          _header(context, "Front End Developer"),
          SliverGrid.count(
            crossAxisCount: 2,
            children: webPath
                .map((webClass) => ListtileItem(course: webClass))
                .toList(),
          ),
        ],
      ),
    );
  }

  SliverPersistentHeader _header(BuildContext context, String text) {
    return SliverPersistentHeader(
      delegate: SliverHeaderDelegate(
        minHeight: 60,
        maxHeight: 150,
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Center(
            child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ),
      ),
    );
  }
}
