class User {
  late String firstName;
  late String lastName;
  late String email;
  late String location;

  User.registerUser(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.location});

  User();
  @override
  String toString() {
    return "User: Name - $firstName $lastName, Email - $email, Location - $location";
  }
}
