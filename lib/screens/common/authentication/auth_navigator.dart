// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:oogie/screens/common/authentication/auth_cubit.dart';
// import 'package:oogie/screens/common/authentication/auth_repo.dart';
// // import 'package:oogie/screens/common/authentication/forgot_password/forgot_password_bloc.dart';
// // import 'package:oogie/screens/common/authentication/forgot_password/forgot_password_view.dart';
// import 'package:oogie/screens/common/authentication/login/login_view.dart';
// import 'package:oogie/screens/common/authentication/sign_up/sign_up_view.dart';
// import 'package:oogie/screens/common/authentication/verfiy_sign_up/verify_signup_view.dart';
//
// class AuthNavigator extends StatelessWidget {
//   final _navigationKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthCubit, AuthState>(
//       builder: (context, state) {
//         return Navigator(
//             key: _navigationKey,
//             pages: [
//               // Show login
//               if (state == AuthState.login) MaterialPage(child: LoginView()),
//               // if (state == AuthState.forgotPassword)
//               //   MaterialPage(
//               //       child: BlocProvider(
//               //           create: (context) => ResetPasswordBloc(
//               //                 authRepo: context.read<AuthRepository>(),
//               //                 authCubit: context.read<AuthCubit>(),
//               //               ),
//               //           child: ResetPasswordView())),
//
//               // Allow push animation
//               if (state == AuthState.signUp ||
//                   state == AuthState.verifySignUp) ...[
//                 // Show Sign
//
//                 MaterialPage(child: SignUpView()),
//                 // Show confirm sign up
//                 if (state == AuthState.verifySignUp)
//                   MaterialPage(child: VerifySignUpView())
//               ]
//             ],
//         onPopPage: (route, result) => route.didPop(result),
//         );
//         },
//     );
//   }
// }
//
