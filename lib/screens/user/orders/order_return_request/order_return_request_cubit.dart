import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/select_image.dart';
import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/screens/common/order_details/order_details_cubit.dart';
import 'package:oogie/screens/user/orders/order_return_request/order_return_request_state.dart';

class OrderReturnRequestCubit extends Cubit<OrderReturnRequestState> {
  OrderRepository orderRepository;
  String parentPage;
  OrderDetailsCubit orderDetailsCubit;
  DeliveryOrderModel deliveryOrderModel;
  int productIndex;

  List<RadioModel> reasons = defaultOrderStatuses;
  List<File> photos = [];
  String ifsc = '',
      bankName = '',
      branch = '',
      accountNumber = '',
      verifyAccountNumber = '',
      accountHolderName = '';

  OrderReturnRequestCubit(
      {@required this.orderRepository,
      this.parentPage,
      this.orderDetailsCubit,
      this.deliveryOrderModel,
      this.productIndex})
      : super(InitialState()) {
    emit(InitialState());

    // if (orderDetailsCubit != null) {
    //
    //   print(orderDetailsCubit.parentPage);
    //   print(orderDetailsCubit.deliveryOrderId);
    //    orderDetailsCubit.getInitialData();
    //   print('orderDetailsCubit not null');
    //
    //   emit(SubmissionSuccess());
    // } else {
    //   print('orderDetailsCubit null');
    //
    //   emit(SubmissionSuccess());
    // }
    emit(InitialState());
    emit(LoadReasons(models: reasons));

  }

  reasonSelected(String value) {
    reasons.forEach((element) {
      element.isSelected = false;
      if (element.text == value) {
        element.isSelected = true;
      }
    });
    emit(LoadReasons(models: reasons));
  }

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

  returnSubmitted() async {
    if (reasons.singleWhere((element) => element.isSelected).text ==
        'Select a reason') {
      emit(ErrorMessageState(e: Exception('Please select reason')));
    } else if (photos.isEmpty) {
      emit(ErrorMessageState(e: Exception('Please upload product photos')));
    } else {
      try {
        String reason = reasons
            .singleWhere((element) => element.isSelected)
            .text
            .toString();

        await orderRepository.requestOrderReturn(
            files: photos,
            accountNumber: accountNumber,
            bankName: bankName,
            branch: branch,
            ifsc: ifsc,
            deliveryOrderId: deliveryOrderModel.id.toString(),
            reason: reason);
        print('orderDetailsCubit');
        if (orderDetailsCubit != null) {
          await orderDetailsCubit.getInitialData();
          print('orderDetailsCubit not null');

          emit(SubmissionSuccess());
        } else {
          print('orderDetailsCubit null');

          emit(SubmissionSuccess());
        }
      } catch (e) {
        emit(ErrorMessageState(e: e));
      }
    }
  }

  bankNameChanged(String value) {
    bankName = value;
    emit(BankNameChanged(value: value));
  }

  accountNumberChanged(String value) {
    accountNumber = value;
    emit(AccountNumberChanged(value: value));
  }

  verifyAccountNumberChanged(String value) {
    verifyAccountNumber = value;
    emit(VerifyAccountNumberChanged(value: value));
  }

  String get validateAccountNumberText {
    return verifyAccountNumber.toString().trim() ==
            accountNumber.toString().trim()
        ? null
        : 'account number does not match';
  }

  ifscChanged(String value) {
    emit(IFSCChanged(value: value));
  }

  bankBranchChanged(String value) {
    emit(BankBranchChanged(value: value));
  }

  accountHolderNameChanged(String value) {
    emit(AccountHolderNameChanged(value: value));
  }
}

List<RadioModel> defaultOrderStatuses = [
  RadioModel(true, 'Select a reason'),
  RadioModel(false, 'Wrong Product'),
  RadioModel(false, 'Damaged'),
  RadioModel(false, 'Other'),
];
