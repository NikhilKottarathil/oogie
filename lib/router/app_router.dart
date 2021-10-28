import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/repository/order_repository.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/authentication//reset_password/reset_password_bloc.dart';
import 'package:oogie/screens/authentication/authentication/session_cubit.dart';
import 'package:oogie/screens/authentication/authentication/splash_screen.dart';
import 'package:oogie/screens/authentication/login/login_bloc.dart';
import 'package:oogie/screens/authentication/login/login_view.dart';
import 'package:oogie/screens/authentication/otp_login/otp_login_bloc.dart';
import 'package:oogie/screens/authentication/otp_login/otp_login_view.dart';
import 'package:oogie/screens/authentication/reset_password/reset_password_view.dart';
import 'package:oogie/screens/authentication/sign_up/sign_up_bloc.dart';
import 'package:oogie/screens/authentication/sign_up/sign_up_view.dart';
import 'package:oogie/screens/explore/explore/explore_bloc.dart';
import 'package:oogie/screens/explore/explore/explore_view.dart';
import 'package:oogie/screens/explore/product/product_bloc.dart';
import 'package:oogie/screens/explore/product/product_view.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_bloc.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_view.dart';
import 'package:oogie/screens/explore/product_list/product_list_bloc.dart';
import 'package:oogie/screens/explore/product_list/product_list_view.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_bloc.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_view.dart';
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
import 'package:oogie/screens/wishlist/wishlist_bloc.dart';
import 'package:oogie/screens/wishlist/wishlist_view.dart';

AuthRepository authRepository = AuthRepository();
ProfileRepository profileRepository = ProfileRepository();
ProductRepository productRepository = ProductRepository();
OrderRepository orderRepository = OrderRepository();

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    // final GlobalKey<ScaffoldState> key = settings.arguments;
    Map arguments = settings.arguments;

    switch (settings.name) {
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
      case '/explore':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                ExploreBloc(productRepository: productRepository),
            child: ExploreView(),
          ),
        );

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
              create: (context) => CartBloc(
                productRepository: productRepository,
              ),
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => WishlistBloc(
              productRepository: productRepository,
            ),
            child: WishlistView(),
          ),
        );
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
      case '/checkout':
        print('checkout ');
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

      default:
        return null;
    }
  }
}
