import 'dart:ffi';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListView(),
    );
  }
}

/**
 * Contact Us Page
 */
// class ContactUs extends StatefulWidget{
//   const ContactUs({super.key});

//   @override
//   State<ContactUs> createState() => _ContactUsState();
// }

// class _ContactUsState extends State<ContactUs> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         toolbarHeight: 75,
//         // foregroundColor: Colors.white,
//         elevation: 16,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(24),
//             bottomRight: Radius.circular(24),
//           ),
//         ),
//         title: Text(
//           'Contact Us',
//           style: TextStyle(
//             color: Colors.indigo,
//             fontSize: 24,
//             fontWeight: FontWeight.bold
//           ),
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.contact_mail_rounded, size: 100, color: Colors.indigo),
//               SizedBox(height: 20),
//               Text('For any queries, please contact us at:',
//                 style: TextStyle(fontSize: 18, color: Colors.black54)),
//               SizedBox(height: 10),
//             ]
//           ),
//         )
//       )
              
//     );
//   }     
// }

// Product Model
class ProductModel {
  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final IconData icon;
  final double rating;
  final String category;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.rating,
    required this.category,
  });
}

class ProductListView extends StatefulWidget{
  const ProductListView({super.key});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final List<ProductModel> products = [
    ProductModel(
      id: "1",
      name: "Headphones", 
      description: "Wireless high quality headphone.", 
      price: 2000.0, 
      icon: Icons.headphones,
      category: 'electronics',
      imageUrl: 'https://surli.cc/iddlzs',
      rating: 4.5,
    ),
    ProductModel(
      id: "2",
      name: "Smart watch", 
      description: "Wireless high quality smart watch.", 
      price: 5000.0, 
      icon: Icons.watch,
      category: 'electronics',
      imageUrl: '',
      rating: 4.0,
    ),
    ProductModel(
      id: "3",
      name: "J Earphones", 
      description: "Wireless high quality Earbuds.", 
      price: 900.0, 
      icon: Icons.earbuds,
      category: 'electronics',
      imageUrl: '',
      rating: 4.2,
    ),
    ProductModel(
      id: "4",
      name: "Shirt", 
      description: "Cotton Shirt.", 
      price: 1200.0, 
      icon: Icons.checkroom,
      category: 'clothing',
      imageUrl: '',
      rating: 4.2,
    ),
  ];

  String sortBy = 'name';
  String selectedCategory = 'all';

  List<ProductModel> get filteredProducts {
    var filtered = selectedCategory == 'all'
        ? products
        : products.where((product) => product.category.toLowerCase() == selectedCategory.toLowerCase()).toList();

    filtered.sort((a,b){
      switch (sortBy){
        case 'name':
          return a.name.compareTo(b.name);
        case 'price_low':
          return a.price.compareTo(b.price);
        case 'price_high':
          return b.price.compareTo(a.price);
        case 'rating':
          return b.rating.compareTo(a.rating); // Sort by rating in descending order
        default:
          return 0; // No sorting
      }
    });

    // filterCategories = products.where((product) {
    //   if (selectedCategory == 'all') {
    //     return true; // Show all products
    //   }
    //   // Add more categories as needed
    //   if (selectedCategory == 'electronics') {
    //     return product.category.toLowerCase() == 'electronics';
    //   } else if (selectedCategory == 'clothing') {
    //     return product.category.toLowerCase() == 'clothing';
    //   }
    //   return product.name.toLowerCase().contains(selectedCategory.toLowerCase());
    // }).toList();
    return filtered;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Product List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon:Icon(Icons.shopping_cart, color: Colors.white,)),
        
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  // color: Colors.indigo,
                  border: Border.all(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: 
                DropdownButtonHideUnderline(
                
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: selectedCategory,
                    items: [
                      DropdownMenuItem(value: 'all', child: Text('All', 
                      style: TextStyle(
                        color: Colors.indigo
                      ),
                      )),
                      DropdownMenuItem(value: 'electronics', child: Text('Electronics', style: TextStyle(
                        color: Colors.indigo
                      ))),
                      DropdownMenuItem(value: 'clothing', child: Text('Clothing', style: TextStyle(
                        color: Colors.indigo
                      ))),
                    ],
                    onChanged: (value){
                      setState((){
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),

              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  // color: Colors.indigo,
                  border: Border.all(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: 
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: sortBy,
                    items: [
                      DropdownMenuItem(value: 'name', child: Text('Name', 
                      style: TextStyle(
                        color: Colors.indigo
                      ),
                      )),
                      DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High', style: TextStyle(
                        color: Colors.indigo
                      ))),
                      DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low', style: TextStyle(
                        color: Colors.indigo
                      ))),
                    ],
                    onChanged: (value){
                      setState((){
                        sortBy = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {

                final sortedItems = filteredProducts[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(sortedItems.icon, size: 40, color: Colors.indigo),
                    title: Text(
                      sortedItems.name, 
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo
                      )
                    ),
                    subtitle: Text(
                      sortedItems.description
                    ),
                    trailing: Text(
                      'Rs. ' + sortedItems.price.toStringAsFixed(2),
                    )
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Login Form
// void main() {
//   runApp(MyApp());
// }


// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isPasswordVisible = false, _isLoading = false;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   void _submitForm(){
//     if(_formKey.currentState!.validate()){
//       setState(() {
//         _isLoading = true;
//       });
//     }

//     // Simulate API call
//     Future.delayed(Duration(seconds: 2), (){
//       setState(() {
//         _isLoading = false;
//       });
//     });

    

//     // ScaffoldMessenger.of(
//     //   context,
//     // ).showSnackBar(SnackBar(content: Text('Login Successful')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.indigo,
//           foregroundColor: Colors.white,
//           title: Text(
//             'Login Form',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
                
//                 children: [
//                   SizedBox(height: 20,),
//                   Icon(Icons.person, size: 120, color: Colors.indigo),
//                   SizedBox(height: 20,),
              
//                   // Email Field
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       hintText: 'Enter you email',
//                       prefixIcon: Icon(Icons.email),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12)
                        
//                       ),
                      
//                     ),
//                     validator: (value){
//                       if(value == null || value.isEmpty){
//                         return 'Please enter your email';
//                       }
//                       if(!value.contains('@')){
//                         return 'Please enter valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20,),
//                   // Password Field
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: !_isPasswordVisible,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       hintText: 'Enter you password',
//                       prefixIcon: Icon(Icons.key),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off
//                         ),
//                         onPressed: (){
//                           setState(() {
//                             _isPasswordVisible = !_isPasswordVisible;
//                           });
//                         }
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12)
                        
//                       ),
                      
//                     ),
//                     validator: (value){
//                       if(value == null || value.isEmpty){
//                         return 'Please enter your password';
//                       }
//                       if(value.length < 8){
//                         return 'Password must be atleast 8 characters.';
//                       }
//                       return null;
//                     },
                    
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
          
//                   // Login Button
//                   ElevatedButton(
//                     onPressed: (){
//                       _submitForm();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.indigo,
//                       elevation: 5,
//                       padding: EdgeInsets.symmetric(horizontal: 130, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16)
//                       )
//                     ),
//                     // onPressed: null,
//                     child: 
//                     _isLoading? CircularProgressIndicator(
//                       color: Colors.white,
//                     ):
//                     Text(
//                       'Login',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                       )
                    
//                     ),
//                     SizedBox(height: 20,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('New here?'),
//                         SizedBox(width: 4,),
//                         Text('Register',
//                         style: TextStyle(
//                           fontStyle: FontStyle.italic
//                         ),
                        
//                     )
//                       ],
//                     ),
                    
          
//                 ],
//               ),
//             ),
//           ),
//         )
//       ),
//     );
//   }
// }




// class MyApp extends StatefulWidget{
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late int count;
//   late double price, total;

//   @override
//   void initState() {
//     super.initState();
//     count = 0;     // Initialize count to 0
//     price = 29.99; 
//     total = 0.0;  // Initialize price to 0.0
//   }

//   void calculateTotal() {
//     setState(() {
//       total = count * price; // Calculate total based on count and price
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.grey[200],
//         drawer: Drawer(
//           backgroundColor: Colors.grey[200],
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.indigo,
//                 ),
//                 child: Text(
//                   'Menu',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home, color: Colors.indigo),
//                 title: Text('Home'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings, color: Colors.indigo),
//                 title: Text('Settings'),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
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
//               child: Column(
//                 children: [
//                   SizedBox(width: 20),
//                   // Profile Picture
//                   Container(
//                     margin: EdgeInsets.only(top: 20),
//                     height: 200,
//                     width: 165,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26.withAlpha(40),
//                           spreadRadius: 2,
//                           blurRadius: 10,
//                           // offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.person,
//                           size: 80,
//                           color: Colors.blueGrey,
//                         ),
//                         SizedBox(height: 2),
//                         Text('Jonsen Gaire',
//                           style: TextStyle(
//                             color: Colors.black45,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           )),
//                         SizedBox(height: 1),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.email, color: Colors.blueGrey, size: 12),
//                             SizedBox(width: 2),
//                             Text('jonsen455@gmail.com',
//                               style: TextStyle(
//                                 color: Colors.black45,
//                                 fontSize: 8,
//                               )),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 5,),
//                   // Profile Description
//                   Container(
//                     height: 200,
//                     width: 320,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.rectangle,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26.withAlpha(40),
//                           spreadRadius: 2,
//                           blurRadius: 10,
//                           // offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
                      
              
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(height: 15),
//                         Text('Jonsen Gaire',
//                           style: TextStyle(
//                             color: Colors.indigo,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold
//                           )
//                         ),  
                         
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(width: 10),
//                             Icon(Icons.location_on, color: Colors.blueGrey, size: 20),
//                             // SizedBox(width: 10),
//                             Text('Nayagaun, Pokhara-15',
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 16,
//                               )),  
//                           ],
//                         ),
//                         // SizedBox(height: 2),
//                         SizedBox(width: 10),
//                         Container(
//                           // margin: EdgeInsets.only(left: 10, right: 10, top: 5),
//                           padding: EdgeInsets.only(left:10, right: 10),
//                           child: Text('a;lfalfalkfdka;lksjsfkjhaldkfj;alkfj;l',
//                               style: TextStyle(
//                               color: Colors.black54,
//                               fontSize: 16,
                              
//                             )
//                           ),
//                         ),  
//                         SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   count = 0; // Reset count to 0
//                                   total = 0.0; // Reset total to 0.0
//                                 });
//                               },
//                               child: Container(
//                                 width: 80,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                   color: Colors.indigo,
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 margin: EdgeInsets.only(left: 10, top: 10),
//                                 child: Text("Reset",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   if (count > 0) {
//                                     count--;
//                                     calculateTotal();
//                                   }
//                                 });
//                               },
//                               child: Container(
//                                 width: 30,
//                                 decoration: BoxDecoration(
//                                   color: Colors.indigo,
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 margin: EdgeInsets.only(left: 10, top: 10),
//                                 child: Text("-",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(left: 10, top: 10),
//                               child: Text(count.toString())
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   count++;
//                                   calculateTotal();
//                                 });
//                               },
//                               child: Container(
//                                 width: 30,
//                                 decoration: BoxDecoration(
//                                   color: Colors.indigo,
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 margin: EdgeInsets.only(left: 10, top: 10),
//                                 child: Text("+",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 )
//                               ),
//                             )
//                           ],
//                         )
                        
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 20, left: 10, right: 10),
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26.withAlpha(10),
//                           spreadRadius: 2,
//                           blurRadius: 10,
//                           // offset: Offset(0, 4),
//                         ),
                      
//                       ],
                      
//                     ),
//                     child: Row(
//                       children: [
//                         Text("Total:"),
//                         SizedBox(width: 10),
//                         Text(total.toString())                     ],
//                     ),
                    
//                   )
                  
//                 ],
//               ),
//             ),

//         ),
//       );
   
//   }
// }

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