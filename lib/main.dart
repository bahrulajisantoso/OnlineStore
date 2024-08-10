import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grocery_ui/item_widget.dart';

import 'bloc/product_bloc.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetProductEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: const Text(
          'Online Store',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.black,
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 3,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          "2",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      // body: BlocBuilder<ProductBloc, ProductState>(
      //   builder: (context, state) {
      //     if (state is ProductLoading) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     if (state is ProductSuccess) {
      //       return Container(
      //         padding: const EdgeInsets.all(10),
      //         child: GridView.builder(
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             mainAxisSpacing: 10,
      //             crossAxisSpacing: 10,
      //             crossAxisCount: 2,
      //             childAspectRatio: 0.65,
      //           ),
      //           itemBuilder: (context, index) {
      //             return ItemWidget(product: state.products[index]);
      //           },
      //           itemCount: state.products.length,
      //         ),
      //       );
      //     }
      //     return const Center(
      //       child: Text('No Data'),
      //     );
      //   },
      // ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductSuccess) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, bottom: 20.0), // Tambahkan margin di kiri
                  alignment: Alignment.centerLeft, // Teks berada di sisi kiri
                  child: const Text(
                    "My Home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage(
                            "assets/banner.png",
                          ),
                          fit: BoxFit.cover)),
                ),

                // Daftar produk menggunakan GridView
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        return ItemWidget(product: state.products[index]);
                      },
                      itemCount: state.products.length,
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text('No Data'),
          );
        },
      ),
    );
  }
}
