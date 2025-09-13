import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tourism_app/data/model/restaurant.dart';
import 'package:tourism_app/data/model/search_restaurant_response.dart';
import 'package:tourism_app/provider/home/search_restaurant_provider.dart';
import 'package:tourism_app/static/helper.dart';
import 'package:tourism_app/static/search_restaurant_state.dart';

import 'mock_api.dart';

void main() {
  late SearchRestaurantProvider provider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    provider = SearchRestaurantProvider(mockApiService);
  });

  group("Search restaurant", () {
    test("Memastikan state awal provider harus didefinisikan", () {
      expect(provider.resultState, isA<SearchRestaurantNoneState>());
    });

    test(
      "Memastikan dapat mengembalikan hasil search ketika pengembalian data api berhasil",
      () async {
        // arrange
        final fakeResponse = SearchRestaurantResponse(
          error: false,
          founded: 1,
          restaurants: [
            Restaurant(
              id: "rqdv5juczeskfw1e867",
              name: "Melting Pot",
              description:
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
              pictureId: "14",
              city: "Gorontalo",
              rating: 4,
            ),
          ],
        );
        when(
          () => mockApiService.searchRestaurants("Melting"),
        ).thenAnswer((_) async => fakeResponse);

        // act
        await provider.searchRestaurants("Melting");

        // assert
        expect(provider.resultState, isA<SearchRestaurantLoadedState>());
        final state = provider.resultState as SearchRestaurantLoadedState;
        expect(state.data.length, 1);
      },
    );

    test(
      "Memastikan mengembalikan empty list ketika item tidak ditemukan",
      () async {
        final fakeResponse = SearchRestaurantResponse(
          error: false,
          founded: 0,
          restaurants: [],
        );
        when(
          () => mockApiService.searchRestaurants("bandung"),
        ).thenAnswer((_) async => fakeResponse);

        // act
        await provider.searchRestaurants("bandung");

        // assert
        expect(provider.resultState, isA<SearchRestaurantLoadedState>());
        final state = provider.resultState as SearchRestaurantLoadedState;
        expect(state.data.length, 0);
      },
    );

    test(
      "Memastikan harus mengembalikan kesalahan ketika terdapat exception",
      () async {
        // arrange
        when(
          () => mockApiService.searchRestaurants("Melting"),
        ).thenThrow(SocketException("Tidak ada koneksi internet."));

        // act
        await provider.searchRestaurants("Melting");

        // assert
        expect(provider.resultState, isA<SearchRestaurantErrorState>());
        final state = provider.resultState as SearchRestaurantErrorState;
        expect(state.error, Helper.errInet);
      },
    );
  });
}
