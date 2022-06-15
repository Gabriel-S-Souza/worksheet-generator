import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/controllers/equipment_form/services_equipment_controller.dart';
import 'package:formulario_de_atendimento/default_values/default_values.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_outlined_buttom.dart';

import '../../widgets/custom_action_form_group.dart';
import '../../widgets/custom_radio_buttom_group.dart';
import '../../widgets/custom_text_area.dart';
import '../../widgets/custom_text_field.dart';
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
  final TextEditingController _controllerScrewCode = TextEditingController();
  final TextEditingController _controllerScrewSize = TextEditingController();
  final TextEditingController _controllerShimCode = TextEditingController();
  final TextEditingController _controllerShimSize = TextEditingController();
  final TextEditingController _controllerKnivesCode = TextEditingController();
  final TextEditingController _controllerKnivesSize = TextEditingController();
  final ServicesEquipmentController servicesEquipmentcontroller = ServicesEquipmentController();

  int quantityScrew = 1;
  int quantityShim = 1;
  int quantityknives = 1;
  ButtomQuantity buttomQuantityPressed = ButtomQuantity.none;
  
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
        child: Observer(
          builder: (context) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextLabel('Defeito/Causa'),
                  CustomTextArea(
                    hint: 'Descreva o defeito / causa',
                    onChanged: (value) => servicesEquipmentcontroller.defectCause = value,
                  ),
                  const CustomTextLabel('Serviço realizado'),
                  CustomTextArea(
                    hint: 'Descreva o serviço realizado',
                    onChanged: (value) => servicesEquipmentcontroller.serviceCarried = value,
                  ),
                  const CustomTextLabel('Foi utilizado óleo?'),
                  CustomRadioButtonGroup(
                    onChanged: (value) => servicesEquipmentcontroller.oilWasUsed = value!,
                    items: const <String> [YesNo.yes, YesNo.no], 
                    initialValue: YesNo.no,
                  ),
                  servicesEquipmentcontroller.oilWasUsed == YesNo.yes ? const CustomTextLabel('Óleo de motor utilizado') : const SizedBox(),
                  servicesEquipmentcontroller.oilWasUsed == YesNo.yes
                      ? CustomTextField(
                          hint: 'Óleo de motor',
                          obscure: false,
                          prefix: const Icon(Icons.oil_barrel),
                          onChanged: (value) => servicesEquipmentcontroller.motorOil = value,
                        )
                      : Container(),
                      servicesEquipmentcontroller.oilWasUsed == YesNo.yes 
                        ? const CustomTextLabel('Óleo hidráulico utilizado') : const SizedBox(),
                      servicesEquipmentcontroller.oilWasUsed == YesNo.yes 
                      ? CustomTextField(
                          hint: 'Óleo hidráulico',
                          obscure: false,
                          prefix: const Icon(Icons.oil_barrel),
                          onChanged: (value) => servicesEquipmentcontroller.hydraulicOil = value,
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
                      for(int i = 0; i < servicesEquipmentcontroller.screws.length ; i++)
                        _buildRow([
                          servicesEquipmentcontroller.screws[i][0], 
                          servicesEquipmentcontroller.screws[i][1], 
                          servicesEquipmentcontroller.screws[i][2],
                        ], 
                        index: i,
                        tableItens: TableItens.screws,
                      ),
                    ],
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(0.3),
                    },
                  ),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: CustomTextField(
                            controller: _controllerScrewCode,
                            hint: 'Código',
                            obscure: false,
                            contentPadding: const EdgeInsets.only(bottom: 15),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) => setState((){}), 

                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: CustomTextField(
                            controller: _controllerScrewSize,
                            hint: 'Tamanho',
                            obscure: false, 
                            contentPadding: const EdgeInsets.only(bottom: 15),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) => setState((){}), 

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
                        onPressed: _controllerScrewCode.text.isNotEmpty || _controllerScrewSize.text.isNotEmpty
                            ? () {
                              servicesEquipmentcontroller.screws.add([
                                _controllerScrewCode.text,
                                _controllerScrewSize.text,
                                _controllerQuantityScrew.text,
                              ]);
                              _controllerScrewCode.clear();
                              _controllerScrewSize.clear();
                            }
                            : null,
                        child: const Text('Adicionar'),
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
                      for(int i = 0; i < servicesEquipmentcontroller.shims.length ; i++)
                        _buildRow([
                          servicesEquipmentcontroller.shims[i][0], 
                          servicesEquipmentcontroller.shims[i][1], 
                          servicesEquipmentcontroller.shims[i][2],
                       ], 
                        index: i,
                        tableItens: TableItens.shims,
                      ),
                    ],
                     columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(0.3),
                    },
                  ),
                  const SizedBox(height: 48),
                   Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: CustomTextField(
                            controller: _controllerShimCode,
                            hint: 'Código',
                            obscure: false,
                            contentPadding: const EdgeInsets.only(bottom: 15),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) => setState((){}), 

                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: CustomTextField(
                            controller: _controllerShimSize,
                            hint: 'Tamanho',
                            obscure: false, 
                            contentPadding: const EdgeInsets.only(bottom: 15),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) => setState((){}), 

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
                        onPressed: _controllerShimCode.text.isNotEmpty || _controllerShimSize.text.isNotEmpty
                            ? () {
                              servicesEquipmentcontroller.shims.add([
                                _controllerShimCode.text,
                                _controllerShimSize.text,
                                _controllerQuantityShim.text,
                              ]);
                              _controllerShimCode.clear();
                              _controllerShimSize.clear();
                              }
                            : null,
                        child: const Text('Adicionar'),
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
                      _buildRow(['Código', 'Furação', 'Quantidade'], isHeader: true,),
                      for(int i = 0; i < servicesEquipmentcontroller.knives.length ; i++)
                        _buildRow([
                          servicesEquipmentcontroller.knives[i][0], 
                          servicesEquipmentcontroller.knives[i][1], 
                          servicesEquipmentcontroller.knives[i][2],
                        ], 
                        index: i,
                        tableItens: TableItens.knives,
                      ),
                    ],
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(0.3),
                    },
                  ),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: CustomTextField(
                            controller: _controllerKnivesCode,
                            hint: 'Código',
                            obscure: false,
                            contentPadding: const EdgeInsets.only(bottom: 15),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) => setState((){}), 
                            onSubmitted: () => FocusScope.of(context).nextFocus(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: CustomTextField(
                            controller: _controllerKnivesSize,
                            hint: 'Furação',
                            obscure: false, 
                            contentPadding: const EdgeInsets.only(bottom: 15),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) => setState((){}), 
                            onSubmitted: () => FocusScope.of(context).nextFocus(),
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
                        onPressed: _controllerKnivesCode.text.isNotEmpty || _controllerKnivesSize.text.isNotEmpty
                            ? () {
                              servicesEquipmentcontroller.knives.add([
                                _controllerKnivesCode.text,
                                _controllerKnivesSize.text,
                                _controllerQuantityknives.text,
                              ]);
                              _controllerKnivesCode.clear();
                              _controllerKnivesSize.clear();
                            }
                            : null,
                        child: const Text('Adicionar'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(thickness: 1),
                  const CustomTextLabel('Pendências'),
                  CustomTextArea(
                    hint: 'Descreva as pendências',
                    onChanged: (value) => servicesEquipmentcontroller.pendencies = value,
                    onSubmitted: () => FocusScope.of(context).unfocus(),
                  ),
                  const SizedBox(height: 32),
                  CustomActionButtonGroup(
                    primaryChild: !servicesEquipmentcontroller.isLoading
                        ? const Text('Salvar e avançar')
                        : const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
                    secondaryChild: const Text('Anterior'),
                    onSecondaryPressed: widget.onSecondaryPressed,
                    onPrimaryPressed: () async {
                      await servicesEquipmentcontroller.save();
                      widget.onPrimaryPressed?.call();
                    },
                    ),
                    const SizedBox(height: 20),
                  const SizedBox(height: 48),
                ],
              );
          }
        ),
      )
    );
  }

  TableRow _buildRow(List<String> cells, {bool isHeader = false, int? index, TableItens? tableItens}) {
    return TableRow(
      decoration: isHeader ? BoxDecoration(color: Colors.grey[200]) : null,
      children: [
        for(String cell in cells)
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Container(
              margin: isHeader ? const EdgeInsets.symmetric(vertical: 8) : null,
              child: AutoSizeText(
                cell, 
                textAlign: TextAlign.center, 
                maxFontSize: 16, 
                maxLines: 1,
                style: isHeader 
                    ? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold) : null,
              )
            )
          ),
          !isHeader
              ?  TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  iconSize: 20,
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (tableItens == TableItens.screws) {
                      servicesEquipmentcontroller.screws.removeAt(index!);
                    } else if(tableItens == TableItens.shims) {
                      servicesEquipmentcontroller.shims.removeAt(index!);
                    } else if(tableItens == TableItens.knives) {
                      servicesEquipmentcontroller.knives.removeAt(index!);
                    }
                  }, 
                ),
                )
              : TableCell(child: Container()),
      ],
    );
  }

  _buildQuantityField(ButtomQuantity buttomQuantityType, TextEditingController controller) {
    return SizedBox(
      width: 42,
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
              onLongPressEnd: (_) => buttomQuantityPressed = ButtomQuantity.none,
              child: Container(
                height: 28,
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
              onLongPressEnd: (_) => buttomQuantityPressed = ButtomQuantity.none,
              child: Container(
                height: 28,
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

enum TableItens {
  screws,
  shims,
  knives,
}