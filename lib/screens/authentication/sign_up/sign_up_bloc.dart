import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/screens/authentication/sign_up/sign_up_events.dart';
import 'package:oogie/screens/authentication/sign_up/sign_up_state.dart';



class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  // final AuthCubit authCubit;

  SignUpBloc({this.authRepo}) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(userName: event.username);
    }
    else if (event is SignUpPhoneNumberChangeChanged) {
      yield state.copyWith(phoneNumber: event.phoneNumber);

    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
       final generatedOTP = await authRepo.getSignUpOTP(phoneNumber:state.phoneNumber);

        // authCubit.showVerifySignUp(userName:state.userName,phoneNumber: state.phoneNumber,password: state.password,verifyOTP: verifyOTP);
        yield state.copyWith(formStatus: SubmissionSuccess(),generatedOTP: generatedOTP);
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
        yield state.copyWith(formStatus: InitialFormStatus());

      }
    }
  }
}