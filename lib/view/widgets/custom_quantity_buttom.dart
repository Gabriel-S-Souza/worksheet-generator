import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomQuantityButtom extends StatelessWidget {
  final VoidCallback? onIncrementTap;
  final VoidCallback? onDecrementTap;
  final void Function(dynamic)? onIncrementLongPressStart;
  final void Function(dynamic)? onDecrementLongPressStart;
  final void Function(dynamic)? onIncrementLongPressEnd;
  final void Function(dynamic)? onDecrementLongPressEnd;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomQuantityButtom({
    Key? key, 
    this.onIncrementTap, 
    this.onDecrementTap, 
    this.onIncrementLongPressStart, 
    this.onDecrementLongPressStart, 
    this.onIncrementLongPressEnd, 
    this.onDecrementLongPressEnd, 
    this.onChanged, 
    this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      width: 38,
      child: Column(
        children: [
          Material(
            color:  Colors.transparent,
            child: GestureDetector(
              onTap: onIncrementTap,
              onLongPressStart: onIncrementLongPressStart,
              onLongPressEnd: onIncrementLongPressEnd,
              child: Container(
                height: 20,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: Colors.grey[300],
                ),
                child: const Center(
                  child: Text('+', style: TextStyle(fontSize: 16),),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 34,
            width: 38,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              showCursor: false,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
                ),
              onChanged: onChanged,
            ),
          ),
          Material(
            color:  Colors.transparent,
            child: GestureDetector(
              onTap: onDecrementTap,
              onLongPressStart: onDecrementLongPressStart,
              onLongPressEnd: onDecrementLongPressEnd,
              child: Container(
                height: 20,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Colors.grey[300],
                ),
                child: const Center(
                  child: Text('-', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}