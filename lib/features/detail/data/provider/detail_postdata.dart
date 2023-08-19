import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostData {
  int isLikedCheck = 0;
  int participationStatus = 0;
  int isLikedCount = 0;

  PostData({
    required this.isLikedCheck,
    required this.participationStatus,
    required this.isLikedCount,
  });
  void setAll(int islike, int isLikeCount, int participationStatus) {
    setIsLikedCheck(islike);
    setIsLikedCount(isLikeCount);
    setParticipationStatus(participationStatus);
  }

  // Setter methods
  void setIsLikedCheck(int value) {
    isLikedCheck = value;
  }

  void setParticipationStatus(int value) {
    participationStatus = value;
  }

  void setIsLikedCount(int value) {
    isLikedCount = value;
  }
}

class PostDataNotifier extends StateNotifier<PostData> {
  PostDataNotifier()
      : super(
            PostData(isLikedCheck: 0, participationStatus: 0, isLikedCount: 0));

  void setState(isLikedCheck, participationStatus, isLikedCount) {
    state = PostData(
      isLikedCheck: isLikedCheck,
      participationStatus: participationStatus,
      isLikedCount: isLikedCount,
    );
  }

  // Toggle isLikedCheck
  void toggleIsLiked() {
    state = PostData(
      isLikedCheck: state.isLikedCheck == 0 ? 1 : 0,
      participationStatus: state.participationStatus,
      isLikedCount: state.isLikedCount,
    );
  }

  void increaseCount() {
    state = PostData(
        isLikedCheck: state.isLikedCheck,
        participationStatus: state.participationStatus,
        isLikedCount: state.isLikedCount + 1);
  }

  void decreaseCount() {
    state = PostData(
        isLikedCheck: state.isLikedCheck,
        participationStatus: state.participationStatus,
        isLikedCount: state.isLikedCount - 1);
  }
}
