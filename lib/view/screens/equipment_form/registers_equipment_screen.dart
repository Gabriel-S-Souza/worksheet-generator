import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/controllers/equipment_form/general_equipment_controller.dart';
import 'package:formulario_de_atendimento/main.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../controllers/equipment_form/registers_equipment_controller.dart';
import '../../widgets/custom_action_form_group.dart';
import '../../widgets/custom_app_buttom.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_outlined_buttom.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_text_label.dart';

class RegistersEquipmentScreen extends StatefulWidget {
  final VoidCallback? onSecondaryPressed;
  const RegistersEquipmentScreen({Key? key, this.onSecondaryPressed,}) : super(key: key);

  @override
  State<RegistersEquipmentScreen> createState() => _RegistersEquipmentScreenState();
}

class _RegistersEquipmentScreenState extends State<RegistersEquipmentScreen> {
  final TextEditingController attendantController = TextEditingController();
  final TextEditingController dateStartController = TextEditingController();
  final TextEditingController dateEndController = TextEditingController();
  final TextEditingController timeStartController = TextEditingController();
  final TextEditingController timeEndController = TextEditingController();

  final UserSettings userSettings = GetIt.I<UserSettings>();
  final GeneralEquipmentController generalEquipmentController = GetIt.I<GeneralEquipmentController>();
  final RegistersEquipmentController registersEquipmentController = RegistersEquipmentController();

  @override
  void initState() {
    super.initState();
    registersEquipmentController.attedanceStartDate = registersEquipmentController.attedanceEndDate =
        dateEndController.text = dateStartController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    attendantController.text = userSettings.name ?? '';
  }

  @override
  void dispose() {
    attendantController.dispose();
    dateStartController.dispose();
    dateEndController.dispose();
    timeStartController.dispose();
    timeEndController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
         child: Observer(
           builder: (context) {
             return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const CustomTextLabel('Atendimento',),
                const CustomTextLabel(
                  'Atendente(s):',
                  fontSize: 16,
                  marginTop: 8,
                  marginBottom: 0,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                  ),
                  alignment: Alignment.topCenter,
                  child: CustomTextLabel(
                    registersEquipmentController.attendants.join(', '),
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                CustomTextField(
                  controller: attendantController,
                  hint: 'Nome do atendente',
                  obscure: false, 
                  onChanged: (value) => setState(() {}),
                  onSubmitted:attendantController.text.isNotEmpty
                        ? () {
                          registersEquipmentController.attendants.add(attendantController.text);
                          attendantController.clear();
                        } 
                        : null,
                  prefix: const Icon(Icons.person)
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: CustomOutlinedButtom(
                    onPressed: attendantController.text.isNotEmpty
                        ? () {
                          registersEquipmentController.attendants.add(attendantController.text);
                          attendantController.clear();
                        } 
                        : null,
                    child: const Text('Adicionar atendente'),
                  ),
                ),
                const CustomTextLabel(
                  'Início',
                  fontSize: 16,
                ),
                 Row(
                  children: [
                    Flexible(
                     child: GestureDetector(
                       onTap: () async {
                          dateStartController.text = await _selectDate(context);
                          registersEquipmentController.attedanceStartDate = dateStartController.text;
                          registersEquipmentController.calculateHoursDifference();
                        },
                       behavior: HitTestBehavior.translucent,
                       child: IgnorePointer(
                         child: CustomTextField(
                           readOnly: true,
                            controller: dateStartController,
                            hint: 'Data',
                              suffix: CustomIconButton(
                              radius: 32, 
                              iconData: Icons.edit_calendar, 
                              onTap: () {},
                            ),
                            onChanged: (value) => {},
      
                          ),
                       ),
                     ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: GestureDetector(
                        onTap: () async {
                          TimeOfDay? hours = await _selectHours(context, registersEquipmentController.attendanceStartTimeOfDay);
                          if (hours != null) {
                            registersEquipmentController.attendanceStartTimeOfDay = hours;
                            String hoursFormated = hours.hour < 10 ? '0${hours.hour}' : '${hours.hour}';
                            String minutesFormated = hours.minute < 10 ? '0${hours.minute}' : '${hours.minute}';
                            registersEquipmentController.attedanceStartHour = timeStartController.text = '$hoursFormated:$minutesFormated';
                            registersEquipmentController.calculateHoursDifference();
                          }
                        },
                        behavior: HitTestBehavior.translucent,
                        child: IgnorePointer(
                          child: CustomTextField(
                            readOnly: true,
                            controller: timeStartController,
                            hint: 'Ex: 09:00',
                            suffix: CustomIconButton(
                              radius: 32, 
                              iconData: Icons.watch_later_rounded, 
                              onTap: () {}
                            ),
                            onChanged: (value) => {},
      
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const CustomTextLabel(
                  'Final',
                  fontSize: 16,
                ),
                 Row(
                  children: [
                    Flexible(
                     child: GestureDetector(
                       onTap: () async {
                          dateEndController.text = await _selectDate(context);
                          registersEquipmentController.attedanceEndDate = dateEndController.text;
                          registersEquipmentController.calculateHoursDifference();
                        },
                       behavior: HitTestBehavior.translucent,
                       child: IgnorePointer(
                         child: CustomTextField(
                            readOnly: true,
                            controller: dateEndController,
                            hint: 'Data',
                              suffix: CustomIconButton(
                              radius: 32, 
                              iconData: Icons.edit_calendar, 
                              onTap: () {},
                            ),
                            onChanged: (value) => {},
                          ),
                       ),
                     ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: GestureDetector(
                        onTap: () async {
                          TimeOfDay? hours = await _selectHours(context, registersEquipmentController.attendanceEndTimeOfDay);
                          if (hours != null) {
                            registersEquipmentController.attendanceEndTimeOfDay = hours;
                            String hoursFormated = hours.hour < 10 ? '0${hours.hour}' : '${hours.hour}';
                            String minutesFormated = hours.minute < 10 ? '0${hours.minute}' : '${hours.minute}';
                            registersEquipmentController.attedanceEndHour = timeEndController.text = '$hoursFormated:$minutesFormated';
                            registersEquipmentController.calculateHoursDifference();
                          }
                        },
                        behavior: HitTestBehavior.translucent,
                        child: IgnorePointer(
                          child: CustomTextField(
                            readOnly: true,
                            controller: timeEndController,
                            hint: 'Ex: 09:00',
                            suffix: CustomIconButton(
                              radius: 32, 
                              iconData: Icons.watch_later_rounded, 
                              onTap: () {}
                            ),
                            onChanged: (value) => {},
      
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                !registersEquipmentController.isTotalOfHoursEditable
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end, 
                        children: [
                          const CustomTextLabel( 'Total de horas:  ', color: Colors.black54, marginBottom: 22,),
                          CustomTextLabel(registersEquipmentController.totalOfHours ?? '00:00', color: Colors.black54, marginBottom: 22,),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: () => registersEquipmentController.isTotalOfHoursEditable = true,
                            child: const Text('Editável', style: TextStyle(fontSize: 12)),
                          )
                        ]
                      )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextLabel( 'Total de horas', fontSize: 16,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end, 
                            children: [
                              Expanded(
                                child: CustomTextField( 
                                  hint: 'Total de horas',
                                  prefix: const Icon(Icons.timer),
                                  onChanged: (value) => registersEquipmentController.totalOfHours = value,    
                                  obscure: false,                     
                                ),
                              ),
                              const SizedBox(width: 16),
                              TextButton(
                                onPressed: () => registersEquipmentController.isTotalOfHoursEditable = false,
                                child: const Text('Automático', style: TextStyle(fontSize: 12)),
                              )
                            ]
                          ),
                      ],
                    ),
                const CustomTextLabel(
                  'Texto de email',
                  fontSize: 16,
                ),
                CustomTextField(
                  hint: 'Texto do email',
                  prefix: const Icon(Icons.text_fields),
                  onChanged: (value) => registersEquipmentController.emailDescription = value,
                ),
                const SizedBox(height: 40),
                CustomActionButtonGroup(
                  onPrimaryPressed:!registersEquipmentController.isLoading
                      ? () async {
                          await registersEquipmentController.save();
                        }
                      : null,
                  primaryChild: !registersEquipmentController.isLoading
                      ? const Text('Salvar')
                      : const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()), 
                  secondaryChild: const Text('Anterior'),
                  onSecondaryPressed: widget.onSecondaryPressed,
                ),
                const SizedBox(height: 32),
                CustomAppButtom(
                  onPressed: 
                  !registersEquipmentController.loadOnExport && registersEquipmentController.readyToSave
                      ? () async {
                        registersEquipmentController.loadOnExport = true; 
                        generalEquipmentController.export()
                          .then((value) {
                                _buildSnackBar(context, value);
                                registersEquipmentController.loadOnExport = false; 
                              })
                          .catchError((value) {
                                _buildSnackBar(context, value);
                                registersEquipmentController.loadOnExport = false; 
                              });
                      }
                      : null,
                  child: !registersEquipmentController.loadOnExport
                      ?  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Exportar planilha'),
                            SizedBox(width: 8),
                            Icon(Icons.save),
                          ],
                        )
                      : const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()),
                    ),
                const SizedBox(height: 28),
                CustomAppButtom(
                  onPressed: !registersEquipmentController.loadOnSend && registersEquipmentController.readyToSendEmail
                      ? () async {
                        registersEquipmentController.loadOnSend = true;
                        generalEquipmentController.sendByEmail(body: registersEquipmentController.emailDescription)
                            .then((value) {
                                _buildSnackBar(context, value);
                                 registersEquipmentController.loadOnSend = false;
                              })
                            .catchError((value) {
                                _buildSnackBar(context, value);
                                registersEquipmentController.loadOnSend = false; 
                              });
                        }
                      : null,
                  child: !registersEquipmentController.loadOnSend
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Receber no email'),
                          SizedBox(width: 8),
                          Icon(Icons.email),
                        ],
                      )
                      : const SizedBox(width: 24, height: 24, child: CircularProgressIndicator()),
                ),
                const SizedBox(height: 40),
              ]
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
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}