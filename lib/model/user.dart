class User {
  final int id;
  final String name;
  final String phoneNumber;
  final DateTime checkIn;

  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.checkIn,
  });

  User.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['user'],
            phoneNumber: json['phone'],
            checkIn: DateTime.parse(json['check-in']));

  Map<String, dynamic> toJson() =>
      {'id': id, 'user': name, 'phone': phoneNumber, 'check-in': checkIn};
}
