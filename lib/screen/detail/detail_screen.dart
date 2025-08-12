import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/data/model/tourism.dart';
import 'package:tourism_app/data/model/tourism_detail_response.dart';
import 'package:tourism_app/provider/detail/bookmark_icon_provider.dart';
import 'package:tourism_app/screen/detail/bookmark_icon_widget.dart';

class DetailScreen extends StatefulWidget {
  final int toursimId;
  const DetailScreen({super.key, required this.toursimId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Completer<Tourism> _completerTourism = Completer<Tourism>();
  late Future<TourismDetailResponse> _futureTourismDetail;

  @override
  void initState() {
    _futureTourismDetail = ApiService().getTourismDetail(widget.toursimId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourism Detail'),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: FutureBuilder(
              future: _completerTourism.future,
              builder: (context, snapshot) {
                return switch (snapshot.connectionState) {
                  ConnectionState.done => BookmarkIconWidget(
                    tourism: snapshot.data!,
                  ),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _futureTourismDetail,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              final tourismData = snapshot.data!.place;
              _completerTourism.complete(tourismData);
              return BodyOfDetailScreenWidget(tourism: tourismData);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class BodyOfDetailScreenWidget extends StatelessWidget {
  final Tourism tourism;
  const BodyOfDetailScreenWidget({super.key, required this.tourism});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: tourism.image,
            child: Image.network(
              tourism.image,
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
                            tourism.name,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 10),
                          Text(
                            tourism.address,
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
                  tourism.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
