import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tourism_app/data/model/restaurant.dart';
import 'package:tourism_app/data/model/restaurant_list_response.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
import 'package:tourism_app/static/helper.dart';
import 'package:tourism_app/static/restaurant_list_result_state.dart';

import 'mock_api.dart';

void main() {
  late RestaurantListProvider provider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(mockApiService);
  });

  group("restaurant list", () {
    test("Memastikan state awal provider harus didefinisikan", () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test(
      "Memastikan harus mengembalikan daftar restoran ketika pengambilan data API berhasil",
      () async {
        // arrange
        final fakeResponse = RestaurantListResponse(
          error: false,
          message: "success",
          count: 1,
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
          () => mockApiService.getRestaurantList(),
        ).thenAnswer((_) async => fakeResponse);

        // act
        await provider.fetchRestaurantList();

        // assert
        expect(provider.resultState, isA<RestaurantListLoadedState>());
        final state = provider.resultState as RestaurantListLoadedState;
        expect(state.data.length, 1);
        expect(state.data.first.name, "Melting Pot");
      },
    );

    test(
      "Memastikan harus mengembalikan kesalahan ketika pengambilan data API gagal",
      () async {
        // arrange
        final fakeResponse = RestaurantListResponse(
          error: true,
          message: "fail",
          count: 0,
          restaurants: [],
        );
        when(
          () => mockApiService.getRestaurantList(),
        ).thenAnswer((_) async => fakeResponse);

        // act
        await provider.fetchRestaurantList();

        // assert
        expect(provider.resultState, isA<RestaurantListErrorState>());
        final state = provider.resultState as RestaurantListErrorState;
        expect(state.error, "fail");
      },
    );

    test(
      "Memastikan harus mengembalikan kesalahan ketika terdapat exception",
      () async {
        // arrange
        when(
          () => mockApiService.getRestaurantList(),
        ).thenThrow(SocketException("Tidak ada koneksi internet."));

        // act
        await provider.fetchRestaurantList();

        // assert
        expect(provider.resultState, isA<RestaurantListErrorState>());
        final state = provider.resultState as RestaurantListErrorState;
        expect(state.error, Helper.errInet);
      },
    );
  });
  
}
