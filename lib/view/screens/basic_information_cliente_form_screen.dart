import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_suggestion_text_field.dart';
import 'package:formulario_de_atendimento/view/widgets/cutom_icon_button.dart';
import 'package:intl/intl.dart';

import '../../controllers/client_form/basic_informations_controller.dart';
import '../../default_values/default_values.dart';
import '../widgets/custom_action_form_group.dart';
import '../widgets/custom_radio_buttom_group.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_text_label.dart';

class BasicInformationsClienteFormScreen extends StatefulWidget {
  final VoidCallback onPrimaryPressed;
  const BasicInformationsClienteFormScreen({
    Key? key, 
    required this.onPrimaryPressed}) : super(key: key);

  @override
  State<BasicInformationsClienteFormScreen> createState() => _BasicInformationsClienteFormScreenState();
}

class _BasicInformationsClienteFormScreenState extends State<BasicInformationsClienteFormScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController requesterController = TextEditingController();
  final BasicInformaTionsController basicInformationsController = BasicInformaTionsController();
  
  


  @override
  void initState() {
    super.initState();
    basicInformationsController.date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dateController.text = basicInformationsController.date ?? '';
    basicInformationsController.requester = requesterController.text = 'Alan';
  }

  @override
  void dispose() {
    dateController.dispose();
    requesterController.dispose();
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
              ),
            ),
            const CustomTextLabel('Cliente'),
            CustomSuggestionTextField(
              obscure: false, 
              onChanged: (value) => basicInformationsController.client = value,
              prefix: const Icon(Icons.person), 
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
              onChanged: (value) => basicInformationsController.localOfAttendance = value,
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
              onChanged: (value) => basicInformationsController.attendant = value,
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
              onChanged: (value) {
                basicInformationsController.maintenance = value!;
              },
              items: const [Maintenance.corrective, Maintenance.preventive],
              initialValue: Maintenance.corrective,
            ),
            basicInformationsController.maintenance == Maintenance.corrective 
                ? const CustomTextLabel('Manutenção originada de') 
                : Container(),
            basicInformationsController.maintenance == Maintenance.corrective 
                ? CustomRadioButtonGroup(
                  onChanged: (value) => basicInformationsController.correctiveMaintenanceOrigin = value!,
                  items: const [
                    CorrectiveMaintenanceOrigin.operationalFailure, 
                    CorrectiveMaintenanceOrigin.withoutPreventive, 
                    CorrectiveMaintenanceOrigin.wearByLoadedMaterial, 
                    CorrectiveMaintenanceOrigin.wearCommon, 
                    CorrectiveMaintenanceOrigin.other
                  ],
                  initialValue: CorrectiveMaintenanceOrigin.wearCommon,
                )
                : Container(),
            const CustomTextLabel('Máquina parada?'),
            CustomRadioButtonGroup(
              onChanged: (value) => basicInformationsController.isStoppedMachine = value!,
              items: const [YesNo.yes, YesNo.no],
              initialValue: YesNo.no,
            ),
            const CustomTextLabel('Garantia?'),
            CustomRadioButtonGroup(
              onChanged: (value) => basicInformationsController.isWarranty = value!,
              items: const [YesNo.yes, YesNo.no],
              initialValue: basicInformationsController.isWarranty,
            ),
            const CustomTextLabel('Equipamento'),
            CustomRadioButtonGroup(
              onChanged: (value) => basicInformationsController.equipment = value!,
              items: const [
                Equipment.loader,
                Equipment.excavator,
                Equipment.rollerCompactor,
                Equipment.tractor,
                Equipment.other
              ],
              initialValue: Equipment.loader,
            ),
            const CustomTextLabel('Aplicação'),
            CustomRadioButtonGroup(
              onChanged: (value) => basicInformationsController.equipmentApplication = value!,
              items: const [
                EquipmentApplication.loading,
                EquipmentApplication.excavation,
                EquipmentApplication.digger,
                EquipmentApplication.terraplanning,
                EquipmentApplication.scrap,
              ],
              initialValue: EquipmentApplication.scrap,
            ),
            const CustomTextLabel('Placa'),
            CustomTextField(
              hint: 'AAA-0000',
              prefix: const Icon(Icons.rectangle_outlined),
              onChanged: (value) => basicInformationsController.plate = value,
            ),
            const CustomTextLabel('Frota'),
            CustomSuggestionTextField(
              hint: 'Frota',
              obscure: false,
              onChanged: (value) => basicInformationsController.fleet = value,
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
              onChanged: (value) => basicInformationsController.model = value,
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
              onChanged: (value) => basicInformationsController.serie = value,
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
              onChanged: (value) => basicInformationsController.hourMeter = value,
              prefix: const Icon(Icons.speed), 
              itemBuilder: (context, suggestion) {
                return const ListTile(
                  title: Text('Suggestion'),
                );
              }, 
              onSuggestionSelected: (object) {  }, 
              suggestionsCallback: (value) => [],
            ),
            const SizedBox(height: 40),
            Observer(
              builder: (context) {
                return CustomActionButtonGroup(
                  primaryChild: !basicInformationsController.isLoading
                      ? const Text('Salvar e avançar')
                      : const Padding( padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(),
                      ),
                  secondaryChild: const Text('Anterior'),
                  onPrimaryPressed: !basicInformationsController.isLoading
                      ? () async {
                          
                          basicInformationsController.addToSpreedsheet()
                              .then((value) => _buildSnackBar(context, value));

                          widget.onPrimaryPressed();
                        }
                      : null,
                  onSecondaryPressed: null,
                );
              }
            ),
            const SizedBox(height: 40),
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
      basicInformationsController.date = dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    } else {
      return;
    }
  }

  _buildSnackBar(BuildContext context, String path) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.only(bottom: 60),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        content: Text('Salvo em $path'),
      ),
    );
  }
}
