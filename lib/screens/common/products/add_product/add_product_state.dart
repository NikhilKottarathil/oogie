import 'dart:io';

import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/models/review_model.dart';

class AddProductState {
  String name, unitPrice, description, qtyAvailable;

  bool isUsedProduct, isLoading;
  Exception actionErrorMessage;
  List<KeyValueRadioModel> brands;
  List<KeyValueRadioModel> models;
  List<CategoryModel> categories;
  List<KeyValueRadioModel> unitMeasures;
  List<AttributeModel> attributes;
  List<SpecificationModel> specificationModels;
  List<String> highlights;
  FormSubmissionStatus formSubmissionStatus;
  List<File> images;

  AddProductState(
      {this.name,
      this.models,
      this.isLoading,
      this.actionErrorMessage,
      this.attributes,
      this.brands,
      this.categories,
      this.description,
      this.highlights,
      this.isUsedProduct,
      this.qtyAvailable,
      this.specificationModels,
      this.unitMeasures,
      this.unitPrice,
        this.images,
      this.formSubmissionStatus = const InitialFormStatus()});

  AddProductState copyWith(
      {String name,
      unitPrice,
      description,
      qtyAvailable,
      bool isUsedProduct,
      bool isLoading,
      Exception actionErrorMessage,
      List<KeyValueRadioModel> brands,
      List<KeyValueRadioModel> models,
      List<CategoryModel> categories,
      List<KeyValueRadioModel> unitMeasures,
      List<AttributeModel> attributes,
      List<Map<String, Map<String, String>>> specificationModels,
      List<String> highlights,
        List<File> images,
      FormSubmissionStatus formSubmissionStatus}) {
    return AddProductState(
      name: name ?? this.name,
      unitPrice: unitPrice ?? this.unitPrice,
      description: description ?? this.description,
      isUsedProduct: isUsedProduct ?? this.isUsedProduct,
      isLoading: isLoading ?? this.isLoading,
      qtyAvailable: qtyAvailable ?? this.qtyAvailable,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
      brands: brands ?? this.brands,
      attributes: attributes ?? this.attributes,
      models: models ?? this.models,
      categories: categories ?? this.categories,
      unitMeasures: unitMeasures ?? this.unitMeasures,
      specificationModels: specificationModels ?? this.specificationModels,
      highlights: highlights ?? this.highlights,
      images: images ?? this.images,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
}
