import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:posmpi_kotlin/pages/configuration/configuration_controller.dart';
import 'package:posmpi_kotlin/pages/configuration/configuration_page.dart';
import 'package:posmpi_kotlin/pages/home/home_page.dart';
import 'package:posmpi_kotlin/pages/login/login_controller.dart';
import 'package:posmpi_kotlin/requesters/requesters.dart';
import 'package:posmpi_kotlin/widgets/botao_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  LoginController loginController = Get.find();
  ConfigurationController configurationController = Get.find();
  bool salvaSenha = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          color: Color(0xff202421),
          height: MediaQuery.sizeOf(context).height * 1,
          child: Column(children: [
            Container(
              child: Image.asset(
                "lib/assets/logo/logo.png",
                width: 250,
                height: 200,
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.7,
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: loginController.usuario,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Usuário",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // Define a cor da borda quando o campo não está focado
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // Define a cor da borda quando o campo não está focado
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: loginController.senha,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // Define a cor da borda quando o campo não está focado
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // Define a cor da borda quando o campo não está focado
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Obx(() => Checkbox(
                        checkColor: Colors.white,
                        side: BorderSide(color: Colors.white),
                        activeColor: Colors.orange,
                        value: loginController.salvaSenha.value,
                        onChanged: (value) {
                          print(value);
                          loginController.salvaSenha.value = value!;
                        })),
                    Text(
                      "Salvar login",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                BotaoPrincipal(
                  nome: "Login",
                  function: () async {
                    if (await loginController.login(
                        loginController.usuario.text,
                        loginController.senha.text)) {
                      int id = await configurationController.getData();
                      print(id);
                      if (loginController.salvaSenha.value) {
                        loginController.saveUser(
                            usuario: loginController.usuario.text,
                            senha: loginController.senha.text,
                            salvaSenha: loginController.salvaSenha.value);
                      }

                      if (id != null && id != 0) {

                      await   Get.to(HomePage());
                      }else {
                        await Get.to(ConfigurationPage());
                      }
                    } else {
                      return Get.dialog(
                        Container(
                          width: 200,
                          height: 300,
                          child: Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Não foi possível realizar login'),
                                  const SizedBox(height: 15),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Fechar'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
              ]),
            )
          ]),
        ),
      ),
    ));
  }
}
