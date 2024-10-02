// address_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
    selectedAddress: false, // Changed to false for consistency
  );

  // Convert model to JSON to store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      // Removed 'Id' to avoid redundancy with Firestore's document ID
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': dateTime ?? FieldValue.serverTimestamp(),
      'SelectedAddress': selectedAddress,
    };
  }

  // Convert JSON to AddressModel
  factory AddressModel.fromMap(Map<String, dynamic> data, String docId) {
    return AddressModel(
      id: docId, // Use document ID from Firestore
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      selectedAddress: data['SelectedAddress'] ?? false,
      dateTime: data['DateTime'] != null
          ? (data['DateTime'] is Timestamp
          ? (data['DateTime'] as Timestamp).toDate()
          : DateTime.tryParse(data['DateTime'].toString()))
          : null,
    );
  }

  // Factory constructor to create an AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel.fromMap(data, snapshot.id);
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
