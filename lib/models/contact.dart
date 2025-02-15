class Contact {
  final String id;
  final String name;
  final String phoneNumber;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  // Converte Contact para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  // Converte Map para Contact
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
