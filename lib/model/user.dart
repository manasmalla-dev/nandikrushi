class User {
  late String firstName;
  late String lastName;
  late String email;
  late String location;
  late String password;
  late String phoneNumber;

  User.registerUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.location,
      required this.password});

  User();
  @override
  String toString() {
    return "User: Name - $firstName $lastName, Email - $email, Location - $location";
  }
}
