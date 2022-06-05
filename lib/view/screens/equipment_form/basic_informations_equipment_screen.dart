import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/default_values/default_values.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_action_form_group.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_radio_buttom_group.dart';
import '../../widgets/custom_suggestion_text_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_text_label.dart';

class BasicInformationsEquipmentScreen extends StatefulWidget {
  final VoidCallback? onPrimaryPressed;
  const BasicInformationsEquipmentScreen({Key? key, this.onPrimaryPressed}) : super(key: key);

  @override
  State<BasicInformationsEquipmentScreen> createState() => _BasicInformationsEquipmentScreenState();
}

class _BasicInformationsEquipmentScreenState extends State<BasicInformationsEquipmentScreen> {
  final TextEditingController dateController = TextEditingController();
  String? date;
  String maintenance = Maintenance.corrective;
  String? correctiveMaintenanceOrigin = CorrectiveMaintenanceOrigin.operationalFailure;
  String isStoppedMachine = YesNo.yes;
  String knifeTurn = YesNo.no;
  String equipment = Equipment.excavator;
  String equipmentApplication = EquipmentApplication.scrap;
  String? fleet;
  String? model;
  String? odometer;
  String? scissors;
  

  @override
  void initState() {
    super.initState();
    date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dateController.text = date ?? '';
  }

  @override
  void dispose() {
    dateController.dispose();
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
          children:  <Widget>[
            const CustomTextLabel('Data'),
              CustomTextField(
                controller: dateController,
                onChanged: (value) {},
                suffix: CustomIconButton(
                  radius: 32, 
                  iconData: Icons.edit_calendar, 
                  onTap: () => _selectDate(context),
              )
            ),
            const CustomTextLabel('Unidade'),
              CustomSuggestionTextField(
                obscure: false, 
                onChanged: (value) {},
                prefix: const Icon(Icons.business), 
                itemBuilder: (context, suggestion) {
                  return const ListTile(
                    title: Text('Suggestion'),
                  );
                }, 
                onSuggestionSelected: (object) {  }, 
                suggestionsCallback: (value) => [],
              ),
              const CustomTextLabel('Local de atendimento'),
              CustomTextField(
                hint: 'Local de atendimento',
                obscure: false,
                onChanged: (value) {},
                prefix: const Icon(Icons.location_on),
              ),
              const CustomTextLabel('Manutenção'),
              CustomRadioButtonGroup(
                onChanged: (value) {
                  setState(() => maintenance = value!);
                },
                items: const [Maintenance.corrective, Maintenance.preventive],
                initialValue: Maintenance.corrective,
              ),
              maintenance == Maintenance.corrective 
                  ? const CustomTextLabel('Manutenção originada de') 
                  : Container(),
              maintenance == Maintenance.corrective 
                  ? CustomRadioButtonGroup(
                    onChanged: (value) => setState(() => correctiveMaintenanceOrigin  = value!),
                    items: const [
                      CorrectiveMaintenanceOriginEquipment.operationalFailure, 
                      CorrectiveMaintenanceOriginEquipment.withoutPreventive, 
                      CorrectiveMaintenanceOriginEquipment.maintenanceFailure, 
                      CorrectiveMaintenanceOriginEquipment.wearCommon, 
                      CorrectiveMaintenanceOriginEquipment.other
                    ],
                    initialValue: CorrectiveMaintenanceOrigin.wearCommon,
                  )
                  : Container(),
                const CustomTextLabel('Máquina parada?'),
              CustomRadioButtonGroup(
                onChanged: (value) => isStoppedMachine = value!,
                items: const [YesNo.yes, YesNo.no],
                initialValue: YesNo.no,
              ),
              const CustomTextLabel('Virada de faca?'),
              CustomRadioButtonGroup(
                onChanged: (value) => knifeTurn = value!,
                items: const [YesNo.yes, YesNo.no],
                initialValue: knifeTurn,
              ),
              const CustomTextLabel('Equipamento'),
              CustomRadioButtonGroup(
                onChanged: (value) => setState(() => equipment = value!),
                items: const [
                  Equipment.excavator,
                ],
                initialValue: Equipment.excavator,
              ),
              const CustomTextLabel('Aplicação'),
              CustomRadioButtonGroup(
                onChanged: (value) => setState(() =>  equipmentApplication = value!),
                items: const [
                  EquipmentApplication.scrap,
                ],
                initialValue: EquipmentApplication.scrap,
              ),
              const CustomTextLabel('Frota'),
                CustomSuggestionTextField(
                  hint: 'Frota',
                  obscure: false,
                  onChanged: (value) =>  setState(() => fleet = value),
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
                  onChanged: (value) =>  setState(() => model = value),
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
                  hint: 'Horímetro',
                  obscure: false,
                  onChanged: (value) =>  setState(() => odometer = value),
                  prefix: const Icon(Icons.speed), 
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
                  hint: 'Tesoura',
                  obscure: false,
                  onChanged: (value) =>  setState(() =>   scissors = value),
                  prefix: const Icon(Icons.architecture), 
                  itemBuilder: (context, suggestion) {
                    return const ListTile(
                      title: Text('Suggestion'),
                    );
                  }, 
                  onSuggestionSelected: (object) {  }, 
                  suggestionsCallback: (value) => [],
                ),
                const SizedBox(height: 40),
                CustomActionButtonGroup(
                  primaryChild: const Text('Salvar e avançar'),
                  secondaryChild: const Text('Anterior'),
                  onPrimaryPressed: widget.onPrimaryPressed,
                  onSecondaryPressed: null,
                ),
                const SizedBox(height: 40),
          ],
        )
      )
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
      date = dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    } else {
      return;
    }
  }
}