import 'dart:developer';
import 'dart:io';

import 'package:formulario_de_atendimento/main.dart';
import 'package:formulario_de_atendimento/services/google_auth_api.dart';
import 'package:get_it/get_it.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {

  static Future<String> sendEmail({
    required String subject, 
    required String body,
    required File file,
    }) async {
    final UserSettings userSettings = GetIt.I.get<UserSettings>();
    final GoogleAuthApi googleAuthApi = GetIt.I.get<GoogleAuthApi>();

    var user = googleAuthApi.currentUser;

    if (user == null) {
      await googleAuthApi.signInSilently();
      user = googleAuthApi.currentUser;
    } 

    if (user == null) return 'Sem internet ou login mal sucedido';

    final String userEmail = user.email;
    final auth = await user.authentication;
    final accessToken = auth.accessToken;

    if (accessToken == null) return 'Token de acesso não encontrado, tente logar novamente';

    log('UserEmail: $userEmail');
    log('Destinatário: ${userSettings.email}');

    final smtpServer = gmailSaslXoauth2(userEmail, accessToken);
    

    final message = Message()
      ..from = Address(userEmail, 'Formulário de Atendimento')
      ..recipients = [userSettings.email]
      ..subject = subject
      ..text = body
      ..attachments = [
        FileAttachment(
          file,
        )
      ];

    try {
      await send(message, smtpServer);
      return 'Email enviado com sucesso para ${userSettings.email}'; 
    } on MailerException catch (e) {
      log('MailerException: $e');
      return 'Erro ao enviar o email: $e';
    } catch (e) {
      log(e.toString());
      return 'Erro ao enviar o email: $e';
    }

  }
}