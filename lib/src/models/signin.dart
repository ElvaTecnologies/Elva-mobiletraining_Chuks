import 'dart:convert';

import 'package:equatable/equatable.dart';

class Signin extends Equatable {
	final String? username;
	final String? password;

	const Signin({this.username, this.password});

	factory Signin.fromSignIn(Map<String, dynamic> data) => Signin(
				username: data['username'] as String?,
				password: data['password'] as String?,
			);

	Map<String, dynamic> toSignIn() => {
				'username': username,
				'password': password,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Signin].
	factory Signin.fromJson(String data) {
		return Signin.fromSignIn(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Signin] to a JSON string.
	String toJson() => json.encode(toSignIn());

	Signin copyWith({
		String? username,
		String? password,
	}) {
		return Signin(
			username: username ?? this.username,
			password: password ?? this.password,
		);
	}

	@override
	List<Object?> get props => [username, password];
}
