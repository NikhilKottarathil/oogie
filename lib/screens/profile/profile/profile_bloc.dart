import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/functions/select_image.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/profile/profile/profile_events.dart';
import 'package:oogie/screens/profile/profile/profile_state.dart';



class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  ProfileRepository profileRepository;
  var imageAspectRatio;

  ProfileBloc({this.profileRepository}) : super(ProfileState()) {
    getUserData();
  }

  Future getUserData() async {
    try {
      final user = await profileRepository.getUserDetails();
      state.name = user['name'] != null ? user['name'] : '';
      state.phoneNumber = user['mobile'] != null ? user['mobile'] : '';
      state.bio = user['about_me'] != null ? user['about_me'] : '';
      state.imageUrl=user['profile_pic']['url']!=null?'https://api.queschat.com/'+user['profile_pic']['url']:Urls().personUrl;
      emit(state);
    } on Exception {
      // emit();
    }
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // Phone Number updated
    if (event is ChangeProfilePicture) {
      print('in');
      try {
        state.imageFile = await selectImage(
            imageFile: state.imageFile,
            aspectRatios: imageAspectRatio,
            context: event.context);
       await profileRepository.changeProfilePicture(imageFile: state.imageFile);
       await getUserData();
        yield state.copyWith();

      } catch (e) {
        print(e);
      }
    } else if (event is ProfileEdited) {
      try {
        await getUserData();
        print(state.name);
        print(state.phoneNumber);

        yield state.copyWith();

      }catch(e){

      }
    }
  }
}
