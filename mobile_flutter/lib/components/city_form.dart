
import 'package:flutter/material.dart';

class CityForm extends StatefulWidget {
  final void Function(int, String, double, double)? onSubmit;

  CityForm(this.onSubmit);

  @override
  State<CityForm> createState() => _CityFormState();
}

class _CityFormState extends State<CityForm> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  _submitForm() {
    final cityId = int.tryParse(latitudeController.text);
    final name = nameController.text;
    final valueLatitudeController = double.tryParse(latitudeController.text) ?? 0.0;
    final valueLongitudeController = double.tryParse(longitudeController.text) ?? 0.0;

    if (name.isEmpty || isNotValidLatitudeAndLongitude(valueLatitudeController, valueLongitudeController)) {
      return;
    }
    widget.onSubmit!(cityId!, name, valueLatitudeController, valueLongitudeController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // Isso vai prevenir que o teclado cubra os campos
            bottom: MediaQuery.of(context).viewInsets.bottom + 240,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Nome da cidade'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: latitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(hintText: 'Latitude'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: longitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) =>  _submitForm(),
                decoration: const InputDecoration(hintText: 'Longitude'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  _submitForm();
                },
                child: const Text('Submeter'),
              )
            ],
          ),
        );
  }
}

bool isNotValidLatitudeAndLongitude(double valueLatitudeController, double valueLongitudeController){
  return (valueLatitudeController < -90.0000 ||
      valueLatitudeController > 90.0000 ||
      valueLongitudeController < -180.0000 ||
      valueLongitudeController > 180.0000);
}