import 'package:flutter/cupertino.dart';

class CategoryScreen extends StatelessWidget {
  final String selectedCategory;
  const CategoryScreen({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('$selectedCategory Screen'),
      ),
      child: Center(
        child: Text(
          '$selectedCategory Screen',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
      ),
    );
  }
}
