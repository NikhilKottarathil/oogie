import 'package:oogie/models/attribute_model.dart';

class CategoryModel {
  String id, name, imageUrl;
  bool isSelected;
  List<CategoryModel> subCategories;
  List<AttributeModel> attributeModels;

  CategoryModel({this.name, this.id, this.imageUrl,this.isSelected,this.subCategories,this.attributeModels});
}
