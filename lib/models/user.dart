import 'package:meta/meta.dart';

class User {
  final String name;
  final String email;
  final String id;
  final String token;

  User({@required this.name, @required this.email,@required this.id, @required this.token});

  @override
  String toString() => 'User { name: $name, email: $email}';
}
