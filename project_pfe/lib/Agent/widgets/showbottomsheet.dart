// import 'package:flutter/material.dart';
// import 'package:path/path.dart';

// class MyBottomSheet extends StatefulWidget {
//   final Function onCameraPressed;
//   final Function onAlbumPressed;

//   MyBottomSheet(
//       {super.key, required this.onCameraPressed, required this.onAlbumPressed});

//   @override
//   State<MyBottomSheet> createState() => _MyBottomSheetState();
// }

// class _MyBottomSheetState extends State<MyBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       builder: (Context) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 13),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//                 style: IconButton.styleFrom(
//                     backgroundColor: Colors.black87,
//                     foregroundColor: Colors.white70),
//                 onPressed: () => widget.onCameraPressed(),
//                 iconSize: 40,
//                 icon: const Icon(Icons.camera_enhance)),
//             IconButton(
//                 style: IconButton.styleFrom(
//                     backgroundColor: Colors.black87,
//                     foregroundColor: Colors.white70),
//                 onPressed: () => widget.onAlbumPressed(),
//                 iconSize: 40,
//                 icon: Icon(Icons.photo_album_rounded)),
//           ],
//         ),
//       ),
//     );
//   }
// }
