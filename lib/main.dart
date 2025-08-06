import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int count;
  late double price, total;

  @override
  void initState() {
    super.initState();
    count = 0;     // Initialize count to 0
    price = 29.99; 
    total = 0.0;  // Initialize price to 0.0
  }

  void calculateTotal() {
    setState(() {
      total = count * price; // Calculate total based on count and price
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: Drawer(
          backgroundColor: Colors.grey[200],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.indigo),
                title: Text('Home'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.indigo),
                title: Text('Settings'),
                onTap: () {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          
          title: Text(
            'My First App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: Center(
              child: Column(
                children: [
                  SizedBox(width: 20),
                  // Profile Picture
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 200,
                    width: 165,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26.withAlpha(40),
                          spreadRadius: 2,
                          blurRadius: 10,
                          // offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person,
                          size: 80,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(height: 2),
                        Text('Jonsen Gaire',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                        SizedBox(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email, color: Colors.blueGrey, size: 12),
                            SizedBox(width: 2),
                            Text('jonsen455@gmail.com',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 8,
                              )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  // Profile Description
                  Container(
                    height: 200,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26.withAlpha(40),
                          spreadRadius: 2,
                          blurRadius: 10,
                          // offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      
              
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 15),
                        Text('Jonsen Gaire',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),  
                         
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.location_on, color: Colors.blueGrey, size: 20),
                            // SizedBox(width: 10),
                            Text('Nayagaun, Pokhara-15',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              )),  
                          ],
                        ),
                        // SizedBox(height: 2),
                        SizedBox(width: 10),
                        Container(
                          // margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                          padding: EdgeInsets.only(left:10, right: 10),
                          child: Text('a;lfalfalkfdka;lksjsfkjhaldkfj;alkfj;l',
                              style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              
                            )
                          ),
                        ),  
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  count = 0; // Reset count to 0
                                  total = 0.0; // Reset total to 0.0
                                });
                              },
                              child: Container(
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text("Reset",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (count > 0) {
                                    count--;
                                    calculateTotal();
                                  }
                                });
                              },
                              child: Container(
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text("-",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(count.toString())
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  count++;
                                  calculateTotal();
                                });
                              },
                              child: Container(
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text("+",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ),
                            )
                          ],
                        )
                        
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26.withAlpha(10),
                          spreadRadius: 2,
                          blurRadius: 10,
                          // offset: Offset(0, 4),
                        ),
                      
                      ],
                      
                    ),
                    child: Row(
                      children: [
                        Text("Total:"),
                        SizedBox(width: 10),
                        Text(total.toString())                     ],
                    ),
                    
                  )
                  
                ],
              ),
            ),

        ),
      );
   
  }
}

// class MyApp extends StatelessWidget{
//   const MyApp({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.grey[600],
//         drawer: Drawer(),
//         appBar: AppBar(
//           backgroundColor: Colors.indigo,
//           foregroundColor: Colors.white,
          
//           title: Text(
//             'My First App',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold
//             ),
//           ),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(Icons.person,
//                   size: 80,
//                   color: Colors.blueGrey,
//                 ),
//               ),
//               SizedBox(height: 20),
//               const Text(
//                 'Flutter Developer',
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.all(16),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26.withAlpha(10),
//                       spreadRadius: 2,
//                       blurRadius: 10,
//                       // offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // email
//                     Row(
//                       children: [
//                         Icon(Icons.email, color: Colors.blueGrey),
//                         Text('jonsen455@gmail.com'),
//                         SizedBox(width: 8),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     // phone
//                     Row(
//                       children: [
//                         Icon(Icons.phone, color: Colors.blueGrey),
//                         Text('+977 9804115411'),
//                         SizedBox(width: 8),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     // address
//                     Row(
//                       children: [
//                         Icon(Icons.location_on, color: Colors.blueGrey),
//                         Text('Pokhara, Nepal'),
//                         SizedBox(width: 8),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     // website
//                     Row(
//                       children: [
//                         Icon(Icons.web, color: Colors.blueGrey),
//                         SizedBox(width: 8),
//                         Text('www.jonsen.com.np',
//                         style: TextStyle(
//                           fontStyle: FontStyle.italic,
//                         ),)
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ); 
//   }
// }