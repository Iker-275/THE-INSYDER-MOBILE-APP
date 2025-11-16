abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class CreateProfile extends ProfileEvent {
 // final Map<String, dynamic>
var  data;
  CreateProfile(this.data);
}

class UpdateProfile extends ProfileEvent {
  final Map<String, dynamic> data;
  UpdateProfile(this.data);
}
