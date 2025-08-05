import 'package:flutter/material.dart';
import 'package:tourism_app/utils/sliver_header_delegate.dart';

class LearningPathScreen extends StatelessWidget {
  const LearningPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomScrollView(slivers: []));
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
