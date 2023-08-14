import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/features/detail/data/network/network.dart';

import '../model/json_data_model.dart';

part '../model/detail_data_provider.freezed.dart';

@freezed
class JsonDataState with _$JsonDataState {
  const factory JsonDataState({
    @Default(true) bool isLoading,
    required JsonData jsonData,
  }) = _JsonDataState;

  const JsonDataState._();
}

class JsonDataNotifier extends StateNotifier<JsonDataState> {
  JsonDataNotifier()
      : super(
            JsonDataState(jsonData: JsonData(status: 0, data: List.empty()))) {
    loadJsonData();
  }

  void loadJsonData() async {
    state = state.copyWith(isLoading: true);
    final jsonDataResponse = await Network(postId: "20").request();
    final jsonData = JsonData.fromJson(jsonDataResponse);
    Logger().d(jsonData);
    state = state.copyWith(isLoading: false, jsonData: jsonData);
  }
}

final jsonDataProvider = StateNotifierProvider<JsonDataNotifier, JsonDataState>(
    (ref) => JsonDataNotifier());
