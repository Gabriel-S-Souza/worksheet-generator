import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/controllers/equipment_form/basic_info_equipment_controller.dart';
import 'package:formulario_de_atendimento/default_values/default_values.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_action_form_group.dart';
import '../../widgets/custom_check_buttom.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_radio_buttom_group.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_text_label.dart';
import '../os_screen.dart';

class BasicInformationsEquipmentScreen extends StatefulWidget {
  final VoidCallback onPrimaryPressed;
  final String equipmentName;
  const BasicInformationsEquipmentScreen({
    Key? key, 
    required this.onPrimaryPressed, 
    required this.equipmentName}) : super(key: key);

  @override
  State<BasicInformationsEquipmentScreen> createState() => _BasicInformationsEquipmentScreenState();
}

class _BasicInformationsEquipmentScreenState extends State<BasicInformationsEquipmentScreen> {
  final TextEditingController dateController = TextEditingController();

  final BasicInfoEquipmentController basicInfoEquipmentController = GetIt.I.get<BasicInfoEquipmentController>();
  late final FocusNode focusModel; 
  late final FocusNode focusOdometer; 

  @override
  void initState() {
    super.initState();
    basicInfoEquipmentController.spreedsheetDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dateController.text = basicInfoEquipmentController.spreedsheetDate ?? '';
    basicInfoEquipmentController.scissors = widget.equipmentName;
    basicInfoEquipmentController.generateOs();
    focusModel = FocusNode();
    focusOdometer = FocusNode();
  }

  @override
  void dispose() {
    dateController.dispose();
    focusOdometer.dispose();
    focusModel.dispose();
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
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    basicInfoEquipmentController.spreedsheetDate = dateController.text = await _selectDate(context);
                  },
                  child: IgnorePointer(
                    child: CustomTextField(
                      readOnly: true,
                      controller: dateController,
                      onChanged: (value) {},
                      onSubmitted: () => FocusScope.of(context).nextFocus(),
                      suffix: CustomIconButton(
                        radius: 32, 
                        iconData: Icons.edit_calendar, 
                        onTap: () => _selectDate(context),
                    )
                              ),
                  ),
                ),
                const CustomTextLabel('Unidade'),
                  CustomTextField(
                    obscure: false, 
                    hint: 'Unidade',
                    onChanged: (value) => basicInfoEquipmentController.unit = value,
                    onSubmitted: () => FocusScope.of(context).nextFocus(),
                    prefix: const Icon(Icons.business), 
                  ),
                  const CustomTextLabel('Manutenção'),
                  CustomRadioButtonGroup(
                    onChanged: (value) {
                      basicInfoEquipmentController.isCorrective = value! == Maintenance.corrective;
                    },
                    items: const [Maintenance.corrective, Maintenance.preventive],
                    initialValue: Maintenance.corrective,
                  ),
                  basicInfoEquipmentController.isCorrective
                      ? const CustomTextLabel('Manutenção originada de') 
                      : Container(),
                  basicInfoEquipmentController.isCorrective 
                      ? CustomRadioButtonGroup(
                        onChanged: (value) => basicInfoEquipmentController.correctiveMaintenanceOrigin  = value!,
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
                    onChanged: (value) => basicInfoEquipmentController.isStoppedMachine = value!,
                    items: const [YesNo.yes, YesNo.no],
                    initialValue: basicInfoEquipmentController.isStoppedMachine ?? YesNo.no,
                  ),
                  const CustomTextLabel('Virada de faca?'),
                  CustomRadioButtonGroup(
                    onChanged: (value) => basicInfoEquipmentController.isTurnedKnife = value!,
                    items: const [YesNo.yes, YesNo.no],
                    initialValue: basicInfoEquipmentController.isTurnedKnife ?? YesNo.no,
                  ),
                  const CustomTextLabel('Equipamento'),
                  CustomCheckButton(
                    title: Equipment.excavator,
                    onChanged: (value) => basicInfoEquipmentController.isExcavator = value!,
                    value: basicInfoEquipmentController.isExcavator,
                  ),
                  const CustomTextLabel('Aplicação'),
                   CustomCheckButton(
                    title: EquipmentApplication.scrap,
                    onChanged: (value)  => basicInfoEquipmentController.isScissors = value!,
                    value: basicInfoEquipmentController.isScissors,
                  ),
                  const CustomTextLabel('Local de Atendimento'),
                  CustomRadioButtonGroup(
                    onChanged: (value) {
                      basicInfoEquipmentController.localOfAttendance = value!;
                      basicInfoEquipmentController.isAutoOS = value != LocalOfAttendance.other;
                      basicInfoEquipmentController.generateOs();
                    },
                    items: const [
                      LocalOfAttendance.piracicaba,
                      LocalOfAttendance.iracenopolis,
                      LocalOfAttendance.other,
                    ],
                    initialValue: basicInfoEquipmentController.localOfAttendance!,
                  ),
                  !basicInfoEquipmentController.isAutoOS
                    ? CustomTextField(
                        hint: 'Local de atendimento',
                        obscure: false,
                        onChanged: (value) => basicInfoEquipmentController.localOfAttendance = value,
                        prefix: const Icon(Icons.location_on),
                      )
                    : Container(),
                !basicInfoEquipmentController.isAutoOS
                    ? const CustomTextLabel('OS')
                    : Container(),
                !basicInfoEquipmentController.isAutoOS
                    ? CustomTextField(
                      hint: 'O.S.',
                      obscure: false, 
                      onChanged: (value) => basicInfoEquipmentController.os = value,
                      prefix: const Icon(Icons.info),
                    )
                    : Container(),
                basicInfoEquipmentController.isAutoOS
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        const CustomTextLabel( 'O.S:   ',),
                        CustomTextLabel(basicInfoEquipmentController.osWasGenerated ? basicInfoEquipmentController.osGenerated : 'Gerando...'),
                        const SizedBox(width: 16),
                        CustomIconButton(
                          iconData: Icons.edit, 
                          radius: 38, 
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => 
                                  const OSScreen()
                              )
                            );
                          }
                        )
                      ]
                    )
                    : Container(),
                  const CustomTextLabel('Frota'),
                    CustomTextField(
                      hint: 'Frota',
                      obscure: false,
                      onChanged: (value) => basicInfoEquipmentController.fleet = value,
                      onSubmitted: () => FocusScope.of(context).requestFocus(focusModel),
                      prefix: const Icon(Icons.onetwothree), 
                    ),
                    const CustomTextLabel('Modelo'),
                    CustomTextField(
                      hint: 'Modelo',
                      focusNode: focusModel,
                      obscure: false,
                      onChanged: (value) => basicInfoEquipmentController.model = value,
                      onSubmitted: () => FocusScope.of(context).requestFocus(focusOdometer),
                      prefix: const Icon(Icons.onetwothree),
                    ),
                    const CustomTextLabel('Horímetro'),
                    CustomTextField(
                      hint: 'Horímetro',
                      focusNode: focusOdometer,
                      obscure: false,
                      onChanged: (value) => basicInfoEquipmentController.odometer = value,
                      onSubmitted: () => FocusScope.of(context).unfocus(),
                      prefix: const Icon(Icons.speed),
                    ),
                    const SizedBox(height: 40),
                    CustomActionButtonGroup(
                      onPrimaryPressed: !basicInfoEquipmentController.isLoading
                          ? () async {                              
                              await basicInfoEquipmentController.save();
            
                              widget.onPrimaryPressed();
                            }
                          : null,
                      onSecondaryPressed: null,
                      primaryChild: !basicInfoEquipmentController.isLoading
                          ? const Text('Salvar e avançar')
                          : const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()),
                      secondaryChild: const Text('Anterior'),
                    ),
                    const SizedBox(height: 40),
              ],
            );
          }
        )
      )
    );
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
        return DateFormat('dd/MM/yyyy').format(picked);
    } else {
      return '';
    }
  }
}