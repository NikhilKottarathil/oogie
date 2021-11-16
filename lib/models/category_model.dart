class CategoryModel {
  String id, name, imageUrl;
  bool isSelected;
  List<CategoryModel> subCategories;

  CategoryModel({this.name, this.id, this.imageUrl,this.isSelected,this.subCategories});
}
