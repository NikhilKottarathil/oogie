import 'package:oogie/models/review_model.dart';

class ReviewListEvent {}

class FetchInitialData extends ReviewListEvent {}

class UpdatedList extends ReviewListEvent {
  List<ReviewModel> reviewModel;

  UpdatedList({this.reviewModel});
}

class RefreshList extends ReviewListEvent {}

class FetchMoreData extends ReviewListEvent {}

class LikeAndUnLikeFeed extends ReviewListEvent {
  int index;

  LikeAndUnLikeFeed({this.index});
}
