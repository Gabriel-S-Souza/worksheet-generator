import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_app_buttom.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_quantity_buttom.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_text_label.dart';

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

  late int countPiracicaba;
  late int countIracemapolis;
  ButtomQuantityOS buttomCountPressed = ButtomQuantityOS.none;
  String year = '2022';
  String piracicabaSufix = 'PIRACI';
  String iracemapolisSufix = 'IRACE';

  @override
  void initState() {
    super.initState();
    countPiracicaba = 0;
    countIracemapolis = 0;
    piracicabaCountController.text = '00';
    iracemapolisCountController.text = '00';
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
                          year,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CustomQuantityButtom(
                          controller: piracicabaCountController,
                          onChanged: (value) {
                            countPiracicaba = int.tryParse(value) ?? countPiracicaba;
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
                        child: _buildInput(piracicabaSufix, controller: piracicabaSufixController,),
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
                          year,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CustomQuantityButtom(
                          controller: iracemapolisCountController,
                          onChanged: (value) {
                            countIracemapolis = int.tryParse(value) ?? countIracemapolis;
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
                        child: _buildInput(iracemapolisSufix, controller: iracemapolisSufixController,),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const CustomAppButtom(
                child: Text('Salvar'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      )
    );
  }

  _buildInput(String value, {bool readOnly = false, TextEditingController? controller}) {
    final TextEditingController internalController = controller ?? TextEditingController();
    internalController.text = value;
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 34,
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: internalController,
        readOnly: readOnly,
        textAlign: TextAlign.center,
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
        } 
        if (buttom == ButtomQuantityOS.iracemapolis) {
          countIracemapolis = 1;
          controller.text = countIracemapolis < 10 ? '0$countIracemapolis' : '$countIracemapolis';
        } 
      } else {
        if (buttom == ButtomQuantityOS.piracicaba) {
          countPiracicaba += 1;
          controller.text = countPiracicaba < 10 ? '0$countPiracicaba' : '$countPiracicaba';
        } 
        if (buttom == ButtomQuantityOS.iracemapolis) {
          countIracemapolis += 1;
          controller.text = countIracemapolis < 10 ? '0$countIracemapolis' : '$countIracemapolis';
        } 
      }
    });
  }

  void _decrementQuantity(ButtomQuantityOS buttom, TextEditingController controller) {
    if (controller.text != '') {
      if (buttom == ButtomQuantityOS.piracicaba) {
        countPiracicaba > 0 ? countPiracicaba -= 1 : null;
        controller.text = countPiracicaba < 10 ? '0$countPiracicaba' : '$countPiracicaba';
      } 
      if (buttom == ButtomQuantityOS.iracemapolis) {
        countIracemapolis > 0 ? countIracemapolis -= 1 : null;
        controller.text = countIracemapolis < 10 ? '0$countIracemapolis' : '$countIracemapolis';;
      }
    }
  }
}

enum ButtomQuantityOS {
  piracicaba,
  iracemapolis,
  none
}