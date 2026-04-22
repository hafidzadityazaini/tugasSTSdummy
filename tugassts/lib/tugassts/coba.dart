import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Belajar extends StatefulWidget {
  const Belajar({super.key});

  @override
  State<Belajar> createState() => _HttpApiState();
}

class _HttpApiState extends State<Belajar> {
  List data = [];
  bool isLoading = true;

  Future ambilData() async {
    // Menambahkan limit=10 sesuai instruksi soal
    var response = await http.get(Uri.parse('https://dummyjson.com/products?limit=10'));

    if (response.statusCode == 200) {
      var hasil = jsonDecode(response.body);
      setState(() {
        data = hasil['products'];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
  super.initState();
  ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Icon(  
                Icons.shopping_cart,
                size: 50,
                color: Colors.blue,
              ),
        centerTitle: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, 
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              item['thumbnail'], 
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              
                              const SizedBox(height: 4),
                              
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${item['rating']}",
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 8),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${item['price']}",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "Stok ${item['stock']}",
                                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}