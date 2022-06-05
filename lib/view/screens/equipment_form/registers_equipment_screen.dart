import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_action_form_group.dart';
import '../../widgets/custom_app_buttom.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_outlined_buttom.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_text_label.dart';

class RegistersEquipmentScreen extends StatefulWidget {
  final VoidCallback? onSecondaryPressed;
  const RegistersEquipmentScreen({Key? key, this.onSecondaryPressed}) : super(key: key);

  @override
  State<RegistersEquipmentScreen> createState() => _RegistersEquipmentScreenState();
}

class _RegistersEquipmentScreenState extends State<RegistersEquipmentScreen> {
  final TextEditingController attendantController = TextEditingController();
  final TextEditingController dateStartController = TextEditingController();
  final TextEditingController dateEndController = TextEditingController();
  final TextEditingController timeStartController = TextEditingController();
  final TextEditingController timeEndController = TextEditingController();
  TimeOfDay? timeStart;
  TimeOfDay? timeEnd;


  @override
  void initState() {
    super.initState();
    dateStartController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CustomTextLabel('Atendimento',),
            CustomTextField(
              controller: attendantController,
              hint: 'Nome do atendente',
              obscure: false, 
              onChanged: (value) => {},
              prefix: const Icon(Icons.person)
            ),
            const CustomTextLabel(
              'Início',
              fontSize: 16,
            ),
             Row(
              children: [
                Flexible(
                 child: CustomTextField(
                    controller: dateStartController,
                    hint: 'Data',
                      suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.edit_calendar, 
                      onTap: () async {
                        dateStartController.text = await _selectDate(context);
                      }
                    ),
                    onChanged: (value) => {},
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CustomTextField(
                    controller: timeStartController,
                    hint: 'Ex: 09:00',
                    suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.watch_later_rounded, 
                      onTap: () async {
                        TimeOfDay? hours = await _selectHours(context, timeStart);
                        if (hours != null) {
                          timeStart = hours;
                          timeStartController.text = '${hours.hour}:${hours.minute}';
                        }
                      },
                    ),
                    onChanged: (value) => {},
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
                 child: CustomTextField(
                    controller: dateEndController,
                    hint: 'Data',
                      suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.edit_calendar, 
                      onTap: () async {
                        dateEndController.text = await _selectDate(context);
                      }
                    ),
                    onChanged: (value) => {},
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: CustomTextField(
                    controller: timeEndController,
                    hint: 'Ex: 09:00',
                    suffix: CustomIconButton(
                      radius: 32, 
                      iconData: Icons.watch_later_rounded, 
                      onTap: () async {
                        TimeOfDay? hours = await _selectHours(context, timeEnd);
                        if (hours != null) {
                          timeEnd = hours;
                          timeEndController.text = '${hours.hour}:${hours.minute}';
                        }
                      },
                    ),
                    onChanged: (value) => {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomActionButtonGroup(
              primaryChild: const Text('Gerar planilha'),
              secondaryChild: const Text('Anterior'),
              onPrimaryPressed: null,
              onSecondaryPressed: widget.onSecondaryPressed,
            ),
            const SizedBox(height: 32),
            CustomOutlinedButtom(
              onPressed: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Salvar planilha'),
                  SizedBox(width: 8),
                  Icon(Icons.save),
                ],
              ), 
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
          ]
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
}