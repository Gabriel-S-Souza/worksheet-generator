import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/controllers/client_form/registers_controller.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_action_form_group.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

import '../../rules/spreedsheet_pdf_genarator.dart';
import '../widgets/custom_text_label.dart';
import '../widgets/cutom_icon_button.dart';

class RegistersClientFormScreen extends StatefulWidget {
  final VoidCallback? onSecondaryPressed;
  // final Directory downloadsDirectory;
  final String downloadsDirectory;
  const RegistersClientFormScreen({Key? key,
  this.onSecondaryPressed, required this.downloadsDirectory}) : super(key: key);

  @override
  State<RegistersClientFormScreen> createState() => _RegistersClientFormScreenState();
}

class _RegistersClientFormScreenState extends State<RegistersClientFormScreen> {

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

  final RegistersController registersController = RegistersController();


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
                        registersController.oneWayDepartureDate = departureDateController.text = await _selectDate(context);
                      }
                    ),
                    onChanged: (value) => registersController.oneWayDepartureDate = value,
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
                        TimeOfDay? hours = await _selectHours(context, registersController.departureHour);
                        if (hours != null) {
                          registersController.departureHour = hours;
                          registersController.oneWayDepartureTime = departureHourController.text = '${hours.hour}:${hours.minute}';
                        }
                      }
                    ),
                    onChanged: (value) => registersController.oneWayDepartureTime = value,
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
                        registersController.oneWayArrivalDate = arrivalDateController.text = await _selectDate(context);
                      } 
                    ),
                    onChanged: (value) => registersController.oneWayArrivalDate = value,
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
                        TimeOfDay? hours = await _selectHours(context, registersController.arrivalHour);
                        if (hours != null) {
                          registersController.arrivalHour = hours;
                          registersController.oneWayArrivalTime = arrivalHourController.text = '${hours.hour}:${hours.minute}';
                        }
                      },
                    ),
                    onChanged: (value) => registersController.oneWayArrivalTime = value,
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
                        registersController.returnDepartureDate = departureBackDateController.text = await _selectDate(context);
                      },
                    ),
                    onChanged: (value) => registersController.returnDepartureDate = value,
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
                        TimeOfDay? hours = await _selectHours(context, registersController.departureBackHour);
                        if (hours != null) {
                          registersController.departureBackHour = hours;
                          registersController.returnDepartureTime = departureBackHourController.text = '${hours.hour}:${hours.minute}';
                        }
                      },
                    ),
                    onChanged: (value) => registersController.returnDepartureTime = value,
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
                        registersController.returnArrivalDate = arrivalBackDateController.text = await _selectDate(context);
                      },
                    ),
                    onChanged: (value) => registersController.returnArrivalDate = value,
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
                        TimeOfDay? hours = await _selectHours(context, registersController.arrivalBackHour);
                        if (hours != null) {
                          registersController.arrivalBackHour = hours;
                          registersController.returnArrivalTime = arrivalBackHourController.text = '${hours.hour}:${hours.minute}';
                        }
                      } 
                    ),
                    onChanged: (value) => registersController.returnArrivalTime = value,
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
                    onChanged: (value) => registersController.initialKm = value,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CustomTextField(
                    hint: 'Km final',
                    textInputType: TextInputType.number,
                    prefix: const Icon(Icons.edit_road),
                    onChanged: (value) => registersController.finalKm = value,
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
                  registersController.attendanceDate = attendanceDateController.text = await _selectDate(context);
                } 
              ),
              onChanged: (value) => registersController.attendanceDate = value,
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
                        onChanged: (value) => registersController.attendanceStartTime = value,
                        suffix: CustomIconButton(
                          radius: 32, 
                          iconData: Icons.edit_calendar, 
                          onTap: () async {
                            TimeOfDay? hours = await _selectHours(context, registersController.attendanceStartHour);
                            if (hours != null) {
                              registersController.attendanceStartHour = hours;
                              registersController.attendanceStartTime = attendanceStartHourController.text = '${hours.hour}:${hours.minute}';
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
                        onChanged: (value) => registersController.attendanceEndTime = value,
                        suffix: CustomIconButton(
                          radius: 32, 
                          iconData: Icons.watch_later, 
                          onTap: () async {
                            TimeOfDay? hours = await _selectHours(context, registersController.attendanceEndHour);
                            if (hours != null) {
                              registersController.attendanceEndHour = hours;
                              registersController.attendanceEndTime = attendanceEndHourController.text = '${hours.hour}:${hours.minute}';
                            }
                          } 
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Observer(
              builder: (context) {
                return CustomActionButtonGroup(
                  primaryChild: !registersController.isLoading
                      ? const Text('Gerar planilha')
                      : const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()), 
                  secondaryChild: const Text('Anterior'),
                  onSecondaryPressed:  widget.onSecondaryPressed,
                  onPrimaryPressed: !registersController.isLoading
                      ? () {
                        registersController.addToSpreedsheet()
                            .then((value) {
                              _buildSnackBar(context, value);
                            });
                      }
                      : null,
                );
              }
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
                 onPressed: () async {
                  SpreadsheetPdfGenerator spreadsheetPdfGenerator = SpreadsheetPdfGenerator(widget.downloadsDirectory);
                  spreadsheetPdfGenerator.clientSheetCreate()
                      .then((value) => _buildSnackBar(context, value));
                },
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