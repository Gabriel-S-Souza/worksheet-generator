import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_suggestion_text_field.dart';

import '../../widgets/custom_text_area.dart';
import '../../widgets/custom_text_label.dart';

class ServicesEquipmentScreen extends StatefulWidget {
  const ServicesEquipmentScreen({Key? key}) : super(key: key);

  @override
  State<ServicesEquipmentScreen> createState() => _ServicesEquipmentScreenState();
}

class _ServicesEquipmentScreenState extends State<ServicesEquipmentScreen> {
  final TextEditingController _controllerQuantityScrew = TextEditingController();
  final TextEditingController _controllerQuantityShim = TextEditingController();
  final TextEditingController _controllerQuantityknives = TextEditingController();
  int quantityScrew = 1;
  int quantityShim = 1;
  int quantityknives = 1;
  bool isPressed = false;
  
  @override
  void initState() {
    super.initState();
    _controllerQuantityScrew.text = quantityScrew.toString();
    _controllerQuantityShim.text = quantityShim.toString();
    _controllerQuantityknives.text = quantityknives.toString();
  }

  @override
  void dispose() {
    _controllerQuantityScrew.dispose();
    _controllerQuantityShim.dispose();
    _controllerQuantityknives.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextLabel('Defeito/Causa'),
              CustomTextArea(
                hint: 'Descreva o defeito / causa',
                onChanged: (value) => {},
              ),
              const CustomTextLabel('Solução'),
              CustomTextArea(
                hint: 'Descreva a solução',
                onChanged: (value) => {},
              ),
              const CustomTextLabel('Material usado'),
              const CustomTextLabel(
                'Parafusos',
                marginTop: 16,
                marginBottom: 16,
                fontSize: 16,
              ),
              Table(
                children: [
                  _buildRow(['Código', 'Tamanho', 'Quantidade'], isHeader: true),
                  _buildRow(['1', '1/2', '1',]),
                ],
              ),
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: CustomSuggestionTextField(
                        hint: 'Código',
                        obscure: false,
                        style: const TextStyle(fontSize: 14),
                        onChanged: (value) {}, 
                        onSuggestionSelected: (object) {},
                        suggestionsCallback: (value) => [], 
                        itemBuilder: (context, suggestion) {
                          return const ListTile(
                            title: Text('Suggestion', style: TextStyle(fontSize: 14),),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: CustomSuggestionTextField(
                        hint: 'Tamanho',
                        obscure: false, 
                        style: const TextStyle(fontSize: 14),
                        onChanged: (value) {}, 
                        onSuggestionSelected: (object) {},
                        suggestionsCallback: (value) => [], 
                        itemBuilder: (context, suggestion) {
                          return const ListTile(
                            title: Text('Suggestion', style: TextStyle(fontSize: 14),),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildQuantityField(),
                ],
              ),
              const CustomTextLabel(
                'Calços',
                marginTop: 24,
                marginBottom: 16,
                fontSize: 16,
              ),
              Table(
                children: [
                  _buildRow(['Código', 'Tamanho', 'Quantidade'], isHeader: true),
                  _buildRow(['1', '1/2', '1',]),
                ],
              ),
              const CustomTextLabel(
                'Facas',
                marginTop: 24,
                marginBottom: 16,
                fontSize: 16,
              ),
              Table(
                children: [
                  _buildRow(['Código', 'Furação', 'Quantidade'], isHeader: true),
                  _buildRow(['1', '1/2', '1',]),
                ],
              ),
            ],
          ),
      )
    );
  }

  TableRow _buildRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: isHeader ? BoxDecoration(color: Colors.grey[200]) : null,
      children: cells.map((cell) {
        return Text(cell, textAlign: TextAlign.center,);
      }).toList(),
    );
  }

  _buildQuantityField() {
    return SizedBox(
      width: 38,
      child: Column(
        children: [
          Material(
            color:  Colors.transparent,
            child: GestureDetector(
              onTap: _incrementQuantityScrew,
              onLongPressStart: (_) async {
                isPressed = true;
                do {
                  _incrementQuantityScrew();
                  await Future.delayed(const Duration(milliseconds: 60));
                  } while (isPressed);
                },
              onLongPressEnd: (_) => setState(() => isPressed = false),
              child: Container(
                height: 20,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: Colors.grey[200],
                ),
                child: const Center(
                  child: Text('+'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 34,
            child: TextField(
              controller: _controllerQuantityScrew,
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
              onChanged: (value) {
                quantityScrew = int.tryParse(value) ?? quantityScrew;
              } 
            ),
          ),
          Material(
            color:  Colors.transparent,
            child: GestureDetector(
              onTap: _decrementQuantityScrew,
              onLongPressStart: (_) async {
                isPressed = true;
                do {
                  _decrementQuantityScrew();
                  await Future.delayed(const Duration(milliseconds: 30));
                  } while (isPressed);
                },
              onLongPressEnd: (_) => setState(() => isPressed = false),
              child: Container(
                height: 20,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Colors.grey[200],
                ),
                child: const Center(
                  child: Text('-'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _incrementQuantityScrew() {
    if (_controllerQuantityScrew.text.isEmpty) {
      quantityScrew = 1;
    } else {
      quantityScrew += 1;
    }
    _controllerQuantityScrew.text = quantityScrew.toString();
  }

  void _decrementQuantityScrew() {
    if (quantityScrew > 0) {
      quantityScrew -= 1;
      _controllerQuantityScrew.text = quantityScrew.toString();
    }
  }
}