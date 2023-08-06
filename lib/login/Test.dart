// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:map_location_picker/map_location_picker.dart';

// class MyWidget extends StatelessWidget {
//   MyWidget({super.key});

// String address = "null";
//   String autocompletePlace = "null";
//   // Prediction? initialValue;

//   final TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('location picker'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <dynamic>[
//           MapLocationPicker(
//   apiKey: "YOUR_API_KEY",
//   onNext: (GeocodingResult? result) {
//       ...
//    },
// );
//         ],
//       ),
//     );
//   }
// }