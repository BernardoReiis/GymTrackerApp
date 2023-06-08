class UserGT {
  final String uid;

  UserGT({required this.uid});
}

class UserData {
  final String uid;
  final String username;
  final String email;
  final String gender;
  final double weight;
  final double height;
  final int age;
  final int fingerprintId;
  final bool isManager;

  UserData(
      {required this.uid,
      required this.username,
      required this.email,
      required this.gender,
      required this.weight,
      required this.height,
      required this.age,
      required this.fingerprintId,
      required this.isManager});
}
