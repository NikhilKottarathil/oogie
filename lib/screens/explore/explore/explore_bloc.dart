import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/advertisement_model.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/explore/explore/explore_event.dart';
import 'package:oogie/screens/explore/explore/explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ProductRepository productRepository;
  var imageAspectRatio;

  ExploreBloc({this.productRepository})
      : super(ExploreState(
            newArrivedProductModels: [],
            categoryModels: [],
            advertisementModels: [],
            featuredProductModels: [],
            messageCount: 0,
            itemsInCartCount: 0,
            notificationCount: 0)) {
    getInitialData();
    getAdvertisements();
    print('FlavorConfig().appTitle');
    print(FlavorConfig().flavorName);
  }

  Future getInitialData() async {
    await productRepository.setCategories();
    var categoryModels = await productRepository.getCategories();
    var newArrivedProductModels = await productRepository.getProductsByFilter(
        sort: 'newest_first', page: 1, rowsPerPage: 4);
    var featuredProductModels = await productRepository.getProductsByFilter(
        sort: 'featured_product', page: 1, rowsPerPage: 4);

    add(CategoriesUpdated(categoryModels: categoryModels));
    add(NewArrivedProductUpdated(
        newArrivedProductModels: newArrivedProductModels));
    add(FeaturedProductUpdated(featuredProductModels: featuredProductModels));
  }

  Future getAdvertisements() async {
    List<AdvertisementModel> advertisementModels =
        await productRepository.getAdvertisements();

    add(AdvertisementUpdated(advertisementModels: advertisementModels));
  }

  @override
  Stream<ExploreState> mapEventToState(ExploreEvent event) async* {
    // Phone Number updated
    if (event is CategoriesUpdated) {
      yield state.copyWith(categoryModels: event.categoryModels);
    } else if (event is AdvertisementUpdated) {
      yield state.copyWith(advertisementModels: event.advertisementModels);
    } else if (event is FeaturedProductUpdated) {
      yield state.copyWith(featuredProductModels: event.featuredProductModels);
    } else if (event is NewArrivedProductUpdated) {
      yield state.copyWith(
          newArrivedProductModels: event.newArrivedProductModels);
    }
  }
}
