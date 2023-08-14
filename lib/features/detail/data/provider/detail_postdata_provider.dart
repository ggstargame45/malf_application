import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_postdata_provider.freezed.dart';
part 'detail_postdata_provider.g.dart';

@unfreezed
class PostData with _$PostData {
  factory PostData({
    required int isLikeCheck,
    required int isLikeCount,
    required final String userName,
  }) = _PostData;

  factory PostData.fromJson(Map<String, Object?> json) =>
      _$PostDataFromJson(json);
}
