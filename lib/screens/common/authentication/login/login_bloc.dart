import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/screens/common/authentication/login/login_events.dart';
import 'package:oogie/screens/common/authentication/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  // final AuthCubit authCubit;

  LoginBloc({this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Phone Number updated
    if (event is LoginPhoneNumberChanged) {
      yield state.copyWith(phoneNumber: event.phoneNumber);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final authCredentials = await authRepo.login(
            phoneNumber: state.phoneNumber, password: state.password);

        // FirebaseAuth firebaseAuth=FirebaseAuth.instance;
        // await  firebaseAuth.signInWithCustomToken(authCredentials.firebaseToken);
        AppData appData = AppData();
        await appData.setUserDetails();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
