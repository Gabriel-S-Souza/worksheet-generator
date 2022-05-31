import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_suggestion_text_field.dart';
import 'package:formulario_de_atendimento/view/widgets/cutom_icon_button.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_action_form_group.dart';
import '../widgets/custom_radio_buttom_group.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_text_label.dart';

class BasicInformationsClienteFormScreen extends StatefulWidget {
  final VoidCallback onPrimaryPressed;
  const BasicInformationsClienteFormScreen({Key? key, required this.onPrimaryPressed}) : super(key: key);

  @override
  State<BasicInformationsClienteFormScreen> createState() => _BasicInformationsClienteFormScreenState();
}

class _BasicInformationsClienteFormScreenState extends State<BasicInformationsClienteFormScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController requesterController = TextEditingController();
  late String date;

  @override
  void initState() {
    super.initState();
    date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dateController.text = date;
    requesterController.text = 'Alan';
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            const CustomTextLabel('Data'),
            CustomTextField(
              controller: dateController,
              onChanged: (value) {},
              suffix: CustomIconButton(
                radius: 32, 
                iconData: Icons.edit_calendar, 
                onTap: () => _selectDate(context),
              ),
            ),
            const CustomTextLabel('Local de atendimento'),
            CustomTextField(
              hint: 'Local de atendimento',
              obscure: false,
              onChanged: (value) {},
              prefix: const Icon(Icons.location_on),
            ),
            const CustomTextLabel('O.S.'),
            CustomTextField(
              hint: 'O.S.',
              obscure: false, 
              onChanged: (value) {},
              prefix: const Icon(Icons.info),
            ),
            const CustomTextLabel('Solicitado por'),
            CustomSuggestionTextField(
              controller: requesterController,
              obscure: false, 
              onChanged: (value) {},
              prefix: const Icon(Icons.person), 
              itemBuilder: (context, suggestion) {
                return const ListTile(
                  title: Text('Suggestion'),
                );
              }, 
              onSuggestionSelected: (object) {  }, 
              suggestionsCallback: (value) => [],
            ),
            const CustomTextLabel('Atendido por'),
            CustomSuggestionTextField(
              hint: 'Nome do atendente',
              obscure: false, 
              onChanged: (value) {},
              prefix: const Icon(Icons.person), 
              itemBuilder: (context, suggestion) {
                return const ListTile(
                  title: Text('Suggestion'),
                );
              }, 
              onSuggestionSelected: (object) {  }, 
              suggestionsCallback: (value) => [],
            ),
            const CustomTextLabel('Manutenção'),
            CustomRadioButtonGroup(
              onChanged: (value) {},
              items: const ['Corretiva', 'Preventiva'],
              initialValue: 'Corretiva',
            ),
            const CustomTextLabel('Máquina parada?'),
            CustomRadioButtonGroup(
              onChanged: (value) {},
              items: const ['Sim', 'Não'],
              initialValue: 'Não',
            ),
            const CustomTextLabel('Garantia?'),
            CustomRadioButtonGroup(
              onChanged: (value) {},
              items: const ['Sim', 'Não'],
              initialValue: 'Não',
            ),
            const CustomTextLabel('Equipamento'),
            CustomRadioButtonGroup(
              onChanged: (value) {},
              items: const ['Carregadeira', 'Escavadeira', 'Rolo Compactador', 'Trator', 'Outros'],
              initialValue: 'Carregadeira',
            ),
            const CustomTextLabel('Aplicação'),
            CustomRadioButtonGroup(
              onChanged: (value) {},
              items: const ['Carregamento', 'Escavação', 'Terraplanagem', 'Rompedor', 'Sucata/Tesoura'],
              initialValue: 'Sucata/Tesoura',
            ),
            const CustomTextLabel('Frota'),
            CustomSuggestionTextField(
              hint: 'Frota',
              obscure: false,
              onChanged: (value) {},
              prefix: const Icon(Icons.onetwothree), 
              itemBuilder: (context, suggestion) {
                return const ListTile(
                  title: Text('Suggestion'),
                );
              }, 
              onSuggestionSelected: (object) {  }, 
              suggestionsCallback: (value) => [],
            ),
            const CustomTextLabel('Modelo'),
            CustomSuggestionTextField(
              hint: 'Modelo',
              obscure: false,
              onChanged: (value) {},
              prefix: const Icon(Icons.onetwothree), 
              itemBuilder: (context, suggestion) {
                return const ListTile(
                  title: Text('Suggestion'),
                );
              }, 
              onSuggestionSelected: (object) {  }, 
              suggestionsCallback: (value) => [],
            ),
            const CustomTextLabel('Série'),
            CustomSuggestionTextField(
              hint: 'Série',
              obscure: false,
              onChanged: (value) {},
              prefix: const Icon(Icons.onetwothree), 
              itemBuilder: (context, suggestion) {
                return const ListTile(
                  title: Text('Suggestion'),
                );
              }, 
              onSuggestionSelected: (object) {  }, 
              suggestionsCallback: (value) => [],
            ),
            const CustomTextLabel('Horímetro'),
            CustomSuggestionTextField(
              hint: 'Horímetro',
              obscure: false,
              onChanged: (value) {},
              prefix: const Icon(Icons.speed), 
              itemBuilder: (context, suggestion) {
                return const ListTile(
                  title: Text('Suggestion'),
                );
              }, 
              onSuggestionSelected: (object) {  }, 
              suggestionsCallback: (value) => [],
            ),
            const SizedBox(height: 32),
            CustomActionButtonGroup(
              primaryChild: const Text('Próximo'),
              secondaryChild: const Text('Anterior'),
              onPrimaryPressed: widget.onPrimaryPressed,
              onSecondaryPressed: null,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      setState(() {
        date = dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    } else {
      return;
    }
  }
}