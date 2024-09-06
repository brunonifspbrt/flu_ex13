import 'package:flutter/material.dart';

class Segunda extends StatefulWidget {
  const Segunda({super.key});

  @override
  State<Segunda> createState() => _SegundaState();
}

class _SegundaState extends State<Segunda> {
  // FocusNode para definir o campo que receberá o foco após clicar no botão limpar ou enviar
  var fnNome = FocusNode();
  // pode declarar FocusNode assim também
  //FocusNode fnNome = FocusNode();

  // controle pra manipular os campos
  var tfNome = TextEditingController();
  // pode declarar da forma abaixo também
  //TextEditingController tfNome = TextEditingController();
  var tfSobrenome = TextEditingController();
  var tfNasc = TextEditingController();
  var tfPass = TextEditingController();

  String ajudaData = 'Exemplo: 01/01/1970';
  String ajudaPass = '';

  // para usar em senha
  bool ocultaSenha = true;

  @override
  // ao abrir a janela geral
  void initState() {
    super.initState();

    fnNome = FocusNode();
    verificaSenha('');
  }

  // ao fechar a janela geral
  void disposed() {
    // tira objeto da memória
    fnNome.dispose();
  }

  void limpaCampos() {
    tfNome.clear();
    tfSobrenome.clear();
    tfNasc.clear();
    tfPass.clear();
    // após limpar os campos foca no campo Nome
    fnNome.requestFocus();
  }

  void verificaSenha(String tx) {
    var errorMsg = '';
    // verifica se tem letra maiúscula
    var reg = RegExp(r'(?=.*[A-Z])');

    if (tx.length < 8) {
      errorMsg = 'A senha deve ter no mínimo 8 caracteres';
    }

    if (!reg.hasMatch(tx)) {
      errorMsg += '\n' 'A senha deve conter uma letra maiúscula';
    }

    // verifica se tem letra ao menos 3 números (apliquei o 2 aqui pois a partir do 3 número a mensagem some)
    reg = RegExp(r'(?=.*?(\D*\d){3})');
    if (!reg.hasMatch(tx)) {
      errorMsg += '\n' 'A senha deve conter 3 números';
    }

    // verifica se tem mínimo 2 caracteres especiais
    reg = RegExp(r'(?=.*?[!@#$%^&*()?\-\+=]{2})');
    // perceba que aqui usou-se o r pra raw string. Assim o texto após o r será considerado realmente como string
    if (!reg.hasMatch(tx)) {
      errorMsg += '\n'
          'A senha deve conter 2 caracteres especiais: '
          r'!@#$'
          '%'
          '^&*()?_-+=';
    }

    setState(() {
      ajudaPass = errorMsg;
    });

    // define variável com padrão regex de data
    // a expressão é:
    // \d{1,2} 1 a 2 digitos para dia e mês
    // \/ deve usar / para separar dia mês e ano
    // \d{2,4}  2 a 4  digitos para ano
    // var reg = RegExp(r'\d{1,2}\/\d{1,2}\/\d{2,4}');
    // if (reg.hasMatch(text)) {
    //   setState(() {
    //     ajudaData = '';
    //   });
    // } else {
    //   setState(() {
    //     ajudaData =
    //         'Data deve ser no formato dd/mm/yyyy. Ex: 01/01/2000';
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // para adicionar mais de um widget é necessário adicionar column que tem propriedade Children
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                autofocus:
                    true, // ao exibir a tela o campo nome será o primeiro com foco
                controller: tfNome,
                focusNode:
                    fnNome, // vincula a variável de foco na propriedade focusNode
                decoration: const InputDecoration(
                    // adicionou: Borda, placeholder
                    // precisa informar o enableBorder
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue)),
                    hintText: 'Nome:',
                    helperText: 'E aí, qual seu nome?'),
              ),
            ),
            // aqui coloquei espaço, de altura, de 50 entre os dois widgets
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: tfSobrenome,
                decoration: const InputDecoration(
                    // adicionou: Borda, placeholder
                    // precisa informar o enableBorder
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue)),
                    hintText: 'Sobrenome:',
                    helperText: 'Tem sobrenome, John Doe?'),
              ),
            ),
            // aqui coloquei espaço, de altura, de 50 entre os dois widgets
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: tfNasc,
                // coloco async pra pegar o valor atual do campo, caso não queira, use o controller do campo
                onChanged: (text) async {
                  // define variável com padrão regex de data
                  // a expressão é:
                  // \d{1,2} 1 a 2 digitos para dia e mês
                  // \/ deve usar / para separar dia mês e ano
                  // \d{2,4}  2 a 4  digitos para ano
                  var reg = RegExp(r'\d{1,2}\/\d{1,2}\/\d{2,4}');
                  if (reg.hasMatch(text)) {
                    setState(() {
                      ajudaData = '';
                    });
                  } else {
                    setState(() {
                      ajudaData =
                          'Data deve ser no formato dd/mm/yyyy. Ex: 01/01/2000';
                    });
                  }
                },
                decoration: InputDecoration(
                    // adicionou: Borda, placeholder
                    // precisa informar o enableBorder
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue)),
                    hintText: 'Nascimento:',
                    helperText: ajudaData),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: tfPass,
                obscureText: ocultaSenha,
                // coloco async pra pegar o valor atual do campo, caso não queira, use o controller do campo
                onChanged: (text) async {
                  verificaSenha(text);
                },
                decoration: InputDecoration(
                    // adicionou: Borda, placeholder
                    // precisa informar o enableBorder
                    // helperMaxLines informa quantas linhas terá o texto
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blue)),
                    hintText: 'Senha:',
                    helperText: ajudaPass,
                    helperMaxLines: 4),
              ),
            ),
            Row(
              // alinhamento dos botões é no final da linha
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: limpaCampos,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text('Limpar')),
                // aqui coloquei espaço, de altura, de 50 entre os dois widgets
                const SizedBox(width: 50),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      // aqui coloco a cor de fundo azul e a cor do texto branco
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text('Enviar')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
