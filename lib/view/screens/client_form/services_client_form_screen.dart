import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/controllers/client_form/services_controller.dart';
import 'package:formulario_de_atendimento/default_values/default_values.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_text_label.dart';

import '../../widgets/custom_action_form_group.dart';
import '../../widgets/custom_radio_buttom_group.dart';
import '../../widgets/custom_suggestion_text_field.dart';
import '../../widgets/custom_text_area.dart';

class ServicesClientFormScreen extends StatefulWidget {
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  const ServicesClientFormScreen({
    Key? key, 
    required this.onPrimaryPressed, 
    required this.onSecondaryPressed}) : super(key: key);

  @override
  State<ServicesClientFormScreen> createState() => _ServicesClientFormScreenState();
}

class _ServicesClientFormScreenState extends State<ServicesClientFormScreen> {
  final ServicesController servicesController = ServicesController();
  late final FocusNode focusNodeCause;
  late final FocusNode focusNodeSolution;

  @override
  void initState() {
    super.initState();
    focusNodeCause = FocusNode();
    focusNodeSolution = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    focusNodeCause.dispose();
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
                const CustomTextLabel('Defeito'),
                CustomTextArea(
                  hint: 'Descreva o defeito',
                  onChanged: (value) => servicesController.defect = value,
                  onSubmitted: () => FocusScope.of(context).requestFocus(focusNodeCause),
                ),
                const CustomTextLabel('Causa'),
                CustomTextArea(
                  hint: 'Descreva a causa',
                  focusNode: focusNodeCause,
                  onChanged: (value) => servicesController.cause = value,
                  onSubmitted: () => FocusScope.of(context).requestFocus(focusNodeSolution),
                ),
                const CustomTextLabel('Solução'),
                CustomTextArea(
                  hint: 'Descreva a solução',
                  focusNode: focusNodeSolution,
                  onChanged: (value) => servicesController.solution = value,
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
                ),
                const CustomTextLabel('Foi utilizado óleo?'),
                CustomRadioButtonGroup(
                  onChanged: (value) => value != null ? servicesController.setOilWasUsed(value) : null,
                  items: const <String> [YesNo.yes, YesNo.no], 
                  initialValue: YesNo.no,
                  
                ),
                servicesController.oilWasUsed == YesNo.yes ? const CustomTextLabel('Óleo de motor utilizado') : const SizedBox(),
                servicesController.oilWasUsed == YesNo.yes
                    ? CustomSuggestionTextField(
                        hint: 'Óleo de motor',
                        obscure: false,
                        prefix: const Icon(Icons.oil_barrel),
                        onChanged: (value) => servicesController.motorOil = value,
                        onSubmitted: () => FocusScope.of(context).nextFocus(),
                        itemBuilder: (context, suggestion) {
                          return const ListTile(
                            title: Text('Suggestion'),
                          );
                        }, 
                        onSuggestionSelected: (object) {  }, 
                        suggestionsCallback: (value) => [],
                      )
                    : Container(),
                    servicesController.oilWasUsed == YesNo.yes 
                      ? const CustomTextLabel('Óleo hidráulico utilizado') : const SizedBox(),
                    servicesController.oilWasUsed == YesNo.yes 
                    ? CustomSuggestionTextField(
                        hint: 'Óleo hidráulico',
                        obscure: false,
                        prefix: const Icon(Icons.oil_barrel),
                        onChanged: (value) => servicesController.hydraulicOil = value,
                        onSubmitted: () => FocusScope.of(context).nextFocus(),
                        itemBuilder: (context, suggestion) {
                          return const ListTile(
                            title: Text('Suggestion'),
                          );
                        }, 
                        onSuggestionSelected: (object) {  }, 
                        suggestionsCallback: (value) => [],
                      )
                    : Container(),
                const CustomTextLabel('Situação'),
                CustomRadioButtonGroup(
                  onChanged: (value) => servicesController.situation = value,
                  items: const <String> [
                    Situation.released,
                    Situation.releasedWithRestrictions,
                    Situation.notReleased,
                    Situation.missingParts,
                  ], 
                  initialValue: Situation.released,
                ),
                const CustomTextLabel('Pendências'),
                 CustomTextArea(
                  hint: 'Descreva as pendências',
                  onChanged: (value) => servicesController.pendencies = value,
                ),
                const SizedBox(height: 32),
                CustomActionButtonGroup(
                  onPrimaryPressed:!servicesController.isLoading
                      ? () async {
                        
                          await servicesController.save();
        
                          widget.onPrimaryPressed();
                        }
                      : null,
                  onSecondaryPressed: widget.onSecondaryPressed,
                  secondaryChild: const Text('Anterior'),
                  primaryChild:!servicesController.isLoading
                          ? const Text('Salvar e avançar')
                          : const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(),
                          ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }
        ),
      ),
    );
  }
}