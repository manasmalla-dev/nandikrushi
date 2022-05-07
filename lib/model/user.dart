class User {
  late String farmerImage;
  late String firstName;
  late String lastName;
  late String email;
  late String pass;
  late String cpass;
  late String telePhone;
  late String houseNumber;
  late String city;
  late String mandal;
  late String district;
  late String state;
  late String pincode;
  late int landAreaInAcres;
  late String certificationType;
  User.registerUser(
      {required this.farmerImage,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.pass,
      required this.cpass,
      required this.telePhone,
      required this.houseNumber,
      required this.city,
      required this.mandal,
      required this.district,
      required this.state,
      required this.pincode,
      required this.certificationType,
      required this.landAreaInAcres});
  User.registerPartA({
    required this.farmerImage,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.pass,
    required this.cpass,
    required this.telePhone,
    required this.houseNumber,
    required this.city,
    required this.mandal,
    required this.district,
    required this.state,
    required this.pincode,
  });
  User();
  @override
  String toString() {
    return "User: First Name - $firstName,Last Name - $lastName,Email - $email,pass - $pass,cpass -$cpass,telePhone - $telePhone H.No - $houseNumber, City - $city, Mandal - $mandal, District - $district, State - $state, Pincode - $pincode";
  }
}
