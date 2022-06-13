

import 'dart:developer';
import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  final String username = 'gabriel12saraiva@gmail.com';
  final String password = 'S0uz@rock';
  final accessToken = '';

  Future sendEmail(String email, String subject, String body, File Attachments) async {
    final smtpServer = gmailSaslXoauth2(username, accessToken);

    final message = Message()
      ..from = Address(email, 'Formulário de Atendimento')
      ..recipients.add(email)
      ..subject = subject
      ..text = body;

    try {
      await send(message, smtpServer);
      return 'Email enviado com sucesso!'; 
    } on MailerException catch (e) {
      log('MailerException: $e');
      return 'Erro ao enviar o email';
    } catch (e) {
      log(e.toString());
    }

  }
}