import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  final int itemcount;
  const Board({required Key key,required this.itemcount}):super(key: key);
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final List<List<String>> _board = List.generate(3, (_) => List.filled(3, ''));

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        int row = index ~/ 3;
        int col = index % 3;
        return GestureDetector(
          onTap: () => _handleTap(row, col),
          child: Container(
            color: Colors.orangeAccent,
            child: Center(
              child: Text(_board[row][col]),
            ),
          ),
        );
      },
    );
  }

  void _handleTap(int row, int col) {
    if (_board[row][col] == '') {
      setState(() {
        _board[row][col] = 'X';
      });
    }
  }
}

