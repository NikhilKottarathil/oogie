import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/screens/common/authentication/sign_up/sign_up_events.dart';
import 'package:oogie/screens/common/authentication/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;

  // final AuthCubit authCubit;

  SignUpBloc({this.authRepo}) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(
          userName: event.username, formStatus: InitialFormStatus());
    } else if (event is SignUpPhoneNumberChangeChanged) {
      yield state.copyWith(
          phoneNumber: event.phoneNumber, formStatus: InitialFormStatus());
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(
          password: event.password, formStatus: InitialFormStatus());
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      try {
        firebaseAuth.verifyPhoneNumber(
            timeout: Duration(seconds: 60),
            phoneNumber: '+91' + state.phoneNumber,
            verificationCompleted: (verificationCompleted) async {},
            verificationFailed: (verificationFailed) async {},
            codeSent: (verificationId, resendingToken) async {
              add(SignUpSubmittedSuccessfully(
                  verificationId: verificationId, resendToken: resendingToken));
            },
            codeAutoRetrievalTimeout: (verificationId) {});
      } on FirebaseAuthException catch (e) {
        print(e);
        add(SignUpSubmittedFailed(e: e));
      }
    } else if (event is SignUpSubmittedSuccessfully) {
      yield state.copyWith(
          formStatus: SubmissionSuccess(),
          verificationId: event.verificationId,
          resendToken: event.resendToken);
    } else if (event is SignUpSubmittedFailed) {
      yield state.copyWith(formStatus: SubmissionFailed(event.e));
      yield state.copyWith(formStatus: InitialFormStatus());
    }
  }
}
