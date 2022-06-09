import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/controllers/client_form/basic_informations_controller.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_app_buttom.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_quantity_buttom.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_text_label.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/data_access_object.dart';
import '../../default_values/default_values.dart';

class OSScreen extends StatefulWidget {
  const OSScreen({Key? key}) : super(key: key);

  @override
  State<OSScreen> createState() => _OSScreenState();
}

class _OSScreenState extends State<OSScreen> {
  final TextEditingController piracicabaCountController = TextEditingController();

  final TextEditingController iracemapolisCountController = TextEditingController();

  final TextEditingController piracicabaSufixController = TextEditingController();

  final TextEditingController iracemapolisSufixController = TextEditingController();

  final BasicInformaTionsController basicInformationsController = GetIt.I.get<BasicInformaTionsController>(instanceName: DefaultKeys.basicInfoControllerClient);
  final Box<dynamic> osBox = GetIt.I.get<Box<dynamic>>(instanceName: DefaultBoxes.os);

  late int countPiracicaba;
  late int countIracemapolis;
  ButtomQuantityOS buttomCountPressed = ButtomQuantityOS.none;
  String year = DateTime.now().year.toString();
  late String piracicabaSufix;
  late String iracemapolisSufix;

  bool isChanged = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getInputValues();
    piracicabaSufixController.text = osBox.get(DefaultKeys.piracicabaSufix);
    iracemapolisSufixController.text = osBox.get(DefaultKeys.iracemapolisSufix);
  }

  @override
  void dispose() {
    piracicabaCountController.dispose();
    iracemapolisCountController.dispose();
    piracicabaSufixController.dispose();
    iracemapolisSufixController.dispose();
    super.dispose();
  }

  Future<void> _updateOs() async {
    isLoading = true;
    await osBox.put(DefaultKeys.osPiracicaba, countPiracicaba);
    await osBox.put(DefaultKeys.osIracemapolis, countIracemapolis);
    await osBox.put(DefaultKeys.piracicabaSufix, piracicabaSufixController.text);
    await osBox.put(DefaultKeys.iracemapolisSufix, iracemapolisSufixController.text);
    isLoading = false;
    isChanged = false;
    basicInformationsController.generateOs();
    _getInputValues();
  }

  void _getInputValues() {
    setState(() {
      countPiracicaba = osBox.get(DefaultKeys.osPiracicaba);
      countIracemapolis = osBox.get(DefaultKeys.osIracemapolis);
      piracicabaCountController.text = countPiracicaba < 10 ? '0$countPiracicaba' : countPiracicaba.toString();
      iracemapolisCountController.text = countIracemapolis < 10 ? '0$countIracemapolis' : countIracemapolis.toString();
      piracicabaSufix = osBox.get(DefaultKeys.piracicabaSufix);
      iracemapolisSufix = osBox.get(DefaultKeys.iracemapolisSufix);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar O.S.'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomTextLabel('Piracicaba'),
              const SizedBox(height: 20),
              Table(
                children: [
                  const TableRow(
                    children: [
                      AutoSizeText(
                        'Prefixo',  
                        maxLines: 1, 
                        minFontSize: 16,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      AutoSizeText(
                        'Contador',  
                        maxLines: 1, 
                        minFontSize: 16,
                       textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        'Sufixo', 
                        textAlign: TextAlign.center, 
                        maxLines: 2, 
                        minFontSize: 16,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _buildInput(
                          value: year,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CustomQuantityButtom(
                          controller: piracicabaCountController,
                          onChanged: (value) {
                            countPiracicaba = int.tryParse(value) ?? countPiracicaba;
                            isChanged = true;
                          },
                          onIncrementTap: () =>  _incrementQuantity(ButtomQuantityOS.piracicaba, piracicabaCountController),
                          onDecrementTap: () => _decrementQuantity(ButtomQuantityOS.piracicaba, piracicabaCountController),
                          onIncrementLongPressStart: (_) async {
                            buttomCountPressed = ButtomQuantityOS.piracicaba;
                            do {
                              _incrementQuantity(ButtomQuantityOS.piracicaba, piracicabaCountController);
                              await Future.delayed(const Duration(milliseconds: 30));
                              } while (buttomCountPressed == ButtomQuantityOS.piracicaba);
                            },
                            onIncrementLongPressEnd: (_) => setState(() => buttomCountPressed = ButtomQuantityOS.none),
                            onDecrementLongPressStart: (_)  async {
                              buttomCountPressed = ButtomQuantityOS.piracicaba;
                              do {
                                _decrementQuantity(ButtomQuantityOS.piracicaba, piracicabaCountController);
                                await Future.delayed(const Duration(milliseconds: 30));
                                } while (buttomCountPressed == ButtomQuantityOS.piracicaba);
                              },
                            onDecrementLongPressEnd: (_) => setState(() => buttomCountPressed = ButtomQuantityOS.none),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _buildInput(
                          controller: piracicabaSufixController,
                          onChanged: (value) {
                            setState(() {
                              isChanged = value != osBox.get(DefaultKeys.piracicabaSufix);
                            });
                          } 
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const CustomTextLabel('Iracemápolis'),
              const SizedBox(height: 20),
              Table(
                children: [
                  const TableRow(
                    children: [
                      AutoSizeText(
                        'Prefixo',  
                        maxLines: 1, 
                        minFontSize: 16,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      AutoSizeText(
                        'Contador',  
                        maxLines: 1, 
                        minFontSize: 16,
                       textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        'Sufixo', 
                        textAlign: TextAlign.center, 
                        maxLines: 2, 
                        minFontSize: 16,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _buildInput(
                          value: year,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CustomQuantityButtom(
                          controller: iracemapolisCountController,
                          onChanged: (value) {
                            countIracemapolis = int.tryParse(value) ?? countIracemapolis;
                            isChanged = true;
                          },
                          onIncrementTap: () =>  _incrementQuantity(ButtomQuantityOS.iracemapolis, iracemapolisCountController),
                          onDecrementTap: () => _decrementQuantity(ButtomQuantityOS.iracemapolis, iracemapolisCountController),
                          onIncrementLongPressStart: (_) async {
                            buttomCountPressed = ButtomQuantityOS.iracemapolis;
                            do {
                              _incrementQuantity(ButtomQuantityOS.iracemapolis, iracemapolisCountController);
                              await Future.delayed(const Duration(milliseconds: 30));
                              } while (buttomCountPressed == ButtomQuantityOS.iracemapolis);
                            },
                            onIncrementLongPressEnd: (_) => setState(() => buttomCountPressed = ButtomQuantityOS.none),
                            onDecrementLongPressStart: (_)  async {
                              buttomCountPressed = ButtomQuantityOS.iracemapolis;
                              do {
                                _decrementQuantity(ButtomQuantityOS.iracemapolis, iracemapolisCountController);
                                await Future.delayed(const Duration(milliseconds: 30));
                                } while (buttomCountPressed == ButtomQuantityOS.iracemapolis);
                              },
                            onDecrementLongPressEnd: (_) => setState(() => buttomCountPressed = ButtomQuantityOS.none),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _buildInput(
                          controller: iracemapolisSufixController,
                          onChanged: (value) {
                            setState(() {
                              isChanged = value != osBox.get(DefaultKeys.iracemapolisSufix);
                            });
                          }
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CustomAppButtom(
                onPressed: isChanged
                    ? () async {
                        _updateOs()
                            .then((value) => _buildSnackBar(context, 'OS atualizado!'));
                      }
                    : null,
                child: !isLoading 
                    ? const Text('Salvar')
                    : const CircularProgressIndicator(),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      )
    );
  }

  _buildInput({
    String? value, 
    bool readOnly = false, 
    TextEditingController? controller,
    void Function(String)? onChanged
  }) {
    controller ??= TextEditingController(text: value);

    return Container(
      constraints: const BoxConstraints(
        maxHeight: 34,
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 10, top: 10),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  _incrementQuantity(ButtomQuantityOS buttom, TextEditingController controller) {
    setState(() {
      if (controller.text.isEmpty) {
        if (buttom == ButtomQuantityOS.piracicaba) {
          countPiracicaba = 1;
          controller.text = countPiracicaba < 10 ? '0$countPiracicaba' : '$countPiracicaba';
          isChanged = countPiracicaba != osBox.get(DefaultKeys.osPiracicaba);
        } 
        if (buttom == ButtomQuantityOS.iracemapolis) {
          countIracemapolis = 1;
          controller.text = countIracemapolis < 10 ? '0$countIracemapolis' : '$countIracemapolis';
          isChanged = countIracemapolis != osBox.get(DefaultKeys.osIracemapolis);
        } 
      } else {
        if (buttom == ButtomQuantityOS.piracicaba) {
          countPiracicaba += 1;
          controller.text = countPiracicaba < 10 ? '0$countPiracicaba' : '$countPiracicaba';
          isChanged = countPiracicaba != osBox.get(DefaultKeys.osPiracicaba);
        } 
        if (buttom == ButtomQuantityOS.iracemapolis) {
          countIracemapolis += 1;
          controller.text = countIracemapolis < 10 ? '0$countIracemapolis' : '$countIracemapolis';
          isChanged = countIracemapolis != osBox.get(DefaultKeys.osIracemapolis);
        } 
      }
    });
  }

  void _decrementQuantity(ButtomQuantityOS buttom, TextEditingController controller) {
    
    if (controller.text != '') {
      setState(() {
        if (buttom == ButtomQuantityOS.piracicaba) {
          countPiracicaba > 0 ? countPiracicaba -= 1 : null;
          controller.text = countPiracicaba < 10 ? '0$countPiracicaba' : '$countPiracicaba';
          isChanged = countPiracicaba != osBox.get(DefaultKeys.osPiracicaba);
        } 
        if (buttom == ButtomQuantityOS.iracemapolis) {
          countIracemapolis > 0 ? countIracemapolis -= 1 : null;
          controller.text = countIracemapolis < 10 ? '0$countIracemapolis' : '$countIracemapolis';
          isChanged = countIracemapolis != osBox.get(DefaultKeys.osIracemapolis);
        }
    });
    }
  }

  _buildSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.only(bottom: 60),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}

enum ButtomQuantityOS {
  piracicaba,
  iracemapolis,
  none
}