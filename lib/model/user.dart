

class LoginUser{
  final String? name;
  final String? phone;
  final String? state;
  final String? city;
  final String? address;

  LoginUser({ this.name, this.phone, this.state,this.city, this.address});

   LoginUser.fromDocumentSnapshot(Map<String, dynamic> data) :
      name= data["full_name"],
      phone= data["phone"],
      state= data["state"],
      city = data["city"],
      address= data["address"];

}