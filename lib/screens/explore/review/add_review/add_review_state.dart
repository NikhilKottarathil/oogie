import 'dart:io';

import 'package:oogie/components/radio_buttons.dart';

abstract class AddReviewState {}

class InitialState extends AddReviewState {}

class LoadingState extends AddReviewState {}

class SubmissionSuccess extends AddReviewState {}

class ErrorMessageState extends AddReviewState {
  Exception e;

  ErrorMessageState({this.e});
}

class ReviewChanged extends AddReviewState {
  String value;

  ReviewChanged({this.value});
}

class LoadPhotos extends AddReviewState {
  final List<File> models;

  LoadPhotos({this.models});

  LoadPhotos copyWith({
    List<File> messageModels,
  }) {
    return LoadPhotos(
      models: models ?? this.models,
    );
  }

  List<Object> get props => [models];
}

class RatingChanged extends AddReviewState {
  double rating;

  RatingChanged({this.rating});
}
