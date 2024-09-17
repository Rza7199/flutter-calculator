
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(surface: Colors.black), // Set the background color to black
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  void _calculateResult() {
    try {
      final expression = Expression.parse(_expression);
      const evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                _expression.isEmpty ? '0' : _expression,
                style: const TextStyle(fontSize: 24, color: Colors.white), // Set the font color to white
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                _result.isEmpty ? '0' : _result,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white), // Set the font color to white
              ),
            ),
          ),
            Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('+'),
            ],
            ),
            Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('-'),
            ],
            ),
            Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('*'),
            ],
            ),
            Row(
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('/'),
              
            ],
            ),
            Row(
              children: [
                _buildButton('%'),
              ]
            ),
    
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: _clearExpression,
                  child: const Text(
                    'C',
                    style: TextStyle(fontSize: 24, color: Colors.white), // Set the font color to white
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle, // Set the shape to circular
          color: Colors.grey, // Set the color to grey
        ),
        child: TextButton(
          onPressed: () {
            if (value == '=') {
              _calculateResult();
            } else {
              _addToExpression(value);
            }
          },
          child: Text(
            value,
            style: const TextStyle(fontSize: 24, color: Colors.white), // Set the font color to white
          ),
        ),
      ),
    );
  }
}