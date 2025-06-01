import 'package:flutter/material.dart';
import 'letter_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categories = ['Alphabets', 'Numbers'];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ISL Dictionary',
          style: TextStyle(
            fontFamily: 'ComicSans',
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent.shade100,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.teal.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Let’s learn Indian Sign Language together!',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'ComicSans',
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Choose a Category:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'ComicSans',
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 700),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: categories
                      .map((category) => _CategoryTile(category: category))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatefulWidget {
  final String category;

  const _CategoryTile({required this.category});

  @override
  State<_CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<_CategoryTile> with TickerProviderStateMixin {
  late final AnimationController _wiggleController;
  late final Animation<Offset> _wiggleAnimation;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();

    _wiggleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _wiggleAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.05, 0),
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_wiggleController);
  }

  @override
  void dispose() {
    _wiggleController.dispose();
    super.dispose();
  }

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  void _handleTap(BuildContext context) async {
    await _wiggleController.forward(from: 0);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LetterListScreen(category: widget.category),
      ),
    );
  }

  Color _getColor() {
    return widget.category == 'Alphabets' ? Colors.purple : Colors.teal;
  }

  IconData _getIcon() {
    return widget.category == 'Alphabets' ? Icons.sort_by_alpha : Icons.looks_one;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final icon = _getIcon();

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: () => _handleTap(context),
      child: SlideTransition(
        position: _wiggleAnimation,
        child: AnimatedScale(
          scale: _scale,
          duration: Duration(milliseconds: 100),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.18),
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  widget.category,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ComicSans',
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
