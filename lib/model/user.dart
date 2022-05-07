import 'dart:io';

class User {
  late String farmerImage;
  late String farmerName;
  late String houseNumber;
  late String city;
  late String mandal;
  late String district;
  late String state;
  late String pincode;
  late int landAreaInAcres;
  late String certificationType;
  late String certificationRegisterationNumber;
  late List<File> certificates;
  addCertification(rn, cert) {
    certificationRegisterationNumber = rn;
    certificates = cert;
  }

  User.registerUser(
      {required this.farmerImage,
      required this.farmerName,
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
    required this.farmerName,
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
    return "User: Farmer Name - $farmerName, H.No - $houseNumber, City - $city, Mandal - $mandal, District - $district, State - $state, Pincode - $pincode";
  }
}
