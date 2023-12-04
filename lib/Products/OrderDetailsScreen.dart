import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../widgets/Service.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final String email;
  final String totalPrice;

  File? imageFile;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  OrderDetailsScreen({
    required this.orderId,
    required this.email,
    required this.totalPrice,
  });

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}
int currentStep = 0;
enum OrderStatus {
  paymentConfirmation,
  orderShipped,
}

OrderStatus currentStatus = OrderStatus.paymentConfirmation;

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

  Future<void> saveOrderToFirestore(String orderId, double totalPrice) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartRef = fireStore.collection('carts').doc(widget.email);
    final ordersRef = fireStore.collection('orders').doc(widget.email);

    await ordersRef.set({
      'order_id': orderId,
      'total_price': totalPrice,
      'user_email': widget.email,
      'products': cartProvider.products.map((product) => product.toJson()).toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดออเดอร์'),
      ),
      body: ListView(
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ช่วงที่ 3 การติดตามสินค้า',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Stepper(
                    currentStep: currentStep,
                    onStepContinue: (){
                      if(currentStep != 3)
                      setState(() => currentStep++);
                    },
                    onStepCancel: (){
                      if(currentStep != 0)
                      setState(() => currentStep--);
                    },
      steps: [
        Step(
          title: const Text('รอดำเนินการ'),
          content: const Text(
            'ได้รับออเดอร์',
          ),
          isActive: currentStep >= 0,
          state: currentStep > 0
          ? StepState.complete
           : StepState.indexed,
         
        ),
        Step(
          title: const Text('ร้านค้าได้รับออเดอร์แล้ว'),
          content: const Text(
            'เตรียมจัดส่งสืนค้า',
          ),
          isActive: currentStep >= 1,
          state: currentStep >= 1
          ? StepState.complete
           : StepState.indexed,
        ),
        Step(
          title: const Text('กำลังจัดส่งสินค้า'),
          content: const Text(
            'ได้จัดส่งสินค้าให้กับขนส่งแล้ว',
          ),
          isActive: currentStep >= 2,
          state: currentStep >= 2
          ? StepState.complete
           : StepState.indexed,
        ),
        Step(
          title: const Text('สินค้าส่งถึงแล้ว'),
          content: const Text(
            'สินค้าของคุณได้ถูกจัดส่งและลงนามโดยผู้ซื้อแล้ว',
          ),
          isActive: currentStep >= 3,
          state: currentStep >= 3
          ? StepState.complete
           : StepState.indexed,
        ),
      ],
    ),
          const SizedBox(height: 30),
          
        ],
        
      ),
    );
  }
}
