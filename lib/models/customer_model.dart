import 'package:apos/lib_exp.dart';

class Customer {
  String? id;
  String name;
  String email;
  String phone;
  String address;

  Customer({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json, String id) {
    return Customer(
      id: id,
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}

Customer tempCustomer(int index) => Customer(
      id: "#$index",
      name: "Client ${Consts.aToz[index]}",
      email: "mail@example.com",
      phone: "09123456789",
      address: "Enim excepteur anim nostrud consequat.",
    );
