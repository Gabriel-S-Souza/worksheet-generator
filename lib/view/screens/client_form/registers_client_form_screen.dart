import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/controllers/client_form/general_client_controller.dart';
import 'package:formulario_de_atendimento/controllers/client_form/registers_controller.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_action_form_group.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_app_buttom.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_outlined_buttom.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_text_field.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_text_label.dart';
import '../../widgets/custom_icon_button.dart';

class RegistersClientFormScreen extends StatefulWidget {
  final VoidCallback? onSecondaryPressed;
  const RegistersClientFormScreen({Key? key,
  this.onSecondaryPressed}) : super(key: key);

  @override
  State<RegistersClientFormScreen> createState() => _RegistersClientFormScreenState();
}

class _RegistersClientFormScreenState extends State<RegistersClientFormScreen> {

  final TextEditingController attendanceStartHourController = TextEditingController();
  final TextEditingController attendanceEndHourController = TextEditingController();
  final TextEditingController attendanceDateController = TextEditingController();

  final GeneralClientController generalClientController = GetIt.I.get<GeneralClientController>();

  final RegistersController registersController = RegistersController();

  late final FocusNode focusNodeFinalKm;
  late final FocusNode focusAttendanceDate;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    focusNodeFinalKm = FocusNode();
    focusAttendanceDate = FocusNode();
    registersController.attendanceDate = attendanceDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }


  @override
  void dispose() {
    attendanceDateController.dispose();
    attendanceStartHourController.dispose();
    attendanceEndHourController.dispose();
    focusNodeFinalKm.dispose();
    focusAttendanceDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Observer(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomTextLabel('Atendimento'),
                const CustomTextLabel('Data', 
                  marginTop: 8,
                  marginBottom: 8,
                  fontSize: 16,),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    registersController.attendanceDate = attendanceDateController.text = await _selectDate(context);
                  },
                  child: IgnorePointer(
                    child: CustomTextField(
                      readOnly: true,
                      controller: attendanceDateController,
                      focusNode: focusAttendanceDate,
                      hint: 'Data do atendimento',
                        suffix: CustomIconButton(
                        radius: 32, 
                        iconData: Icons.edit_calendar, 
                        onTap: () async {
                          registersController.attendanceDate = attendanceDateController.text = await _selectDate(context);
                        } 
                      ),
                      onChanged: (value) => registersController.attendanceDate = value,
                      onSubmitted: () => FocusScope.of(context).nextFocus(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget> [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextLabel(
                            'Horário de início',
                            marginTop: 8,
                            marginBottom: 8,
                            fontSize: 16,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              TimeOfDay? hours = await _selectHours(context, registersController.attendanceStartTimeOfDay);
                              if (hours != null) {
                                registersController.attendanceStartTimeOfDay = hours;
                                String hoursFormated = hours.hour < 10 ? '0${hours.hour}' : '${hours.hour}';
                                String minutesFormated = hours.minute < 10 ? '0${hours.minute}' : '${hours.minute}';
                                registersController.attendanceStartTime = attendanceStartHourController.text = '$hoursFormated:$minutesFormated';
                              }
                            }, 
                            child: IgnorePointer(
                              child: CustomTextField(
                                readOnly: true,
                                hint: 'Ex: 09:00',
                                controller: attendanceStartHourController,
                                onChanged: (value) => registersController.attendanceStartTime = value,
                                onSubmitted: () => FocusScope.of(context).nextFocus(),
                                suffix: CustomIconButton(
                                  radius: 32, 
                                  iconData: Icons.edit_calendar, 
                                  onTap: () async {
                                    TimeOfDay? hours = await _selectHours(context, registersController.attendanceStartTimeOfDay);
                                    if (hours != null) {
                                      registersController.attendanceStartTimeOfDay = hours;
                                      String hoursFormated = hours.hour < 10 ? '0${hours.hour}' : '${hours.hour}';
                                      String minutesFormated = hours.minute < 10 ? '0${hours.minute}' : '${hours.minute}';
                                      registersController.attendanceStartTime = attendanceStartHourController.text = '$hoursFormated:$minutesFormated';
                                    }
                                  } 
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextLabel(
                            'Horário de término',
                            marginTop: 8,
                            marginBottom: 8,
                            fontSize: 16,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              TimeOfDay? hours = await _selectHours(context, registersController.attendanceEndTimeOfDay);
                              if (hours != null) {
                                registersController.attendanceEndTimeOfDay = hours;
                                String hoursFormated = hours.hour < 10 ? '0${hours.hour}' : '${hours.hour}';
                                String minutesFormated = hours.minute < 10 ? '0${hours.minute}' : '${hours.minute}';
                                registersController.attendanceEndTime = attendanceEndHourController.text = '$hoursFormated:$minutesFormated';
                              }
                            },
                            child: IgnorePointer(
                              child: CustomTextField(
                                readOnly: true,
                                hint: 'Ex: 09:00',
                                controller: attendanceEndHourController,
                                onChanged: (value) => registersController.attendanceEndTime = value,
                                onSubmitted: () => FocusScope.of(context).nextFocus(),
                                suffix: CustomIconButton(
                                  radius: 32, 
                                  iconData: Icons.watch_later, 
                                  onTap: () async {
                                    TimeOfDay? hours = await _selectHours(context, registersController.attendanceEndTimeOfDay);
                                    if (hours != null) {
                                      registersController.attendanceEndTimeOfDay = hours;
                                      String hoursFormated = hours.hour < 10 ? '0${hours.hour}' : '${hours.hour}';
                                      String minutesFormated = hours.minute < 10 ? '0${hours.minute}' : '${hours.minute}';
                                      registersController.attendanceEndTime = attendanceEndHourController.text = '$hoursFormated:$minutesFormated';
                                    }
                                  } 
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    const CustomTextLabel( 'Total de horas:  ', color: Colors.black54),
                    CustomTextLabel(registersController.totalOfHours ?? '00:00', color: Colors.black54),
                  ]
                ),
                const SizedBox(height: 40),
                Observer(
                  builder: (context) {
                    return CustomActionButtonGroup(
                      primaryChild: !registersController.isLoading
                          ? const Text('Salvar')
                          : const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()), 
                      secondaryChild: const Text('Anterior'),
                      onSecondaryPressed:  widget.onSecondaryPressed,
                      onPrimaryPressed:!registersController.isLoading
                          ? () async {
                              await registersController.save();
                              String? response = registersController.checkIfCanCreate();
                              if (response != null && mounted) {
                                _buildSnackBar(context, response);
                              }
                              setState(() {});
                            }
                          : null,
                    );
                  }
                ),
                const SizedBox(height: 32),
                CustomAppButtom(
                  onPressed: generalClientController.readyToSave
                      ? () async {
                        setState(() {
                          isLoading = true;
                        });
                        generalClientController.createSpreedsheet()
                          .then((value) {
                                _buildSnackBar(
                                  context, value
                                );
                                setState(() {
                                  isLoading = false;
                                }); 
                              });
                      }
                      : null,
                  child: !isLoading
                      ?  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Salvar planilha'),
                            SizedBox(width: 8),
                            Icon(Icons.save),
                          ],
                        )
                      : const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()),
                ),
                const SizedBox(height: 28),
                CustomAppButtom(
                  onPressed: null,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Receber no email'),
                        SizedBox(width: 8),
                        Icon(Icons.email),
                      ],
                    ), 
                ),
                const SizedBox(height: 40),
              ],
            );
          }
        ),
      ),
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

  Future<TimeOfDay?> _selectHours(BuildContext context, TimeOfDay? initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:  initialTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      return picked;
    } else {
      return null;
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