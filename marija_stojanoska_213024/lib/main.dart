import 'package:flutter/material.dart';

void main() {
  runApp(const ClothingApp());
}

class ClothingApp extends StatelessWidget {
  const ClothingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothing App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> clothingItems = [
    {
      'name': 'T-shirt',
      'image': 'https://isto.pt/cdn/shop/files/Heavyweight_Black_9d4ec64c-a182-4c3e-982d-82bb5fa41309.webp?v=1726246216',
      'description': 'Cotton short sleeve',
      'price': '500 den',
    },
    {
      'name': 'Shorts',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgiWx8eQ16kC3tRGcs3cibUTLuIXcAd_DTqw&s',
      'description': 'Texas knee height',
      'price': '1500 den',
    },
    {
      'name': 'Dress',
      'image': 'https://www.ubuy.mk/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNTFKcEE0T2x1NEwuX0FDX1VMMTE1N18uanBn.jpg',
      'description': 'Summer short',
      'price': '2500 den',
    },
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('213024'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.pink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: clothingItems.length,
          itemBuilder: (context, index) {
            final item = clothingItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(item: item),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                color: Colors.white,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        item['image'],
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(item['image'], height: 200, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                item['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                item['description'],
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                'Price: ${item['price']}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
