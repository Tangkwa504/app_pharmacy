import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Service.dart';
import 'dart:math';

import 'OrderDetailsScreen.dart';

class CartScreenchack extends StatefulWidget {
  final String email;
  CartScreenchack({
    required this.email,
    });
  @override
  State<CartScreenchack> createState() => _CartScreenchackState();
}

class _CartScreenchackState extends State<CartScreenchack> {
  @override
  void initState() {
    initproduct();
    super.initState();
  }

  void initproduct() {
    Future.delayed(const Duration(milliseconds: 500), () {
      final product = Provider.of<CartProvider>(context, listen: false);
      final seviceProvider = Provider.of<ProviderSer>(context, listen: false);
      product.getProductsInCart(widget.email);
    });
  }
int generateRandomOrderNumber() {
  final random = Random();
  return 1000 + random.nextInt(9000); // สร้างหมายเลขออเดอร์แบบสุ่ม
}
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final totalPrice = cartProvider.totalPrice;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.products.length,
              itemBuilder: (context, index) {
                final product = cartProvider.products[index];
                return ListTile(
                  leading: Image.network(product.image),
                  title: Text(product.namedrug),
                  subtitle: Text('${product.price} บาท x ${product.quantity} ชุด'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      
                      cartProvider.removeProduct(
                          product, widget.email);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'รวมราคา: ${totalPrice.toStringAsFixed(2)} บาท',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
  width: 120, // กำหนดความกว้างตามที่คุณต้องการ
  child: FloatingActionButton(
    backgroundColor: Colors.green,
    onPressed: () {
        final orderNumber = generateRandomOrderNumber();
        String orderId = orderNumber.toString();
     Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => OrderDetailsScreen(
        orderId: orderId,
        totalPrice: totalPrice.toStringAsFixed(2),
        email:widget.email,
        ),
      // ทำอะไรเมื่อปุ่มถูกกด
 
        ),);
    },
    child: Column( // ใช้ Column เพื่อแยกข้อความออกจากกัน
      children: [
        Text(
          'ยืนยัน',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
             fontSize: 16, // กำหนดตัวหนังสือเป็นหนา
          ),
        ),
        Text(
          'ออเดอร์',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
             fontSize: 16, // กำหนดตัวหนังสือเป็นหนา
          ),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: const BorderSide(color: Colors.green),
    ),
  ),
),
);
  }
}
