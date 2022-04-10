class User {
  final String name;
  final String phoneNumber;
  final DateTime checkIn;

  const User({
    required this.name,
    required this.phoneNumber,
    required this.checkIn,
  });

  User.fromJson(Map<String, dynamic> json)
      : this(
            name: json['user'],
            phoneNumber: json['phone'],
            checkIn: DateTime.parse(json['check-in']));

  Map<String, dynamic> toJson() =>
      {'user': name, 'phone': phoneNumber, 'check-in': checkIn.toString()};
}
