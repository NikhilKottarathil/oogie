import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_event.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_state.dart';

class ReviewListBloc extends Bloc<ReviewListEvent, ReviewListState> {
  ProductRepository productRepository;
  String productId;

  ReviewListBloc({@required this.productRepository, @required this.productId})
      : super(ReviewListState(reviewModels: [], reviewIDs: [])) {
    print('inside list');
    getInitialReviews();
  }

  getInitialReviews() async {
    state.reviewModels.clear();
    state.reviewIDs.clear();
    state.page = 1;
    var reviewModels =
        await productRepository.getProductReviews(state.page, 10, productId);
    add(UpdatedList(reviewModel: reviewModels));
  }

  getMoreReviews() async {
    state.page = state.page + 1;
    var reviewModels =
        await productRepository.getProductReviews(state.page, 10, productId);
    add(UpdatedList(reviewModel: reviewModels));
  }

  @override
  Stream<ReviewListState> mapEventToState(ReviewListEvent event) async* {
    if (event is FetchInitialData) {
      yield state.copyWith(isLoading: true);
      await getInitialReviews();
    } else if (event is FetchMoreData) {
      yield state.copyWith(isLoading: true);
      await getMoreReviews();
    } else if (event is UpdatedList) {
      state.reviewModels.addAll(event.reviewModel);
      yield state.copyWith(isLoading: false);
    }
  }
}
