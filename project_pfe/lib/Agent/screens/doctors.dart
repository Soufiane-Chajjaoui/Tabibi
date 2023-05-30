// import 'package:flutter/material.dart';
// import 'package:project_pfe/Agent/widgets/UserCard.dart';
// import 'package:project_pfe/Agent/widgets/UserCardLoad.dart';
// import 'package:project_pfe/actions/Agent.dart';
// import 'package:project_pfe/actions/UserChat.dart';


// class ListDoctors extends StatefulWidget {
//   const ListDoctors({super.key});

//   @override
//   State<ListDoctors> createState() => _ListDoctorsState();
// }

// class _ListDoctorsState extends State<ListDoctors> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading:IconButton(onPressed: (){}, icon: Icon( Icons.arrow_back)),
//       ),
//       body: FutureBuilder(
//         future: Agent.getDoctors(),
//         builder: (context, snapshot) {  
//                                         List<UserChat>? list = snapshot.data as List<UserChat>; 


//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return ListView.builder(
//               itemCount:  8,
//               itemBuilder: (context , int i)=> SkeletonCardUser());
//           }else if (snapshot.hasData){
//             if (list.isEmpty) {
                
//             } else {
              
//             }
//           }
//         return ListView.builder(itemBuilder: itemBuilder)
//       },),
//     );
//   }
// }