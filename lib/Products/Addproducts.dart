// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../model/Products.dart';
// import '../widgets/Service.dart';

// class Addproduct extends StatefulWidget {
//   const Addproduct({super.key});

//   @override
//   State<Addproduct> createState() => _AddproductState();
// }

// class _AddproductState extends State<Addproduct> {
//   final _formKey = GlobalKey<FormState>();
//   File? _image;
//   final _picker = ImagePicker();
//   String? name;
//   double? price;
//   int? quantity;
//   final date = TextEditingController();


//   void _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<String> _uploadImageToFirebase() async {
//     final storageRef = FirebaseStorage.instance.ref().child('product_images');
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     final uploadTask = storageRef.child('$timestamp.jpg').putFile(_image!);
//     final snapshot = await uploadTask.whenComplete(() {});
//     final downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }

//   void _addProduct(BuildContext context) async {
//        ProviderSer productService =
//         Provider.of<ProviderSer>(context, listen: false);
//     final productProvider =
//         Provider.of<ProductProvider>(context, listen: false);
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       final downloadUrl = await productProvider.uploadProfileImage(_image!,productService.reademail);
//       final product = Product(name: name!, image: downloadUrl, price: price!,quantity: quantity!,date: date.text);
//       productProvider.addProduct(product,productService.reademail);

//       Navigator.pop(context);
//     }
//   }
//   Future<void> datePicker(
//                    BuildContext context, TextEditingController conn) async {
//                     DateTime? date = await showRoundedDatePicker(
//                     context: context,
//                     theme: ThemeData(primarySwatch: Colors.green),
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(DateTime.now().year - 1),
//                     lastDate: DateTime(DateTime.now().year + 5),
//                     borderRadius: 16,
//                     );

//                     var formate = DateFormat('yyyy-MM-dd');
//                     String formattedDate = formate.format(date ?? DateTime.now());
//                     print(formattedDate);
//                     conn.text = formattedDate;
//                    }  
  
//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
  
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Product'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     color: Colors.grey,
//                     child: _image != null
//                         ? Image.file(
//                             _image!,
//                             fit: BoxFit.cover,
//                           )
//                         : const Icon(
//                             Icons.add_a_photo,
//                             color: Colors.white,
//                             size: 50.0,
//                           ),
//                   ),
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a name';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     name = value;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(labelText: 'Price'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Price';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     var myDouble = double.parse(value!);
//                     price = myDouble;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(labelText: 'Quantity'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a quantity';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     quantity = int.parse(value!);
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 InkWell(
//                   onTap: () async{
//                    await datePicker(context,date);
//                   },
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(labelText: 'Expiration date'),
//                     enabled: false,
//                     controller: date,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter the expiration date';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {                   
//                       date.text = value!;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     _addProduct(context);
//                   },
//                   child: const Text('Add Product'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }