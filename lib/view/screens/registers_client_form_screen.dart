import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_action_form_group.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_simple_textfield.dart';
import '../widgets/custom_text_label.dart';
import '../widgets/cutom_icon_button.dart';

class RegistersClientFormScreen extends StatefulWidget {
  final VoidCallback? onSecondaryPressed;
  const RegistersClientFormScreen({Key? key,
  this.onSecondaryPressed}) : super(key: key);

  @override
  State<RegistersClientFormScreen> createState() => _RegistersClientFormScreenState();
}

class _RegistersClientFormScreenState extends State<RegistersClientFormScreen> {
  String? attendanceDate;
  String? departureDate;
  String? departureBackDate;
  String? arrivalDate;
  String? arrivalBackDate;
  TimeOfDay? departureHour;
  TimeOfDay? departureBackHour;
  TimeOfDay? arrivalHour;
  TimeOfDay? arrivalBackHour;
  TimeOfDay? attendanceStartHour;
  TimeOfDay? attendanceEndHour;

  final TextEditingController attendanceDateController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController departureBackDateController = TextEditingController();
  final TextEditingController arrivalDateController = TextEditingController();
  final TextEditingController arrivalBackDateController = TextEditingController();
  final TextEditingController departureHourController = TextEditingController();
  final TextEditingController departureBackHourController = TextEditingController();
  final TextEditingController arrivalHourController = TextEditingController();
  final TextEditingController arrivalBackHourController = TextEditingController();
  final TextEditingController attendanceStartHourController = TextEditingController();
  final TextEditingController attendanceEndHourController = TextEditingController();


  @override
  void dispose() {
    attendanceDateController.dispose();
    departureDateController.dispose();
    departureBackDateController.dispose();
    arrivalDateController.dispose();
    arrivalBackDateController.dispose();
    departureHourController.dispose();
    departureBackHourController.dispose();
    arrivalHourController.dispose();
    arrivalBackHourController.dispose();
    attendanceStartHourController.dispose();
    attendanceEndHourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextLabel('Ida'),
            const CustomTextLabel(
              'Data e hora de saída',
              margin: 8,
              fontSize: 16,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    controller: departureDateController,
                    hint: 'Data de saída',
                      suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.edit_calendar, 
                      onTap: () async {
                        departureDate = departureDateController.text = await _selectDate(context);
                      } 
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CustomTextField(
                    controller: departureHourController,
                    hint: 'Ex: 09:00',
                    suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.watch_later_rounded, 
                      onTap: () async {
                        TimeOfDay? hours = await _selectHours(context, departureHour);
                        if (hours != null) {
                          setState(() {
                            departureHour = hours;
                            departureHourController.text = '${hours.hour}:${hours.minute}';
                          });
                        }
                      }
                    ),
                    onChanged: (value) => {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const CustomTextLabel(
              'Data e hora de chegada',
              margin: 8,
              fontSize: 16,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    controller: arrivalDateController,
                    hint: 'Data de chegada',
                      suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.edit_calendar, 
                      onTap: () async {
                        arrivalDate = arrivalDateController.text = await _selectDate(context);
                      } 
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CustomTextField(
                    controller: arrivalHourController,
                    hint: 'Ex: 09:00',
                    suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.watch_later_rounded, 
                      onTap: () async {
                        TimeOfDay? hours = await _selectHours(context, arrivalHour);
                        if (hours != null) {
                          setState(() {
                            arrivalHour = hours;
                            arrivalHourController.text = '${hours.hour}:${hours.minute}';
                          });
                        }
                      },
                    ),
                    onChanged: (value) => {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const CustomTextLabel('Volta'),
            const CustomTextLabel(
              'Data e hora de saída',
              margin: 8,
              fontSize: 16,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    controller: departureBackDateController,
                    hint: 'Data de saída',
                      suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.edit_calendar, 
                      onTap: () async {
                        departureBackDate = departureBackDateController.text = await _selectDate(context);
                      },
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CustomTextField(
                    controller: departureBackHourController,
                    hint: 'Ex: 09:00',
                    suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.watch_later_rounded, 
                      onTap: () async {
                        TimeOfDay? hours = await _selectHours(context, departureBackHour);
                        if (hours != null) {
                          setState(() {
                            departureBackHour = hours;
                            departureBackHourController.text = '${hours.hour}:${hours.minute}';
                          });
                        }
                      },
                    ),
                    onChanged: (value) => {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const CustomTextLabel(
              'Data e hora de chegada',
              margin: 8,
              fontSize: 16,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    controller: arrivalBackDateController,
                    hint: 'Data de chegada',
                      suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.edit_calendar, 
                      onTap: () async {
                        arrivalBackDate = arrivalBackDateController.text = await _selectDate(context);
                      },
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CustomTextField(
                    controller: arrivalBackHourController,
                    hint: 'Ex: 09:00',
                    suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.watch_later_rounded, 
                      onTap: () async {
                        TimeOfDay? hours = await _selectHours(context, arrivalBackHour);
                        if (hours != null) {
                          setState(() {
                            arrivalBackHour = hours;
                            arrivalBackHourController.text = '${hours.hour}:${hours.minute}';
                          });
                        }
                      } 
                    ),
                    onChanged: (value) => {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 1,),
            const CustomTextLabel('Km'),
            Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    hint: 'Km inicial',
                    textInputType: TextInputType.number,
                    prefix: const Icon(Icons.edit_road),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CustomTextField(
                    hint: 'Km final',
                    textInputType: TextInputType.number,
                    prefix: const Icon(Icons.edit_road),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 1,),
            const CustomTextLabel('Atendimento'),
            const CustomTextLabel('Data', margin: 8, fontSize: 16,),
            CustomTextField(
              controller: attendanceDateController,
              hint: 'Data do atendimento',
                suffix: CustomIconButton(
                radius: 32, 
                iconData: Icons.edit_calendar, 
                onTap: () async {
                  attendanceDate = attendanceDateController.text = await _selectDate(context);
                } 
              ),
              onChanged: (value) {},
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
                        margin: 8,
                        fontSize: 16,
                      ),
                      CustomTextField(
                        hint: 'Ex: 09:00',
                        controller: attendanceStartHourController,
                        onChanged: (value) {},
                        suffix: CustomIconButton(
                          radius: 32, 
                          iconData: Icons.edit_calendar, 
                          onTap: () async {
                            TimeOfDay? hours = await _selectHours(context, attendanceStartHour);
                            if (hours != null) {
                              setState(() {
                                attendanceStartHour = hours;
                                attendanceStartHourController.text = '${hours.hour}:${hours.minute}';
                              });
                            }
                          } 
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
                        margin: 8,
                        fontSize: 16,
                      ),
                      CustomTextField(
                        hint: 'Ex: 09:00',
                        controller: attendanceEndHourController,
                        onChanged: (value) {},
                        suffix: CustomIconButton(
                          radius: 32, 
                          iconData: Icons.watch_later, 
                          onTap: () async {
                            TimeOfDay? hours = await _selectHours(context, attendanceEndHour);
                            if (hours != null) {
                              setState(() {
                                attendanceEndHour = hours;
                                attendanceEndHourController.text = '${hours.hour}:${hours.minute}';
                              });
                            }
                          } 
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            CustomActionButtonGroup(
              primaryChild: const Text('Gerar planilha'), 
              secondaryChild: const Text('Anterior'),
              onPrimaryPressed: () {},
              onSecondaryPressed: widget.onSecondaryPressed,
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 44,
              child: OutlinedButton(
                  style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    )
                  )
                ),
                onPressed: null,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Salvar planilha'),
                    SizedBox(width: 8),
                    Icon(Icons.save),
                  ],
                ), 
              )
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                  style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    )
                  )
                ),
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Receber no email'),
                    SizedBox(width: 8),
                    Icon(Icons.email),
                  ],
                ), 
              )
            ),
            const SizedBox(height: 40),
          ],
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
        return departureDateController.text = DateFormat('dd/MM/yyyy').format(picked);
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
}