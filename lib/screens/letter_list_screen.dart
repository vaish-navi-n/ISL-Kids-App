import 'dart:math';
import 'package:flutter/material.dart';
import 'video_screen.dart';

class LetterListScreen extends StatelessWidget {
  final String category;

  const LetterListScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final letters = category == 'Alphabets'
        ? List.generate(26, (index) => String.fromCharCode(65 + index))
        : List.generate(15, (index) => (index + 1).toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Learn the $category',
          style: TextStyle(
            fontFamily: 'Bahnschrift',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent.shade100,
        elevation: 4,
      ),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: letters.map((label) => _BouncyTile(label: label)).toList(),
        ),
      ),
    );
  }
}

class _BouncyTile extends StatefulWidget {
  final String label;

  const _BouncyTile({required this.label});

  @override
  State<_BouncyTile> createState() => _BouncyTileState();
}

class _BouncyTileState extends State<_BouncyTile> with TickerProviderStateMixin {
  double _scale = 1.0;
  late final AnimationController _wiggleController;
  late final Animation<Offset> _wiggleAnimation;

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
        builder: (_) => VideoScreen(label: widget.label),
      ),
    );
  }

  List<Color> _getRandomGradient(String seed) {
    final random = Random(seed.hashCode);
    final baseColors = Colors.primaries;
    final first = baseColors[random.nextInt(baseColors.length)].withOpacity(0.4);
    final second = baseColors[random.nextInt(baseColors.length)].withOpacity(0.4);
    return [first, second];
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getRandomGradient(widget.label);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: () => _handleTap(context),
      child: SlideTransition(
        position: _wiggleAnimation,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: gradientColors.first.withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(4, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: 'Bahnschrift',
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
