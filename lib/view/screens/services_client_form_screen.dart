import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_text_label.dart';

import '../widgets/custom_action_form_group.dart';
import '../widgets/custom_radio_buttom_group.dart';
import '../widgets/custom_suggestion_text_field.dart';
import '../widgets/custom_text_area.dart';

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
  bool oilWasUsed = true;
  
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextLabel('Defeito'),
            CustomTextArea(
              hint: 'Descreva o defeito',
              onChanged: (value) {},
            ),
            const CustomTextLabel('Causa'),
            CustomTextArea(
              hint: 'Descreva a causa',
              onChanged: (value) {},
            ),
            const CustomTextLabel('Solução'),
            CustomTextArea(
              hint: 'Descreva a solução',
              onChanged: (value) {},
            ),
            const CustomTextLabel('Foi utilizado óleo?'),
            CustomRadioButtonGroup(
              onChanged: (value) {
                if (value == 'Não') {
                  setState(() => oilWasUsed = false);
                } else {
                  setState(() => oilWasUsed = true);
                }
              },
              items: const <String> ['Sim', 'Não'], 
              initialValue: 'Sim',
              
            ),
            oilWasUsed ? const CustomTextLabel('Óleo de motor utilizado') : const SizedBox(),
            oilWasUsed 
                ? CustomSuggestionTextField(
                    hint: 'Nome do óleo',
                    obscure: false,
                    prefix: const Icon(Icons.oil_barrel),
                    onChanged: (value) => {},
                    itemBuilder: (context, suggestion) {
                      return const ListTile(
                        title: Text('Suggestion'),
                      );
                    }, 
                    onSuggestionSelected: (object) {  }, 
                    suggestionsCallback: (value) => [],
                  )
                : Container(),
            oilWasUsed ? const CustomTextLabel('Óleo hidráulico utilizado') : const SizedBox(),
            oilWasUsed 
                ? CustomSuggestionTextField(
                    hint: 'Nome do óleo',
                    obscure: false,
                    prefix: const Icon(Icons.oil_barrel),
                    onChanged: (value) => {},
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
              onChanged: (value) {},
              items: const <String> ['Liberado', 'Liberado com restrições', 'Não liberado', 'Falta peças'], 
              initialValue: 'Liberado',
            ),
            const CustomTextLabel('Pendências'),
             CustomTextArea(
              hint: 'Descreva as pendências',
              onChanged: (value) {},
            ),
            const SizedBox(height: 32),
            CustomActionButtonGroup(
              primaryChild: const Text('Salvar e avançar'),
              secondaryChild: const Text('Anterior'),
              onPrimaryPressed: widget.onPrimaryPressed,
              onSecondaryPressed: widget.onSecondaryPressed,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}