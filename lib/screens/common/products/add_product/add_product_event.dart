import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/models/review_model.dart';

class AddProductEvent {
  const AddProductEvent();
}

class BaseDataUpdated extends AddProductEvent {
  List<KeyValueRadioModel> brands;
  List<KeyValueRadioModel> models;
  List<CategoryModel> categories;
  List<KeyValueRadioModel> unitMeasures;
  List<AttributeModel> attributes;

  BaseDataUpdated({
    this.brands,
    this.models,
    this.categories,
    this.unitMeasures,
    this.attributes,

  });
}

class SelectMedia extends AddProductEvent {
  BuildContext context;
  SelectMedia({this.context});
}


class CategorySelected extends AddProductEvent {
  int index;

  CategorySelected({this.index});
}

class SubCategorySelected extends AddProductEvent {
  int categoryIndex;
  int subCategoryIndex;

  SubCategorySelected({this.categoryIndex, this.subCategoryIndex});
}

class BrandSelected extends AddProductEvent {
  int index;

  BrandSelected({this.index});
}

class ModelSelected extends AddProductEvent {
  int index;

  ModelSelected({this.index});
}

class UnitOfMeasureSelected extends AddProductEvent {
  int index;

  UnitOfMeasureSelected({this.index});
}

class NameChanged extends AddProductEvent {
  String value;

  NameChanged({this.value});
}

class UnitPriceChanged extends AddProductEvent {
  String value;

  UnitPriceChanged({this.value});
}
class OfferPriceChanged extends AddProductEvent {
  String value;

  OfferPriceChanged({this.value});
}

class DescriptionChanged extends AddProductEvent {
  String value;

  DescriptionChanged({this.value});
}

class QuantityAvailableChanged extends AddProductEvent {
  String value;

  QuantityAvailableChanged({this.value});
}

class AttributeSelected extends AddProductEvent {
  String value;
  int index;

  AttributeSelected({this.value, this.index});
}
class AddNewSpecification extends AddProductEvent {

SpecificationModel specificationModel;
SubSpecificationModel subSpecificationModel;
int index;
  AddNewSpecification({this.specificationModel,this.index,this.subSpecificationModel});
}
class DeleteSpecification extends AddProductEvent {

int index;
DeleteSpecification({this.index});
}
class DeleteSubSpecification extends AddProductEvent {

int index,subIndex;
DeleteSubSpecification({this.index,this.subIndex});
}
class HighLightChanged extends AddProductEvent {

int index;
String value;
HighLightChanged({this.index,this.value});
}class AddHighLight extends AddProductEvent {

}
class DeleteHighLight extends AddProductEvent {
  int index;
  DeleteHighLight({this.index});
}class AddProductSubmitted extends AddProductEvent {
}
