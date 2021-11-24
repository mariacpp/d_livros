import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/criar_conta.dart';
import 'pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'D-livros',
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    theme: ThemeData(
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.dark,
    routes: {
      'login': (context) => const Login(),
      'generos': (context) => const Genres(),
      'cadastro': (context) => const Cadastro(),
      'menu': (context) => const Menu(),
      'pesquisar': (context) => const Pesquisa(),
      //'principal': (context) => Principal(),
      'sobre': (context) => const Sobre(),
      'livros': (context) => const Livros(),
      'rastreio': (context) => const Rastreio(),
    },
  ));
}

var txtNome = TextEditingController();

//
//TELA PRINCIPAL
//

/*class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  var telaAtual = 0;
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      body: PageView(
        controller: pageController,
        children: [
          Genres(),
          Notificacoes(),
        ],
        onPageChanged: (index) {
          setState(() {
            telaAtual = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.yellow[600],
        selectedItemColor: Colors.white.withOpacity(1.0),
        iconSize: 40,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        currentIndex: telaAtual,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Gêneros',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined), label: 'Notificações')
        ],
        onTap: (index) {
          setState(() {
            telaAtual = index;
          });
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
        },
      ),
    );
  }
}*/

//
//GENEROS
//
class Genres extends StatefulWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text('Gêneros'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pushNamed('pesquisar'),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        // ignore: avoid_unnecessary_containers
        child: Container(
            child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: (4 / 1),
          children: [
            ListTile(
              leading: const Icon(
                Icons.snowboarding_outlined,
                color: Colors.white,
              ),
              title: const Text('Aventura'),
              tileColor: Colors.green[700],
              //ontap:
            ),
            const ListTile(
              leading: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              title: Text('Romance'),
              tileColor: Colors.pink,
            ),
            const ListTile(
                leading: Icon(Icons.fingerprint_outlined, color: Colors.white),
                tileColor: Colors.blueGrey,
                title: Text('Detetive')),
            const ListTile(
              leading: Icon(Icons.toys_outlined, color: Colors.white),
              title: Text('Infantil'),
              tileColor: Colors.blue,
            ),
            ListTile(
              leading: const Icon(Icons.sentiment_very_dissatisfied_outlined,
                  color: Colors.white),
              title: const Text('Terror'),
              tileColor: Colors.red[700],
            ),
          ],
        )),
      ),
    );
  }
}
//
//MENU
//

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              txtNome.text,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Biblioteca'),
            onTap: () =>
                {Navigator.popAndPushNamed(context, 'livros')}, //BIBLIOTECA
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Gêneros'),
            onTap: () => {Navigator.pushNamed(context, 'generos')},
          ),
          ListTile(
            leading: const Icon(Icons.motorcycle),
            title: const Text('Rastrear'),
            onTap: () => {Navigator.popAndPushNamed(context, 'rastreio')},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () => {Navigator.pushNamed(context, 'sobre')},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () async => {
              FirebaseAuth.instance.signOut(),
              Navigator.pushReplacementNamed(context, 'login')
            },
          ),
        ],
      ),
    );
  }
}

//
//SEARCH PAGE
//
class Pesquisa extends StatelessWidget {
  const Pesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      //limpa
                    },
                  ),
                  hintText: 'Pesquisar...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}

//
//NOTIFICAÇÕES
//

class Notificacoes extends StatefulWidget {
  const Notificacoes({Key? key}) : super(key: key);

  @override
  _NotificacoesState createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(),
    );
  }
}

//
//SOBRE
//

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //bottomNavigationBar: Principal(),
        drawer: const Menu(),
        appBar: AppBar(),
        body: Container(
            padding: const EdgeInsets.all(40),
            child: Column(children: [
              SizedBox(
                height: 100,
                child: Image.asset('lib/images/dlivros.png'),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'O aplicativo D-Livros auxilia uma biblioteca no emprestimo de livros sem que a pessoa vá até o local buscar o livro. Ele funciona como um aplicativo de delivery comum. No entanto, para livros.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}

//
//LIVROS
//
class Livros extends StatelessWidget {
  const Livros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () => Navigator.of(context).pushNamed('pesquisar'),
            ),
          ],
        ),
        body: Container(
            //width: double.infinity,
            padding: const EdgeInsets.fromLTRB(0, 20, 10, 10),
            child: Scrollbar(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  InkWell(
                      child: SizedBox(
                        height: 400,
                        width: 200,
                        child: Image.asset('lib/images/jogos_vorazes_1.jpg'),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Widgetlivro(
                                    'Suzane Collins',
                                    'lib/images/jogos_vorazes_1.jpg',
                                    'A história ocorre em um futuro pós-apocalíptico e é narrada em primeira pessoa pela personagem Katniss Everdeen. O enredo do livro se desenvolve sob a sua rotina e sua relação com o melhor amigo, Gale (que possui um amor platônico por ela), a irmã Primrose e sua mãe.',
                                    'Jogos Vorazes')));
                      }),
                  InkWell(
                      child: SizedBox(
                        height: 400,
                        width: 200,
                        child: Image.asset('lib/images/opp.jpg'),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Widgetlivro(
                                    'Antoine de Saint-Exupéry',
                                    'lib/images/opp.jpg',
                                    'Um piloto cai com seu avião no deserto e ali encontra uma criança loura e frágil. Ela diz ter vindo de um pequeno planeta distante. E ali, na convivência com o piloto perdido, os dois repensam os seus valores e encontram o sentido da vida.',
                                    'O Pequeno Príncipe')));
                      }),
                  InkWell(
                      child: SizedBox(
                        height: 400,
                        width: 200,
                        child: Image.asset('lib/images/anne.jpg'),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Widgetlivro(
                                    'Anne Frank',
                                    'lib/images/anne.jpg',
                                    'O diário de Anne Frank, o depoimento da pequena Anne, morta pelos nazistas após passar anos escondida no sótão de uma casa em Amsterdã, ainda hoje emociona leitores no mundo inteiro. Suas anotações narram os sentimentos, os medos e as pequenas alegrias de uma menina judia que, como sua família, lutou em vão para sobreviver ao Holocausto.Uma poderosa lembrança dos horrores de uma guerra, um testemunho eloquente do espírito humano. Assim podemos descrever os relatos feitos por Anne em seu diário. Isolados do mundo exterior, os Frank enfrentaram a fome, o tédio e a terrível realidade do confinamento, além da ameaça constante de serem descobertos.',
                                    'O Diário de Anne Frank')));
                      }),
                  InkWell(
                      child: SizedBox(
                        height: 400,
                        width: 200,
                        child: Image.asset('lib/images/omdvu.jpg'),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Widgetlivro(
                                    'Emily Brontë',
                                    'lib/images/omdvu.jpg',
                                    'O morro dos ventos uivantes retrata uma trágica historia de amor e obsessão em que os personagens principais são a obstinada e geniosa Catherine Earnshaw e seu irmão adotivo, Heathcliff. Grosseiro, humilhado e rejeitado, ele guarda apenas rancor no coração, mas tem com Catherine um relaciona- mento marcado por amor e, ao mesmo tempo, ódio. Essa ligação perdura mesmo com o casamento de Catherine com Edgar Linton.',
                                    'O Morro dos Ventos Uivantes')));
                      }),
                  InkWell(
                      child: SizedBox(
                        height: 400,
                        width: 200,
                        child: Image.asset('lib/images/pride.jpg'),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Widgetlivro(
                                    'Jane Austen',
                                    'lib/images/pride.jpg',
                                    'A história de Orgulho e Preconceito gira em torno das cinco irmãs Bennet, que viviam na área rural do interior da Inglaterra, no século XVIII. Aborda a questão da sucessão em uma família sem homens, dentro de uma sociedade patriarcal, onde o casamento era fundamental para as mulheres. Assim, quando um homem rico e solteiro se muda para os arredores, a vida pacata da família entra em ebulição.',
                                    'Orgulho e Preconceito')));
                      }),
                ],
              ),
            )));
  }
}

//
// WIDGET LIVRO
//
class Widgetlivro extends StatelessWidget {
  final String capa;
  final String titulo;
  final String autor;
  final String sinopse;

  const Widgetlivro(this.autor, this.capa, this.sinopse, this.titulo,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                capa,
                //height: 200,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                textDirection: TextDirection.ltr,
                children: [
                  SizedBox(
                    width: 200,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Título: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600])),
                          TextSpan(
                              text: titulo,
                              style: TextStyle(
                                color: Colors.grey[600],
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Autor(a): ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600])),
                          TextSpan(
                              text: autor,
                              style: TextStyle(
                                color: Colors.grey[600],
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Sinopse: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              )),
                          TextSpan(
                              text: sinopse,
                              style: TextStyle(
                                color: Colors.grey[600],
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Sucesso!'),
                                content: Text(
                                    '$titulo alugado com sucesso e logo será entregue!'),
                                actions: [
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.popAndPushNamed(
                                            context, 'rastreio');
                                      },
                                      child: const Text('ok!'),
                                      style: OutlinedButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.yellow.shade800,
                                      )),
                                ],
                              );
                            });
                      },
                      child: const Text('Alugar'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow.shade800,
                          textStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
// RATREAR PEDIDO
//
class Rastreio extends StatefulWidget {
  const Rastreio({Key? key}) : super(key: key);

  @override
  _RastreioState createState() => _RastreioState();
}

class _RastreioState extends State<Rastreio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: double.infinity,
          child: Image.asset(
            'lib/images/map.route.png',
            width: double.infinity,
          ),
        ));
  }
}
