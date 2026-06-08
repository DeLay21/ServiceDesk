import 'package:flutter/material.dart';

const String politicaPrivacidade = '''
Sua privacidade é importante para nós. Esta Política de Privacidade descreve como coletamos, utilizamos, armazenamos e protegemos as informações fornecidas pelos usuários do aplicativo.

1. Informações Coletadas

Podemos coletar as seguintes informações:

• Nome completo;
• Endereço de e-mail;
• Número de telefone;
• Informações de cadastro profissional;
• Dados de agendamentos e serviços cadastrados;
• Informações necessárias para o funcionamento da aplicação.

2. Como Utilizamos as Informações

As informações coletadas são utilizadas para:

• Permitir o cadastro e autenticação dos usuários;
• Gerenciar agendamentos e serviços;
• Melhorar a experiência de uso da plataforma;
• Enviar comunicações relacionadas ao funcionamento do aplicativo;
• Cumprir obrigações legais quando aplicável.

3. Compartilhamento de Dados

Não vendemos informações pessoais dos usuários.

Os dados poderão ser compartilhados apenas quando necessário para a prestação dos serviços da plataforma, por exigência legal ou mediante consentimento do usuário.

4. Armazenamento e Segurança

Adotamos medidas técnicas e organizacionais para proteger os dados dos usuários contra acesso não autorizado, alteração, divulgação ou destruição indevida.

Embora empreguemos boas práticas de segurança, nenhum sistema é completamente seguro e não podemos garantir proteção absoluta contra todas as ameaças existentes.

5. Direitos dos Usuários

O usuário poderá solicitar:

• Acesso aos seus dados;
• Correção de informações incorretas;
• Exclusão de seus dados, quando aplicável;
• Revogação de consentimentos concedidos.

6. Alterações nesta Política

Esta Política poderá ser atualizada periodicamente. Recomendamos que o usuário consulte esta página regularmente para verificar eventuais alterações.
''';

const String termosCondicoes = '''
Ao utilizar este aplicativo, o usuário concorda com os presentes Termos e Condições de Uso.

1. Objetivo da Plataforma

O aplicativo tem como finalidade auxiliar profissionais e empresas na organização e gerenciamento de serviços, clientes e agendamentos.

2. Cadastro e Conta

Para utilizar determinadas funcionalidades poderá ser necessário criar uma conta.

O usuário é responsável por:

• Fornecer informações verdadeiras e atualizadas;
• Manter a confidencialidade de suas credenciais de acesso;
• Responder por todas as atividades realizadas em sua conta.

3. Responsabilidades do Usuário

O usuário compromete-se a:

• Utilizar a plataforma de forma lícita;
• Não praticar atividades que comprometam a segurança do sistema;
• Não utilizar o aplicativo para fins ilegais ou fraudulentos.

4. Disponibilidade do Serviço

Empregamos esforços razoáveis para manter o serviço disponível, mas não garantimos funcionamento ininterrupto ou livre de erros.

Poderão ocorrer interrupções para manutenção, atualizações ou situações fora de nosso controle.

5. Propriedade Intelectual

Todos os direitos relacionados ao aplicativo, incluindo design, logotipos, funcionalidades e conteúdos disponibilizados pela plataforma, são protegidos pela legislação aplicável.

6. Limitação de Responsabilidade

O aplicativo atua como ferramenta de gerenciamento e organização.

O usuário é integralmente responsável pelas informações cadastradas, pelos serviços oferecidos e pelos compromissos assumidos com seus clientes.

7. Suspensão ou Encerramento de Conta

Poderemos suspender ou encerrar contas que violem estes Termos ou utilizem a plataforma de forma inadequada.

8. Alterações dos Termos

Os presentes Termos poderão ser alterados a qualquer momento. O uso continuado do aplicativo após as alterações será considerado como aceitação das novas condições.

9. Legislação Aplicável

Estes Termos serão regidos pelas leis da República Federativa do Brasil.
''';

class PoliticaPrivacidade extends StatelessWidget {
  const PoliticaPrivacidade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Política de Privacidade',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(14, 51, 107, 1),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color.fromRGBO(197, 206, 220, 0.996),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Última atualização: 15/07/2026',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(14, 51, 107, 1),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Política de Privacidade',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(14, 51, 107, 1),
              ),
            ),

            const SizedBox(height: 10),

            const SelectableText(
              politicaPrivacidade,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 30),

            const Text(
              'Termos e Condições',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(14, 51, 107, 1),
              ),
            ),

            const SizedBox(height: 10),

            const SelectableText(
              termosCondicoes,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
