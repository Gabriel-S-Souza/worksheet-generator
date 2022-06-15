import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/view/screens/os_screen.dart';
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
  final TextEditingController attendantController = TextEditingController();
  final TextEditingController requesterController = TextEditingController();
  final BasicInformaTionsController basicInformationsController = GetIt.I.get<BasicInformaTionsController>(instanceName: DefaultKeys.basicInfoControllerClient);
  final UserSettings userSettings = GetIt.I.get<UserSettings>();
  late final FocusNode focusRequester;
  late final FocusNode focusAttendant;
  late final FocusNode focusModel; 
  late final FocusNode seriesFocus; 
  late final FocusNode odometerFocus; 

  @override
  void initState() {
    super.initState();
    basicInformationsController.spreedsheetDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dateController.text = basicInformationsController.spreedsheetDate ?? '';
    basicInformationsController.attendant = basicInformationsController.requester 
        = attendantController.text = requesterController.text = userSettings.name ?? '';
    basicInformationsController.generateOs();
    focusRequester = FocusNode();
    focusAttendant = FocusNode();
    focusModel = FocusNode();
    seriesFocus = FocusNode();
    odometerFocus = FocusNode();
  }

  @override
  void dispose() {
    dateController.dispose();
    requesterController.dispose();
    focusRequester.dispose();
    focusAttendant.dispose();
    seriesFocus.dispose();
    odometerFocus.dispose();
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
                CustomTextField(
                  hint: 'Nome do cliente',
                  obscure: false, 
                  onChanged: (value) => basicInformationsController.client = value,
                  onSubmitted: () => FocusScope.of(context).requestFocus(focusRequester),
                  prefix: const Icon(Icons.person), 
                ),
                const CustomTextLabel('Solicitado por'),
                CustomTextField(
                  controller: requesterController,
                  focusNode: focusRequester,
                  hint: 'Nome do solicitante',
                  obscure: false, 
                  onChanged: (value) {},
                  onSubmitted: () => FocusScope.of(context).requestFocus(focusAttendant),
                  prefix: const Icon(Icons.person),
                ),
                const CustomTextLabel('Atendido por'),
                CustomTextField(
                  controller: attendantController,
                  focusNode: focusAttendant,
                  hint: 'Nome do atendente',
                  obscure: false, 
                  onChanged: (value) => basicInformationsController.attendant = value,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
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
                  onChanged: (value) {
                    basicInformationsController.localOfAttendance = value!;
                    basicInformationsController.isAutoOS = value != LocalOfAttendance.other;
                    basicInformationsController.generateOs();
                  },
                  items: const [
                    LocalOfAttendance.piracicaba,
                    LocalOfAttendance.iracenopolis,
                    LocalOfAttendance.other,
                  ],
                  initialValue: basicInformationsController.localOfAttendance!,
                ),
                !basicInformationsController.isAutoOS
                    ? CustomTextField(
                        hint: 'Local de atendimento',
                        obscure: false,
                        onChanged: (value) => basicInformationsController.localOfAttendance = value,
                        prefix: const Icon(Icons.location_on),
                      )
                    : Container(),
                !basicInformationsController.isAutoOS
                    ? const CustomTextLabel('OS')
                    : Container(),
                !basicInformationsController.isAutoOS
                    ? CustomTextField(
                      hint: 'O.S.',
                      obscure: false, 
                      onChanged: (value) => basicInformationsController.os = value,
                      prefix: const Icon(Icons.info),
                    )
                    : Container(),
                basicInformationsController.isAutoOS
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        const CustomTextLabel( 'O.S:   ',),
                        CustomTextLabel(basicInformationsController.osWasGenerated ? basicInformationsController.osGenerated : 'Gerando...'),
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
                  onChanged: (value) => basicInformationsController.fleet = value,
                  onSubmitted: () => FocusScope.of(context).requestFocus(focusModel),
                  prefix: const Icon(Icons.onetwothree), 
                ),
                const CustomTextLabel('Modelo'),
                CustomTextField(
                  hint: 'Modelo',
                  focusNode: focusModel,
                  obscure: false,
                  onChanged: (value) => basicInformationsController.model = value,
                  onSubmitted: () => FocusScope.of(context).requestFocus(seriesFocus),
                  prefix: const Icon(Icons.onetwothree),
                ),
                const CustomTextLabel('Série'),
                CustomTextField(
                  hint: 'Série',
                  focusNode: seriesFocus,
                  obscure: false,
                  onChanged: (value) => basicInformationsController.serie = value,
                  onSubmitted: () => FocusScope.of(context).requestFocus(odometerFocus),
                  prefix: const Icon(Icons.onetwothree),
                ),
                const CustomTextLabel('Horímetro'),
                CustomTextField(
                  hint: 'Horímetro',
                  focusNode: odometerFocus,
                  obscure: false,
                  onChanged: (value) => basicInformationsController.odometer = value,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
                  prefix: const Icon(Icons.speed),
                ),
                const SizedBox(height: 40),
                Observer(
                  builder: (context) {
                    return CustomActionButtonGroup(
                      primaryChild: !basicInformationsController.isLoading
                          ? const Text('Salvar e avançar')
                          : const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()),
                      secondaryChild: const Text('Anterior'),
                      onPrimaryPressed: !basicInformationsController.isLoading
                          ? () async {
                              
                              await basicInformationsController.save();
            
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
