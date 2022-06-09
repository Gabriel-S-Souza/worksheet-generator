import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/view/screens/os_screen.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_suggestion_text_field.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_icon_button.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../controllers/client_form/basic_informations_controller.dart';
import '../../../default_values/default_values.dart';
import '../../../main.dart';
import '../../widgets/custom_action_form_group.dart';
import '../../widgets/custom_radio_buttom_group.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_text_label.dart';

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
  final UserSettings userSettings = GetIt.I.get<UserSettings>();

  @override
  void initState() {
    super.initState();
    basicInformationsController.spreedsheetDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dateController.text = basicInformationsController.spreedsheetDate ?? '';
    basicInformationsController.requester = requesterController.text = userSettings.name ?? '';
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
        child: Observer(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                const CustomTextLabel('Data'),
                CustomTextField(
                  controller: dateController,
                  onChanged: (value) {},
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
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
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
                  prefix: const Icon(Icons.person), 
                  itemBuilder: (context, suggestion) {
                    return const ListTile(
                      title: Text('Suggestion'),
                    );
                  }, 
                  onSuggestionSelected: (object) {  }, 
                  suggestionsCallback: (value) => [],
                ),
                const CustomTextLabel('Solicitado por'),
                CustomSuggestionTextField(
                  controller: requesterController,
                  obscure: false, 
                  onChanged: (value) {},
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
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
                CustomTextField(
                  hint: 'Nome do atendente',
                  obscure: false, 
                  onChanged: (value) => basicInformationsController.attendant = value,
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
                  prefix: const Icon(Icons.person)
                ),
                const CustomTextLabel('Manutenção'),
                CustomRadioButtonGroup(
                  onChanged: (value) {
                    basicInformationsController.isCorrective = value! == Maintenance.corrective;
                  },
                  items: const [Maintenance.corrective, Maintenance.preventive],
                  initialValue: Maintenance.corrective,
                ),
                basicInformationsController.isCorrective 
                    ? const CustomTextLabel('Manutenção originada de') 
                    : Container(),
                basicInformationsController.isCorrective 
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
                  initialValue: Equipment.excavator,
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
                const CustomTextLabel('Local de Atendimento'),
                 CustomRadioButtonGroup(
                  onChanged: (value) => basicInformationsController.localOfAttendance = value!,
                  items: const [
                    LocalOfAttendance.piracicaba,
                    LocalOfAttendance.iracenopolis,
                    LocalOfAttendance.other,
                  ],
                  initialValue: basicInformationsController.localOfAttendance!,
                ),
                basicInformationsController.localOfAttendance == LocalOfAttendance.other
                    ? const CustomTextLabel('Local de atendimento')
                    : Container(),
                basicInformationsController.localOfAttendance == LocalOfAttendance.other
                    ? CustomTextField(
                        hint: 'Local de atendimento',
                        obscure: false,
                        onChanged: (value) => basicInformationsController.localOfAttendance = value,
                        prefix: const Icon(Icons.location_on),
                      )
                    : Container(),
                const CustomTextLabel('O.S.'),
                basicInformationsController.localOfAttendance == LocalOfAttendance.other
                    ? CustomTextField(
                      hint: 'O.S.',
                      obscure: false, 
                      onChanged: (value) {},
                      prefix: const Icon(Icons.info),
                    )
                    : Container(),
                basicInformationsController.localOfAttendance != LocalOfAttendance.other
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        const CustomTextLabel('202201 - PIRACI'),
                        const SizedBox(width: 16),
                        CustomIconButton(
                          iconData: Icons.edit, 
                          radius: 38, 
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => 
                                const OSScreen()
                            )
                          ),
                        )
                      ]
                    )
                    : Container(),
                const CustomTextLabel('Placa'),
                CustomTextField(
                  hint: 'AAA-0000',
                  prefix: const Icon(Icons.rectangle_outlined),
                  onChanged: (value) => basicInformationsController.plate = value,
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
                ),
                const CustomTextLabel('Frota'),
                CustomSuggestionTextField(
                  hint: 'Frota',
                  obscure: false,
                  onChanged: (value) => basicInformationsController.fleet = value,
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
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
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
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
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
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
                  onChanged: (value) => basicInformationsController.odometer = value,
                  onSubmitted: () => FocusScope.of(context).nextFocus(),
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
                          ? () {
                              
                              basicInformationsController.save();
            
                              widget.onPrimaryPressed();
                            }
                          : null,
                      onSecondaryPressed: null,
                    );
                  }
                ),
                const SizedBox(height: 40),
              ],
            );
          }
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
      basicInformationsController.spreedsheetDate = dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    } else {
      return;
    }
  }
}
