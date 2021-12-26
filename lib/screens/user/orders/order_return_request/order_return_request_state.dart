

import 'dart:io';

import 'package:oogie/components/radio_buttons.dart';

abstract class OrderReturnRequestState {}
class InitialState extends OrderReturnRequestState {}
class LoadingState extends OrderReturnRequestState {}
class SubmissionSuccess extends OrderReturnRequestState {}
class ErrorMessageState extends OrderReturnRequestState {
  Exception e;
  ErrorMessageState({this.e});
}class BankNameChanged extends OrderReturnRequestState {
  String value;
  BankNameChanged({this.value});
}class AccountNumberChanged extends OrderReturnRequestState {
  String value;
  AccountNumberChanged({this.value});
}class VerifyAccountNumberChanged extends OrderReturnRequestState {
  String value;
  VerifyAccountNumberChanged({this.value});
}class IFSCChanged extends OrderReturnRequestState {
  String value;
  IFSCChanged({this.value});
}class AccountHolderNameChanged extends OrderReturnRequestState {
  String value;
  AccountHolderNameChanged({this.value});
}class BankBranchChanged extends OrderReturnRequestState {
  String value;
  BankBranchChanged({this.value});
}

class LoadPhotos extends OrderReturnRequestState {
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
class LoadReasons extends OrderReturnRequestState {
  final List<RadioModel> models;

  LoadReasons({this.models});

  LoadReasons copyWith({
    List<RadioModel> messageModels,
  }) {
    return LoadReasons(
      models: models ?? this.models,
    );
  }

  List<Object> get props => [models];
}

