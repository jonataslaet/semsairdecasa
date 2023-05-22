// import 'package:flutter/material.dart';
// import 'package:mobile_flutter/repositories/city_repository.dart';

// class CityForm extends StatefulWidget {
//   final void Function(String, double, double)? onSubmit;

//   CityForm(this.onSubmit);

//   @override
//   State<CityForm> createState() => _CityFormState();
// }

// class _CityFormState extends State<CityForm> {
//   final nameController = TextEditingController();
//   final latitudeController = TextEditingController();
//   final longitudeController = TextEditingController();

//   void _showForm(int? id) async {
//     if (id != null) {
//       // id == null -> create new item
//       // id != null -> update an existing item
//       final existingCity = _cities.firstWhere((element) => element['id'] == id);
//       _nameController.text = existingCity['name'];
//       _latitudeController.text = existingCity['latitude'];
//       _longitudeController.text = existingCity['longitude'];
//     }
//     final name = nameController.text;
//     final latitudeValue = double.tryParse(latitudeController.text) ?? 0.0;
//     final longitudeValue = double.tryParse(latitudeController.text) ?? 0.0;

//     if (name.isEmpty || latitudeValue < -90.0000000 || latitudeValue > 90.0000000
//     || longitudeValue < -180.0000000 || longitudeValue > 180.0000000) {
//       return;
//     }
//     widget.onSubmit!(name, latitudeValue, longitudeValue);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//               padding: EdgeInsets.only(
//                 top: 15,
//                 left: 15,
//                 right: 15,
//                 // this will prevent the soft keyboard from covering the text fields
//                 bottom: MediaQuery.of(context).viewInsets.bottom + 120,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(hintText: 'Nome'),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: latitudeController,
//                     decoration: const InputDecoration(hintText: 'Latitude'),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       // Save new journal
//                       if (id == null) {
//                         await _addItem();
//                       }

//                       if (id != null) {
//                         await _updateItem(id);
//                       }

//                       // Clear the text fields
//                       _nameController.text = '';
//                       _latitudeController.text = '';
//                       _longitudeController.text = '';

//                       // Close the bottom sheet
//                       Navigator.of(context).pop();
//                     },
//                     child: Text(id == null ? 'Create New' : 'Update'),
//                   )
//                 ],
//               ),
//             );
//   }
// }

// // Insert a new journal to the database
//   Future<void> _addItem() async {
//     await CityRepository.createItem(_nameController.text, _latitudeController.text as Double?, _longitudeController.text as Double?);
//     _refreshCities();
//   }

//   // Update an existing journal
//   Future<void> _updateItem(int id) async {
//     await CityRepository.updateItem(
//         id, _nameController.text, _latitudeController.text as Double?, _longitudeController.text as Double?);
//     _refreshCities();
//   }

//   // Delete an item
//   void _deleteItem(int id) async {
//     await CityRepository.deleteItem(id);
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('Successfully deleted a journal!'),
//     ));
//     _refreshCities();
//   }