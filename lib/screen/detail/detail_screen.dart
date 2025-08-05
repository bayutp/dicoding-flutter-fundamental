import 'package:flutter/material.dart';
import 'package:tourism_app/model/tourism.dart';

class DetailScreen extends StatefulWidget {
  final Tourism tourism;
  const DetailScreen({super.key, required this.tourism});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tourism Detail')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.tourism.image,
              child: Image.network(
                widget.tourism.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tourism.name,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.tourism.address,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red),
                          SizedBox(width: 4),
                          Text(
                            '20',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.tourism.description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
