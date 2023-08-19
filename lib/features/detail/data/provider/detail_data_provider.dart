import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malf_application/features/detail/data/network/network.dart';

import '../models/json_data_model.dart';

part '../models/detail_data_provider.freezed.dart';

@freezed
class JsonDataState with _$JsonDataState {
  const factory JsonDataState({
    @Default(true) bool isLoading,
    required JsonData jsonData,
  }) = _JsonDataState;

  const JsonDataState._();
}

// class JsonDataNotifier extends StateNotifier<JsonDataState> {
//   JsonDataNotifier()
//       : super(
//             JsonDataState(jsonData: JsonData(status: 0, data: List.empty()))) {
//     loadJsonData();
//   }

//   void loadJsonData() async {
//     state = state.copyWith(isLoading: true);
//     final jsonDataResponse = await Network(postId: 20).request();
//     final jsonData = JsonData.fromJson(jsonDataResponse);
//     Logger().d(jsonData);
//     state = state.copyWith(isLoading: false, jsonData: jsonData);
//   }
// }

// final jsonDataProvider = StateNotifierProvider<JsonDataNotifier, JsonDataState>(
//     (ref) => JsonDataNotifier());

final jsonDataProvider =
    FutureProvider.family<JsonDataState, int>((ref, postId) async {
  final jsonDataResponse = await Network(postId: postId).request();
  final jsonData = JsonData.fromJson(jsonDataResponse);
  try {
    return JsonDataState(jsonData: jsonData, isLoading: false);
  } catch (e) {
    throw Exception(e.toString());
  }
});

// @riverpod
// class JsonDataNotifier extends _$JsonDataNotifier {
//   @override
//   Future<JsonDataState> build() async {
//     return JsonDataState(jsonData: JsonData(status: 0, data: List.empty()));
//   }

//   void loadJsonData(int postId) async {
//     final jsonDataResponse = await Network(postId: "22").request();
//     final jsonData = JsonData.fromJson(jsonDataResponse);
//     state = JsonDataState(isLoading: false, jsonData: jsonData)
//         as AsyncValue<JsonDataState>;
//   }
// }

// @riverpod
// FutureOr<JsonDataState> jsonDataNotifier(Ref ref, int postId) async {
//   final jsonDataResponse = await Network(postId: postId.toString()).request();
//   final jsonData = JsonData.fromJson(jsonDataResponse);
//   return JsonDataState(isLoading: false, jsonData: jsonData);
// }

// class JsonDataNotifier extends StateNotifier<JsonDataState> {
//   JsonDataNotifier(int postId)
//       : super(
//             JsonDataState(jsonData: JsonData(status: 0, data: List.empty()))) {
//     loadJsonData(postId);
//   }

//   void loadJsonData(int postId) async {
//     state = state.copyWith(isLoading: true);
//     final jsonDataResponse = await Network(postId: "22").request();
//     final jsonData = JsonData.fromJson(jsonDataResponse);
//     Logger().d(jsonData);
//     state = state.copyWith(isLoading: false, jsonData: jsonData);
//   }
// }

// StateNotifierProvider<JsonDataNotifier, JsonDataState> jsonDataProvider(
//         int postId) =>
//     StateNotifierProvider<JsonDataNotifier, JsonDataState>(
//         (ref) => JsonDataNotifier(postId));
