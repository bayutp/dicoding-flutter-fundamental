import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/restaurant_detail.dart';
import 'package:tourism_app/provider/detail/restaurant_detail_provider.dart';
import 'package:tourism_app/provider/review/customer_review_provider.dart';
import 'package:tourism_app/static/customer_review_result_state.dart';
import 'package:tourism_app/style/colors/restaurant_colors.dart';

class ReviewScreen extends StatefulWidget {
  final RestaurantDetail restaurant;
  const ReviewScreen({super.key, required this.restaurant});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late CustomerReviewProvider _provider;
  late RestaurantDetailProvider _detailProvider;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    _provider = context.read<CustomerReviewProvider>();
    _detailProvider = context.read<RestaurantDetailProvider>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerReviewProvider>(
      builder: (context, value, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (value.resultState is CustomerReviewLoadedState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Review berhasil dikirim')));

            _nameController.clear();
            _reviewController.clear();

            _detailProvider.getRestaurantDetail(widget.restaurant.id);
            _provider.resetState();
          } else if (value.resultState is CustomerReviewErrorState) {
            final errorMessage =
                (value.resultState as CustomerReviewErrorState).error;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(errorMessage)));

            _provider.resetState();
          }
        });
        return Scaffold(
          appBar: AppBar(title: Text('Add Review')),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Form Review',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge?.copyWith(fontSize: 24),
                  ),
                  SizedBox.square(dimension: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Input your name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox.square(dimension: 8),
                  TextFormField(
                    controller: _reviewController,
                    minLines: 3,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Input your review",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Review tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  SizedBox.square(dimension: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed:
                          (value.resultState is CustomerReviewLoadingState)
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                Future.microtask(() {
                                  _provider.addReview(
                                    widget.restaurant.id,
                                    _nameController.text,
                                    _reviewController.text,
                                  );
                                });
                              }
                            },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          RestaurantColors.amber.colors,
                        ),
                        foregroundColor: WidgetStateProperty.all(
                          RestaurantColors.white.colors,
                        ),
                      ),
                      child: (value.resultState is CustomerReviewLoadingState)
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Kirim',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineLarge?.copyWith(fontSize: 16),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
