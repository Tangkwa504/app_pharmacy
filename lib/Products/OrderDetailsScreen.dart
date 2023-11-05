import 'package:app_pharmacy/widgets/Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final String email;
  final String totalPrice;

  File? imageFile;
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OrderDetailsScreen({
    required this.orderId,
    required this.email,
    required this.totalPrice,
  });

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        widget.imageFile = File(image.path);
      });
    }
  }

  void saveOrderToFirestore(String orderId, double totalPrice) {
    final cartProvider = Provider.of<CartProvider>(context);
    final user = widget.email;
    final orderData = {
      'order_id': orderId,
      'total_price': totalPrice,
      'user_email': widget.email,
      'products': cartProvider.products.map((product) => product.toJson()).toList(),
      // เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการบันทึก เช่น รายการสินค้า, เวลาออเดอร์, ที่อยู่จัดส่ง, และอื่น ๆ
    };

    FirebaseFirestore.instance.collection('orders').doc(user).set(orderData).then((documentReference) {
      // บันทึกเสร็จสิ้น
      //print('บันทึกออเดอร์เรียบร้อย: ${documentReference.id}');
    }).catchError((error) {
      // เกิดข้อผิดพลาดในการบันทึก
      print('เกิดข้อผิดพลาดในการบันทึกออเดอร์: $error');
    });
    
  }
  
  

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดออเดอร์'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ช่วงแรก รายละเอียดออเดอร์',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('รหัสออเดอร์: ${widget.orderId}'),
          ),
          ListTile(
            title: Text('ยอดรวม: ${widget.totalPrice} บาท'),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ช่วงที่ 2 รายละเอียดสินค้า',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.products.length,
              itemBuilder: (context, index) {
                final product = cartProvider.products[index];
                return ListTile(
                  leading: Image.network(product.image),
                  title: Text(product.namedrug),
                  subtitle: Text('${product.price} บาท x ${product.quantity} ชุด'),
                  
                );
              },
            ),
          ),
          // นำข้อมูลจากหน้า carts มาแสดงตรงช่วงนี้

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ช่วงที่ 3 การติดตามสินค้า',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              Column(
                children: [
                  Icon(
                    Icons.image, // รูปภาพจัดส่งสินค้า
                    color: Colors.blue,
                    size: 48,
                  ),
                  Text('รอยืนยันการชำระเงิน', style: TextStyle(color: Colors.black)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('แสดงรูปภาพ'),
              ),
            ],
          ),     
              const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  widget.imageFile != null
                      ? Image.file(
                          widget.imageFile!,
                          width: 100,
                          height: 100,
                        )
                      : Icon(
                          Icons.image,
                          color: Colors.blue,
                          size: 48,
                        ),
                  Text('จัดส่งสินค้า', style: TextStyle(color: Colors.black)),
                ],
                
              ),
              
              ElevatedButton(
                onPressed: () {
                  _pickImage(); 
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('เพิ่มรูปภาพ'),
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                saveOrderToFirestore(widget.orderId, cartProvider.totalPrice);
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text('เสร็จสิ้นออเดอร์'),
            ),
          )
        ],
      ),
    );
  }
}
