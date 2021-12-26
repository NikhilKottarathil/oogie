import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:oogie/functions/select_image.dart';
import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/screens/common/order_details/order_details_cubit.dart';
import 'package:oogie/screens/explore/review/add_review/add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  OrderRepository orderRepository;
  String parentPage;
  OrderDetailsCubit orderDetailsCubit;
  DeliveryOrderModel deliveryOrderModel;
  int productIndex;

  List<File> photos = [];
  String review = '';
  String rating = '';

  AddReviewCubit(
      {@required this.orderRepository,
      this.parentPage,
      this.orderDetailsCubit,
      this.deliveryOrderModel,
      this.productIndex})
      : super(InitialState());

  addPhotos(BuildContext context, index) async {
    try {
      File file;
      file = await selectImage(imageFile: file, context: context);
      if (index != -1) {
        photos[index] = file;
      } else {
        photos.add(file);
      }
      emit(LoadPhotos(models: photos));
    } catch (e) {
      emit(ErrorMessageState(e: Exception('Failed')));
    }
  }

  submitButtonPressed() async {
    // if (photos.isEmpty) {
    //   emit(ErrorMessageState(e: Exception('Please upload product photos')));
    // } else {
    emit(LoadingState());
    try {
      await orderRepository.addReview(
        productId: deliveryOrderModel.products[productIndex].id,
        deliveryOrderId: deliveryOrderModel.id.toString(),
        rating: rating.toString(),
        review: review,
      );
      if (orderDetailsCubit != null) {
        await orderDetailsCubit.getInitialData();

        emit(SubmissionSuccess());
      } else {
        emit(SubmissionSuccess());
      }
    } catch (e) {
      emit(ErrorMessageState(e: e));
    }
  }

  reviewChanged(String value) {
    review = value;
    emit(ReviewChanged(value: value));
  }

  ratingChanged(String value) {
    rating = value;
    emit(ReviewChanged(value: value));
  }
}
