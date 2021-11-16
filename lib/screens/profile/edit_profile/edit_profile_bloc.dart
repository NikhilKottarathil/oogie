import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/profile/edit_profile/edit_profile_event.dart';
import 'package:oogie/screens/profile/edit_profile/edit_profile_state.dart';
import 'package:oogie/screens/profile/profile/profile_bloc.dart';
import 'package:oogie/screens/profile/profile/profile_events.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepository profileRepository;
  final ProfileBloc profileBloc;

  EditProfileBloc({this.profileRepository, this.profileBloc})
      : super(EditProfileState()) {
    setUserDetails();
  }

  setUserDetails() {
    state.userName = profileBloc.state.name;
    state.phoneNumber = profileBloc.state.phoneNumber;
  }

  @override
  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is EditProfileUsernameChanged) {
      yield state.copyWith(userName: event.username);
    } else if (event is EditProfilePhoneNumberChangeChanged) {
      yield state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is EditProfileSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await profileRepository.editUserProfile(
            userName: state.userName, phoneNumber: state.phoneNumber);
        profileBloc.add(ProfileEdited());
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
