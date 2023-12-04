// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import '../widgets/Service.dart';

// class OrderDetailsScreen extends StatefulWidget {
//   final String orderId;
//   final String email;
//   final String totalPrice;

//   File? imageFile;

//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   OrderDetailsScreen({
//     required this.orderId,
//     required this.email,
//     required this.totalPrice,
//   });

//   @override
//   _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
// }

// enum OrderStatus {
//   paymentConfirmation,
//   orderShipped,
// }

// OrderStatus currentStatus = OrderStatus.paymentConfirmation;

// class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
//   Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         widget.imageFile = File(image.path);
//       });
//     }
//   }

//   Future<void> saveOrderToFirestore(String orderId, double totalPrice) async {
//     FirebaseFirestore fireStore = FirebaseFirestore.instance;
//     final cartProvider = Provider.of<CartProvider>(context);
//     final cartRef = fireStore.collection('carts').doc(widget.email);
//     final ordersRef = fireStore.collection('orders').doc(widget.email);

//     await ordersRef.set({
//       'order_id': orderId,
//       'total_price': totalPrice,
//       'user_email': widget.email,
//       'products': cartProvider.products.map((product) => product.toJson()).toList(),
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('รายละเอียดออเดอร์'),
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'ช่วงแรก รายละเอียดออเดอร์',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           ListTile(
//             title: Text('รหัสออเดอร์: ${widget.orderId}'),
//           ),
//           ListTile(
//             title: Text('ยอดรวม: ${widget.totalPrice} บาท'),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'ช่วงที่ 2 รายละเอียดสินค้า',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: cartProvider.products.length,
//             itemBuilder: (context, index) {
//               final product = cartProvider.products[index];
//               return ListTile(
//                 leading: Image.network(product.image),
//                 title: Text(product.namedrug),
//                 subtitle: Text('${product.price} บาท x ${product.quantity} ชุด'),
//               );
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'ช่วงที่ 3 การติดตามสินค้า',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Column(
//                 children: [
//                   Icon(
//                     currentStatus == OrderStatus.paymentConfirmation
//                         ? Icons.image
//                         : Icons.check_circle,
//                     color: currentStatus == OrderStatus.paymentConfirmation
//                         ? Colors.blue
//                         : Colors.green,
//                     size: 48,
//                   ),
//                   Text(
//                     currentStatus == OrderStatus.paymentConfirmation
//                         ? 'รอยืนยันการชำระเงิน'
//                         : 'ชำระเงินเรียบร้อย',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (currentStatus == OrderStatus.paymentConfirmation) {
//                     // แสดงรูปภาพหรือการตอบรับการชำระเงิน
//                   } else if (currentStatus == OrderStatus.orderShipped) {
//                     // ดำเนินการเพิ่มรูปภาพหรือข้อมูลการจัดส่ง
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(primary: Colors.green),
//                 child: Text(
//                   currentStatus == OrderStatus.paymentConfirmation
//                       ? 'แสดงรูปภาพ'
//                       : 'เพิ่มรูปภาพ',
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Column(
//                 children: [
//                   widget.imageFile != null
//                       ? Image.file(
//                           widget.imageFile!,
//                           width: 100,
//                           height: 100,
//                         )
//                       : Icon(
//                           currentStatus == OrderStatus.paymentConfirmation
//                               ? Icons.image
//                               : Icons.check_circle,
//                           color: currentStatus == OrderStatus.paymentConfirmation
//                               ? Colors.blue
//                               : Colors.green,
//                           size: 48,
//                         ),
//                   Text(
//                     currentStatus == OrderStatus.paymentConfirmation
//                         ? 'จัดส่งสินค้า'
//                         : 'สินค้าจัดส่งแล้ว',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (currentStatus == OrderStatus.paymentConfirmation) {
//                     _pickImage();
//                   } else if (currentStatus == OrderStatus.orderShipped) {
//                     // ดำเนินการเพิ่มรูปภาพหรือข้อมูลการจัดส่ง
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(primary: Colors.green),
//                 child: Text(
//                   currentStatus == OrderStatus.paymentConfirmation
//                       ? 'เพิ่มรูปภาพ'
//                       : 'เสร็จสิ้นออเดอร์',
//                 ),
//               ),
//             ],
//           ),
//            const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Column(
//                 children: [
//                   widget.imageFile != null
//                       ? Image.file(
//                           widget.imageFile!,
//                           width: 100,
//                           height: 100,
//                         )
//                       : Icon(
//                           currentStatus == OrderStatus.paymentConfirmation
//                               ? Icons.image
//                               : Icons.check_circle,
//                           color: currentStatus == OrderStatus.paymentConfirmation
//                               ? Colors.blue
//                               : Colors.green,
//                           size: 48,
//                         ),
//                   Text(
//                     currentStatus == OrderStatus.paymentConfirmation
//                         ? 'จัดส่งสินค้า'
//                         : 'สินค้าจัดส่งแล้ว',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (currentStatus == OrderStatus.paymentConfirmation) {
//                     _pickImage();
//                   } else if (currentStatus == OrderStatus.orderShipped) {
//                     // ดำเนินการเพิ่มรูปภาพหรือข้อมูลการจัดส่ง
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(primary: Colors.green),
//                 child: Text(
//                   currentStatus == OrderStatus.paymentConfirmation
//                       ? 'เพิ่มรูปภาพ'
//                       : 'เสร็จสิ้นออเดอร์',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
