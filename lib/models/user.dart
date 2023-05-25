class UserGT {
  final String uid;

  UserGT({required this.uid});
}

class UserData {
  final String uid;
  final String username;
  final double weight;
  final double height;
  final int age;
  final bool isManager;

  UserData(
      {required this.uid,
      required this.username,
      required this.weight,
      required this.height,
      required this.age,
      required this.isManager});
}
