import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2DFDB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2DFDB),
        elevation: 0,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: 'ASL',
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            children: const <TextSpan>[
              TextSpan(
                text: 'kids',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('categories')
            .orderBy('order')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = snapshot.data!.docs;

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final name = category['name'];
              final total = category['total'] ?? 0;
              final iconPath = category['icon'];
              final color = Color((category['color'] ?? 0xFFFFFFFF));

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: iconPath != null
                      ? Image.asset(iconPath, height: 40)
                      : const Icon(Icons.category, size: 40),
                  title: Text(
                    "$name",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  subtitle: Text("0/$total",
                      style: const TextStyle(color: Colors.white70)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SignListScreen(categoryId: category.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF80CBC4),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black87,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.gesture),
            label: 'Signs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sort_by_alpha),
            label: 'ABC',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class SignListScreen extends StatelessWidget {
  final String categoryId;

  const SignListScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryId)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .collection('signs')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final signs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: signs.length,
            itemBuilder: (context, index) {
              final sign = signs[index];
              return ListTile(
                title: Text(sign['label']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignDetailScreen(
                        label: sign['label'],
                        mediaUrl: sign['mediaUrl'],
                        type: sign['type'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class SignDetailScreen extends StatelessWidget {
  final String label, mediaUrl, type;

  const SignDetailScreen({
    Key? key,
    required this.label,
    required this.mediaUrl,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(
        child: type == 'video'
            ? Text("Video player placeholder for $mediaUrl") // Replace later
            : Image.network(mediaUrl),
      ),
    );
  }
}
