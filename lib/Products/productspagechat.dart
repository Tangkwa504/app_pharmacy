import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../model/Products.dart';
import '../widgets/Service.dart';
import 'Addproducts.dart';
import 'ProductDetails.dart';

class ProductsPagechat extends StatefulWidget {
  final String receiverId;
  final String chatName;
  final String senderId;
  final String email;
  const ProductsPagechat({
    required this.receiverId,
    required this.senderId,
    required this.chatName,
    required this.email,
    super.key});

  @override
  State<ProductsPagechat> createState() => _ProductsPagechatState();
}

class _ProductsPagechatState extends State<ProductsPagechat> {
  @override
  void initState() {
    initproduct();
    super.initState();
  }
  void initproduct() {
    Future.delayed(const Duration(milliseconds: 500), () {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final seviceProvider = Provider.of<ProviderSer>(context, listen: false);
    product.initProducts(seviceProvider.reademail);  
});
      
  } 

  @override
  Widget build(BuildContext context) {
    final List<Product> products =
        Provider.of<ProductProvider>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product.image),
            title: Text(product.namedrug),
            subtitle: Text('${product.price.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: product,
                    email: widget.email,
                  ),
                ),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => Addproduct(),
      //           ),
      //         );
      //     },
      //   child: const Icon(Icons.add),
      // ),
    );

  }
}