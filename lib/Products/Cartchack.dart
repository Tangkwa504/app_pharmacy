import 'package:app_pharmacy/Products/productspagechat.dart';
import 'package:app_pharmacy/model/Products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/variable.dart';
import '../widgets/Service.dart';
import 'dart:math';

import 'OrderDetailsScreen.dart';
import 'ProductDetails.dart';

class CartScreenchack extends StatefulWidget {
  final Product product;
  final String email;
  final String receiverId;
  final String chatName;
  final String senderId;
  
  CartScreenchack({
    required this.email,
    required this.product,
    required this.receiverId,
    required this.senderId,
    required this.chatName,
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
    final orderprovider = Provider.of<Orderprovider>(context);
    final totalPrice = cartProvider.totalPrice;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.post_add_outlined),
            onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductsPagechat(
        receiverId: widget.receiverId,
        senderId: widget.senderId,
        chatName: widget.chatName,
        email: widget.email,
      ),
    ),
  );
},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
  child: ListView.builder(
    itemCount: cartProvider.products.length,
    itemBuilder: (context, index) {
      final product = cartProvider.products[index];
      Variable.product.add(product);
      return ListTile(
        leading: Image.network(product.image),
        title: Text(product.namedrug),
        subtitle: Text('${product.price} บาท x ${product.quantity} ชุด'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [           
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: product,
                    email: widget.email,
                    receiverId: widget.receiverId,
                    senderId: widget.senderId,
                    chatName: widget.chatName,
                    
                  ),
                ),
              );
              },             
            ),
             IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cartProvider.removeProduct(product, widget.email);
                orderprovider.removeProduct(product, widget.email);
              },
            ),
            // สามารถเพิ่ม IconButton หรือ Icon อื่น ๆ ตามต้องการ
          ],
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
        orderprovider.clearCart(widget.email);
        print("Variable.product === ${Variable.product[0].namedrug} ");
        orderprovider.addorder(widget.email,orderId);
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
