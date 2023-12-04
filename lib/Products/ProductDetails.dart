

import 'package:app_pharmacy/Products/Cartchack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Products.dart';
import '../widgets/Service.dart';


class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final String email;
  final String receiverId;
  final String chatName;
  final String senderId;

  ProductDetailsScreen({
    required this.product,
    required this.email,
    required this.receiverId,
    required this.senderId,
    required this.chatName,
    });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.namedrug),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(widget.product.image),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.namedrug,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                Text(
                  '${widget.product.price} บาท',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text('Quantity'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add product to cart
               final cartprovider =
                   Provider.of<CartProvider>(context, listen: false);
                    final orderprovider =
                   Provider.of<Orderprovider>(context, listen: false);
                  //  final seviceProvider =
                  //  Provider.of<ProviderSer>(context, listen: false);
               final product = widget.product.copyWith(quantity: quantity);
               cartprovider.addProduct(product,widget.email);
               orderprovider.addProduct(product,widget.email);
               setState(() {
                          quantity=1;
                        });
              // Navigate to the cart screen
              Navigator.push(context, MaterialPageRoute(builder: ((context) => CartScreenchack(
                email: widget.email,
                product: product,
                receiverId:widget.receiverId,
                    senderId:widget.senderId,
                    chatName:widget.chatName,
              )))); 

            },
            child: Text('ไปหน้าต่อไป'),
          ),
        ],
      ),
    );
  }
}

