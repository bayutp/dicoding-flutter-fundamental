import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tourism_app/data/model/category.dart';
import 'package:tourism_app/data/model/customer_review.dart';
import 'package:tourism_app/data/model/menus.dart';
import 'package:tourism_app/data/model/restaurant_detail.dart';
import 'package:tourism_app/data/model/restaurant_detail_response.dart';
import 'package:tourism_app/provider/detail/restaurant_detail_provider.dart';
import 'package:tourism_app/static/helper.dart';
import 'package:tourism_app/static/restaurant_detail_result_state.dart';

import '../home/mock_api.dart';

void main() {
  late RestaurantDetailProvider provider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantDetailProvider(mockApiService);
  });

  group("restaurant detail", () {
    test("Memastikan state awal provider harus didefinisikan", () {
      expect(provider.resultState, isA<RestaurantDetailNoneState>());
    });

    test(
      "Memastikan harus mengembalikan data detail restaurant ketika pengembalian data dari api berhasil",
      () async {
        final fakeResponse = RestaurantDetailResponse(
          error: false,
          message: "success",
          restaurant: RestaurantDetail(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description:
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            pictureId: "14",
            city: "Gorontalo",
            address: "Jln. Pandeglang no 19",
            categories: [Category(name: 'Italia')],
            menus: Menus(
              foods: [Category(name: "Paket rosemary")],
              drinks: [Category(name: "Es krim")],
            ),
            rating: 4,
            customerReviews: [
              CustomerReview(
                name: "Ahmad",
                review: "Tidak rekomendasi untuk pelajar!",
                date: "13 November 2019",
              ),
            ],
          ),
        );

        when(
          () => mockApiService.getRestaurantDetail("rqdv5juczeskfw1e867"),
        ).thenAnswer((_) async => fakeResponse);

        // act
        await provider.getRestaurantDetail("rqdv5juczeskfw1e867");

        // assert
        expect(provider.resultState, isA<RestaurantDetailLoadedState>());
        final state = provider.resultState as RestaurantDetailLoadedState;
        expect(state.data.name, "Melting Pot");
      },
    );

    test(
      "Memastikan harus mengembalikan kesalahan ketika terdapat exception",
      () async {
        // arrange
        when(
          () => mockApiService.getRestaurantDetail("rqdv5juczeskfw1e867"),
        ).thenThrow(SocketException("Tidak ada koneksi internet."));

        // act
        await provider.getRestaurantDetail("rqdv5juczeskfw1e867");

        // assert
        expect(provider.resultState, isA<RestaurantDetailErrorState>());
        final state = provider.resultState as RestaurantDetailErrorState;
        expect(state.error, Helper.errInet);
      },
    );
  });
}
