import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/repository/distributor_repository.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/repository/vendor_repository.dart';
import 'package:oogie/repository/wholesale_repository.dart';
import 'package:oogie/screens/common/authentication/authentication/session_cubit.dart';
import 'package:oogie/screens/common/authentication/authentication/splash_screen.dart';
import 'package:oogie/screens/common/authentication/login/login_bloc.dart';
import 'package:oogie/screens/common/authentication/login/login_view.dart';
import 'package:oogie/screens/common/authentication/otp_login/otp_login_bloc.dart';
import 'package:oogie/screens/common/authentication/otp_login/otp_login_view.dart';
import 'package:oogie/screens/common/authentication/reset_password/reset_password_bloc.dart';
import 'package:oogie/screens/common/authentication/reset_password/reset_password_view.dart';
import 'package:oogie/screens/common/authentication/sign_up/sign_up_bloc.dart';
import 'package:oogie/screens/common/authentication/sign_up/sign_up_view.dart';
import 'package:oogie/screens/common/order_details/order_details_cubit.dart';
import 'package:oogie/screens/common/order_details/order_details_view.dart';
import 'package:oogie/screens/common/original_order/orginal_order_cubit.dart';
import 'package:oogie/screens/common/original_order/orginal_order_view.dart';
import 'package:oogie/screens/common/products/add_product/add_product_bloc.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_0.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_1.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_4.dart';
import 'package:oogie/screens/delivery_partner/delivery_partner_home/delivery_partner_home_bloc.dart';
import 'package:oogie/screens/delivery_partner/delivery_partner_home/delivery_partner_home_view.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_bloc.dart';
import 'package:oogie/screens/distributor/distributor_home/distributor_home_bloc.dart';
import 'package:oogie/screens/distributor/distributor_home/distributor_home_view.dart';
import 'package:oogie/screens/explore/explore/explore_bloc.dart';
import 'package:oogie/screens/explore/explore/explore_view.dart';
import 'package:oogie/screens/common/products/product/product_bloc.dart';
import 'package:oogie/screens/common/products/product/product_view.dart';
import 'package:oogie/screens/common/products/product_filter/product_filter_bloc.dart';
import 'package:oogie/screens/common/products/product_filter/product_filter_view.dart';
import 'package:oogie/screens/common/products/product_list/product_list_bloc.dart';
import 'package:oogie/screens/common/products/product_list/product_list_view.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_bloc.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_view.dart';
import 'package:oogie/screens/user/orders/my_orders/my_orders_cubit.dart';
import 'package:oogie/screens/user/orders/my_orders/my_orders_view.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_bloc.dart';
import 'package:oogie/screens/profile/address/address_list/address_list_view.dart';
import 'package:oogie/screens/profile/my_location/my_location_bloc.dart';
import 'package:oogie/screens/profile/my_location/my_location_view.dart';
import 'package:oogie/screens/profile/profile/profile_bloc.dart';
import 'package:oogie/screens/profile/profile/profile_view.dart';
import 'package:oogie/screens/shopping/cart/cart_bloc.dart';
import 'package:oogie/screens/shopping/cart/cart_view.dart';
import 'package:oogie/screens/shopping/checkout/checkout_bloc.dart';
import 'package:oogie/screens/shopping/checkout/checkout_shipping_view.dart';
import 'package:oogie/screens/user/used_phones/used_phone_home/used_phone_home_bloc.dart';
import 'package:oogie/screens/user/used_phones/used_phone_home/used_phone_home_view.dart';
import 'package:oogie/screens/vendor/vendor_home/vendor_home_bloc.dart';
import 'package:oogie/screens/vendor/vendor_home/vendor_home_view.dart';
import 'package:oogie/screens/vendor_old/add_product.dart';
import 'package:oogie/screens/wishlist/wishlist_bloc.dart';
import 'package:oogie/screens/wishlist/wishlist_view.dart';

AuthRepository authRepository = AuthRepository();
ProfileRepository profileRepository = ProfileRepository();
ProductRepository productRepository = ProductRepository();
OrderRepository orderRepository = OrderRepository();
DistributorRepository distributorRepository = DistributorRepository();
VendorRepository vendorRepository = VendorRepository();
WholeSaleRepository wholeSaleRepository = WholeSaleRepository();

CartBloc cartBloc = CartBloc(
  productRepository: productRepository,
);

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    // final GlobalKey<ScaffoldState> key = settings.arguments;
    Map arguments = settings.arguments;

    switch (settings.name) {
      //auth
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SessionCubit(authRepository: authRepository),
            child: SplashScreen(),
          ),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(authRepo: authRepository),
            child: LoginView(),
          ),
        );

      case '/otpLogin':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OTPLoginBloc(authRepo: authRepository),
            child: OTPLoginView(),
          ),
        );

      case '/signUp':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpBloc(authRepo: authRepository),
            child: SignUpView(),
          ),
        );

      case '/myLocation':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                MyLocationBloc(profileRepository: profileRepository),
            child: MyLocationView(),
          ),
        );

      case '/profile':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                ProfileBloc(profileRepository: profileRepository),
            child: ProfileView(),
          ),
        );
      case '/resetPassword':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ResetPasswordBloc(authRepo: authRepository),
            child: ResetPasswordView(),
          ),
        );

      //home
      case '/explore':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                ExploreBloc(productRepository: productRepository),
            child: ExploreView(),
          ),
        );
      case '/home':
        if (FlavorConfig().flavorName == 'distributor' ||
            FlavorConfig().flavorName == 'sales_executive') {
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => DistributorHomeBloc(),
                      ),
                      BlocProvider(
                        create: (context) => ConnectionAgentsListBloc(
                            distributorRepository: distributorRepository,
                            parentPage: 'homePage'),
                      ),
                    ],
                    child: DistributorHomeView(),
                  ));
        }
        if (FlavorConfig().flavorName == 'vendor' ||
            FlavorConfig().flavorName == 'wholesale_dealer') {
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => VendorHomeBloc(),
                      ),
                    ],
                    child: VendorHomeView(),
                  ));
        }if (FlavorConfig().flavorName == 'delivery_partner') {
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => DeliveryPartnerHomeBloc(),
                      ),
                    ],
                    child: DeliveryPartnerHomeView(),
                  ));
        }
        if(FlavorConfig().flavorName=='user'){
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => UsedPhoneHomeBloc(),
                  ),
                ],
                child: UsedPhoneHomeView(),
              ));
        }
        return null;

      case '/productList':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProductListBloc(
                productRepository: productRepository,
                parentPage: arguments['parentPage'].toString()),
            child: ProductListView(),
          ),
        );
      case '/product':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProductBloc(
                productId: arguments['id'].toString(),
                productRepository: productRepository,
                parentPage: arguments['parentPage'].toString()),
            child: ProductView(),
          ),
        );
      case '/productFilter':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProductFilterBloc(
                parentCategoryId: arguments['categoryId'] != null
                    ? arguments['categoryId']
                    : null, parentAdvertisementId: arguments['parentAdvertisementId'] != null
                    ? arguments['parentAdvertisementId']
                    : null,
                productRepository: productRepository,
                parentPage: arguments['parentPage'].toString()),
            child: ProductFilterView(),
          ),
        );
      case '/reviewList':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ReviewListBloc(
              productId: arguments['id'].toString(),
              productRepository: productRepository,
            ),
            child: ReviewListView(),
          ),
        );
      case '/cart':
        if (AppData().isUser) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => cartBloc,
              child: CartView(),
            ),
          );
        }
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginBloc(authRepo: authRepository),
                  child: LoginView(),
                ));

      case '/wishlist':
        if (AppData().isUser) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => WishlistBloc(
                productRepository: productRepository,
              ),
              child: WishlistView(),
            ),
          );
        }
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginBloc(authRepo: authRepository),
                  child: LoginView(),
                ));
      case '/addressList':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddressListBloc(
                parentPage: arguments['parentPage'].toString(),
                profileRepository: profileRepository,
                checkoutBloc: arguments['checkoutBloc']),
            child: AddressListView(),
          ),
        );
      case '/myOrders':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MyOrdersCubit(
                parentPage: arguments['parentPage'].toString(),
                orderRepository: orderRepository),
            child: MyOrdersView(),
          ),
        );
      case '/checkout':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CheckoutBloc(
              parentPage: arguments['parentPage'].toString(),
              productIds: arguments['productIds'],
              profileRepository: profileRepository,
              orderRepository: orderRepository,
              productRepository: productRepository,
            ),
            child: CheckoutShippingView(),
          ),
        );
        case '/orderDetails':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OrderDetailsCubit(
              parentPage: arguments['parentPage'].toString(),
              deliveryOrderId: arguments['deliveryOrderId'].toString(),
              orderRepository: orderRepository,
            ),
            child: OrderDetailsView(),
          ),
        );case '/originalOrder':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OriginalOrderCubit(
              parentPage: arguments['parentPage'].toString(),
              orderId: arguments['orderId'].toString(),
              orderRepository: orderRepository,
            ),
            child: OriginalOrderView(),
          ),
        );

      default:
        return null;
    }
  }
}
