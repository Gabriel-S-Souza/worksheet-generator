import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_de_atendimento/default_values/default_values.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_outlined_buttom.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_suggestion_text_field.dart';

import '../../widgets/custom_action_form_group.dart';
import '../../widgets/custom_radio_buttom_group.dart';
import '../../widgets/custom_text_area.dart';
import '../../widgets/custom_text_label.dart';

class ServicesEquipmentScreen extends StatefulWidget {
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  const ServicesEquipmentScreen({
    Key? key, 
    this.onPrimaryPressed, 
    this.onSecondaryPressed}) : super(key: key);

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
  ButtomQuantity buttomQuantityPressed = ButtomQuantity.none;
  String oilWasUsed = YesNo.no;
  String? motorOil;
  String? hydraulicOil;
  
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
              const CustomTextLabel('Serviço realizado'),
              CustomTextArea(
                hint: 'Descreva o serviço realizado',
                onChanged: (value) => {},
              ),
              const CustomTextLabel('Foi utilizado óleo?'),
              CustomRadioButtonGroup(
                onChanged: (value) => setState(() => oilWasUsed = value!),
                items: const <String> [YesNo.yes, YesNo.no], 
                initialValue: YesNo.no,
              ),
              oilWasUsed == YesNo.yes ? const CustomTextLabel('Óleo de motor utilizado') : const SizedBox(),
              oilWasUsed == YesNo.yes
                  ? CustomSuggestionTextField(
                      hint: 'Óleo de motor',
                      obscure: false,
                      prefix: const Icon(Icons.oil_barrel),
                      onChanged: (value) => setState(()=> motorOil = value),
                      itemBuilder: (context, suggestion) {
                        return const ListTile(
                          title: Text('Suggestion'),
                        );
                      }, 
                      onSuggestionSelected: (object) {  }, 
                      suggestionsCallback: (value) => [],
                    )
                  : Container(),
                  oilWasUsed == YesNo.yes 
                    ? const CustomTextLabel('Óleo hidráulico utilizado') : const SizedBox(),
                  oilWasUsed == YesNo.yes 
                  ? CustomSuggestionTextField(
                      hint: 'Óleo hidráulico',
                      obscure: false,
                      prefix: const Icon(Icons.oil_barrel),
                      onChanged: (value) => setState(()=> hydraulicOil = value),
                      itemBuilder: (context, suggestion) {
                        return const ListTile(
                          title: Text('Suggestion'),
                        );
                      }, 
                      onSuggestionSelected: (object) {  }, 
                      suggestionsCallback: (value) => [],
                    )
                  : Container(),
              const CustomTextLabel('Material usado', marginTop: 40,),
              const CustomTextLabel(
                'Parafusos',
                marginTop: 16,
                marginBottom: 16,
                fontSize: 16,
              ),
              Table(
                children: [
                  _buildRow(['Código', 'Tamanho', 'Quantidade'], isHeader: true),
                  _buildRow(['123', '2', '1',]),
                  _buildRow(['123', '2', '1',]),
                  _buildRow(['123', '2', '1',]),
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
                        contentPadding: const EdgeInsets.only(bottom: 15),
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
                        contentPadding: const EdgeInsets.only(bottom: 15),
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
                  _buildQuantityField(ButtomQuantity.screw, _controllerQuantityScrew),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 170,
                  child: CustomOutlinedButtom(
                    child: const Text('Adicionar'),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const CustomTextLabel(
                'Calços',
                marginTop: 24,
                marginBottom: 16,
                fontSize: 16,
              ),
              Table(
                children: [
                  _buildRow(['Código', 'Tamanho', 'Quantidade'], isHeader: true),
                  _buildRow(['123', '2', '1',]),
                  _buildRow(['123', '2', '1',]),
                  _buildRow(['123', '2', '1',]),
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
                        contentPadding: const EdgeInsets.only(bottom: 15),
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
                        contentPadding: const EdgeInsets.only(bottom: 15),
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
                  _buildQuantityField(ButtomQuantity.shim, _controllerQuantityShim),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 170,
                  child: CustomOutlinedButtom(
                    child: const Text('Adicionar'),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const CustomTextLabel(
                'Facas',
                marginTop: 24,
                marginBottom: 16,
                fontSize: 16,
              ),
              Table(
                children: [
                  _buildRow(['Código', 'Furação', 'Quantidade'], isHeader: true),
                  _buildRow(['123', '2', '1',]),
                  _buildRow(['123', '2', '1',]),
                  _buildRow(['123', '2', '1',]),
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
                        contentPadding: const EdgeInsets.only(bottom: 15),
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
                        hint: 'Furação',
                        obscure: false, 
                        contentPadding: const EdgeInsets.only(bottom: 15),
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
                  _buildQuantityField(ButtomQuantity.knife, _controllerQuantityknives),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 170,
                  child: CustomOutlinedButtom(
                    child: const Text('Adicionar'),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const CustomTextLabel('Pendências'),
              CustomTextArea(
                hint: 'Descreva as pendências',
                onChanged: (value) => {},
              ),
              const SizedBox(height: 32),
              CustomActionButtonGroup(
                primaryChild: const Text('Salvar e avançar'),
                secondaryChild: const Text('Anterior'),
                onPrimaryPressed: widget.onPrimaryPressed,
                onSecondaryPressed: widget.onSecondaryPressed,
                ),
                const SizedBox(height: 20),
              const SizedBox(height: 48),
            ],
          ),
      )
    );
  }

  TableRow _buildRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: isHeader ? BoxDecoration(color: Colors.grey[200]) : null,
      children: cells.map((cell) {
        return AutoSizeText(cell, textAlign: TextAlign.center, maxFontSize: 16, maxLines: 1,);
      }).toList(),
    );
  }

  _buildQuantityField(ButtomQuantity buttomQuantityType, TextEditingController controller) {
    return SizedBox(
      width: 38,
      child: Column(
        children: [
          Material(
            color:  Colors.transparent,
            child: GestureDetector(
              onTap: () => _incrementQuantityScrew(buttomQuantityType, controller),
              onLongPressStart: (_) async {
                buttomQuantityPressed = buttomQuantityType;
                do {
                  _incrementQuantityScrew(buttomQuantityType, controller);
                  await Future.delayed(const Duration(milliseconds: 60));
                  } while (buttomQuantityPressed == buttomQuantityType);
                },
              onLongPressEnd: (_) => setState(() => buttomQuantityPressed = ButtomQuantity.none),
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
              onChanged: (value) {
                quantityScrew = int.tryParse(value) ?? quantityScrew;
              } 
            ),
          ),
          Material(
            color:  Colors.transparent,
            child: GestureDetector(
              onTap: () => _decrementQuantityScrew(buttomQuantityType, controller),
              onLongPressStart: (_) async {
                buttomQuantityPressed = buttomQuantityType;
                do {
                  _decrementQuantityScrew(buttomQuantityType, controller);
                  await Future.delayed(const Duration(milliseconds: 30));
                  } while (buttomQuantityPressed == buttomQuantityType);
                },
              onLongPressEnd: (_) => setState(() => buttomQuantityPressed = ButtomQuantity.none),
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

  void _incrementQuantityScrew(ButtomQuantity buttomQuantityType, TextEditingController controller) {
    if (controller.text.isEmpty) {
      if (buttomQuantityType == ButtomQuantity.screw) {
        quantityScrew = 1;
        controller.text = quantityScrew.toString();
      } 
      if (buttomQuantityType == ButtomQuantity.shim) {
        quantityShim = 1;
        controller.text = quantityShim.toString();
      } 
      if (buttomQuantityType == ButtomQuantity.knife) {
        quantityknives = 1;
        controller.text = quantityknives.toString();
      } 
    } else {
      if (buttomQuantityType == ButtomQuantity.screw) {
        quantityScrew += 1;
        controller.text = quantityScrew.toString();
      } 
      if (buttomQuantityType == ButtomQuantity.shim) {
        quantityShim += 1;
        controller.text = quantityShim.toString();
      } 
      if (buttomQuantityType == ButtomQuantity.knife) {
        quantityknives += 1;
        controller.text = quantityknives.toString();
      } 
    }
  }

  void _decrementQuantityScrew(ButtomQuantity buttomQuantityType, TextEditingController controller) {
    if (controller.text != '') {
      if (buttomQuantityType == ButtomQuantity.screw) {
        quantityScrew > 0 ? quantityScrew -= 1 : null;
        controller.text = quantityScrew.toString();
      } 
      if (buttomQuantityType == ButtomQuantity.shim) {
        quantityShim > 0 ? quantityShim -= 1 : null;
        controller.text = quantityShim.toString();
      } 
      if (buttomQuantityType == ButtomQuantity.knife) {
        quantityknives > 0 ? quantityknives -= 1 : null;
        controller.text = quantityknives.toString();
      } 
    }
  }
}

enum ButtomQuantity {
  screw,
  shim,
  knife,
  none
}