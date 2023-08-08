import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malf_application/features/detail/data/network.dart';

import './data_model_meeting_detail.dart';

part 'detail_data_provider.freezed.dart';

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
      : super(JsonDataState(jsonData: JsonData(status: "", data: []))) {
    loadJsonData();
  }

  void loadJsonData() async {
    state = state.copyWith(isLoading: true);
    final jsonDataResponse = await Network(postId: "7").request();
    final jsonData = jsonDataFromJson(jsonDataResponse);
    state = state.copyWith(isLoading: false, jsonData: jsonData);
  }
}

final jsonDataProvider = StateNotifierProvider<JsonDataNotifier, JsonDataState>(
    (ref) => JsonDataNotifier());
