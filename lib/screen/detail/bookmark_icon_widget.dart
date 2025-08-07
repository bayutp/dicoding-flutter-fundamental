import 'package:flutter/material.dart';
import 'package:tourism_app/model/tourism.dart';

class BookmarkIconWidget extends StatefulWidget {
  final Tourism tourism;
  const BookmarkIconWidget({super.key, required this.tourism});

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  late bool _isBookmarked;

  @override
  void initState() {
    final tourismList = bookmarkTourismList.where(
      (tourism) => tourism.id == widget.tourism.id,
    );
    setState(() {
      if (tourismList.isNotEmpty) {
        _isBookmarked = true;
      } else {
        _isBookmarked = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          if (_isBookmarked) {
            bookmarkTourismList.removeWhere(
              (tourism) => tourism.id == widget.tourism.id,
            );
          } else {
            bookmarkTourismList.add(widget.tourism);
          }
          _isBookmarked = !_isBookmarked;
        });
      },
      icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_outline),
    );
  }
}
