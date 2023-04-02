
class RegisterResponse {
  RegisterResponse({
      this.id,
      this.email, 
      this.firstName, 
      this.lastName, 
      this.role, 
      this.username, 
   });

  RegisterResponse.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    username = json['username'];

  }
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  String? avatarUrl;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['role'] = role;
    map['username'] = username;

    return map;
  }

}