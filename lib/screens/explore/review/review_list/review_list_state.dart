
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/models/review_model.dart';

class ReviewListState {
  List<ReviewModel> reviewModels=[];
  PageScrollStatus pageScrollStatus;
  int page;
  List<String> reviewIDs=[];
  bool isLoading;
  String parentPage;
  Exception actionErrorMessage;

  ReviewListState({
    this.reviewModels,
    this.pageScrollStatus=const InitialScrollStatus(),
    this.reviewIDs,
    this.page=1,
    this.parentPage,
    this.actionErrorMessage,
    this.isLoading=false
  });

  ReviewListState copyWith({
    var reviewModels,
    var reviewIDs,
    bool isLoading,
    String parentPage,
    Exception actionErrorMessage,
    PageScrollStatus pageScrollStatus,
    int page,
  }) {
    return ReviewListState(
      reviewModels: reviewModels ?? this.reviewModels,
      reviewIDs: reviewIDs ?? this.reviewIDs,
      pageScrollStatus: pageScrollStatus ?? this.pageScrollStatus,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      parentPage: parentPage ?? this.parentPage,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
    );
  }
}
