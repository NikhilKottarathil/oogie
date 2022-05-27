import 'package:oogie/models/shop_model.dart';

abstract class SelectShopEvent {}

class SearchShopChanged extends SelectShopEvent {
  final String searchString;

  SearchShopChanged({this.searchString});
}

class ShopsUpdated extends SelectShopEvent {
  final List<ShopModel> shopModels;

  ShopsUpdated({this.shopModels});
}

class ShopSelected extends SelectShopEvent {
  ShopModel shop;
  bool isUsedPhonesSelected;

  ShopSelected({this.shop,this.isUsedPhonesSelected});
}
class ShopSelectedSubmitted extends SelectShopEvent {
  ShopModel shop;
  bool isUsedPhonesSelected;

  ShopSelectedSubmitted({this.shop,this.isUsedPhonesSelected});
}
