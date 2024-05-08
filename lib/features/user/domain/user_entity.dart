import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.country,
    required this.city,
    required this.email,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      country: map['country'] as String,
      city: map['city'] as String,
      email: map['email'] as String?,
    );
  }
  final String country;
  final String city;
  final String? email;

  @override
  List<Object> get props => [
        country,
        city,
      ];

  User copyWith({
    String? country,
    String? city,
    String? email,
  }) {
    return User(
      country: country ?? this.country,
      city: city ?? this.city,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'city': city,
      'email': email,
    };
  }

  @override
  bool get stringify => true;
}
