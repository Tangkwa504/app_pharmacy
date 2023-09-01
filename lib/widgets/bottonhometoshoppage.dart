// import 'package:flutter/material.dart';

// //import '../login/login_screen.dart';

// class Bottonhometoshop extends StatelessWidget {
//   const Bottonhometoshop({
//     Key? key, required this.title , required this.page , required this.icon, required this.onPressed
//   }) : super(key: key);
// final String title;
// final Widget page;
// final IconData icon;
// final VoidCallback onPressed;
//   @override
//   Widget build(BuildContext context) {
//     print(title);
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: 130,
//         height: 130,
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Color.fromARGB(255, 151, 159, 182),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 50),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 0, 0, 0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }