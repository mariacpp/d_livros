import 'package:cloud_firestore/cloud_firestore.dart';
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
      'sugestoes': (context) => const SugestaoPage(),
    },
  ));
}

var txtNome = TextEditingController();

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
            leading: const Icon(Icons.pending_actions),
            title: const Text('Sugestões'),
            onTap: () => {Navigator.pushNamed(context, 'sugestoes')},
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
class Livros extends StatefulWidget {
  const Livros({Key? key}) : super(key: key);

  @override
  State<Livros> createState() => _LivrosState();
}

class _LivrosState extends State<Livros> {
  late CollectionReference livros;

  @override
  void initState() {
    super.initState();
    livros = FirebaseFirestore.instance.collection('/livros');
  }

  exibirLivro(livro) {
    String titulo = livro.data()['titulo'];
    String autor = livro.data()['autor'];
    String sinopse = livro.data()['sinopse'];
    String capa = livro.data()['capa'];

    return InkWell(
        child: SizedBox(
          height: 400,
          width: 200,
          child: Image.asset(capa),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Widgetlivro(
                        autor,
                        capa,
                        sinopse,
                        titulo,
                      )));
        });
  }

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
        body: StreamBuilder<QuerySnapshot>(
            stream: livros.snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Text('Não foi possivel conectar...'),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  final dados = snapshot.requireData;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return exibirLivro(dados.docs[index]);
                    },
                    itemCount: dados.docs.length,
                  );
              }
            }));
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

class SugestaoPage extends StatefulWidget {
  const SugestaoPage({Key? key}) : super(key: key);

  @override
  _SugestaoPageState createState() => _SugestaoPageState();
}

class _SugestaoPageState extends State<SugestaoPage> {
  late CollectionReference sugestoes;
  var txtTitulo = TextEditingController();
  var txtAutor = TextEditingController();
  @override
  void initState() {
    super.initState();
    sugestoes = FirebaseFirestore.instance.collection('/sugestoes');
  }

  exibirItemColecao(item) {
    String titulo = item.data()['titulo'];
    String autor = item.data()['autor'];
    return ListTile(
      title: Text(
        titulo,
        style: const TextStyle(fontSize: 25),
      ),
      subtitle: Text(
        autor,
        style: const TextStyle(fontSize: 15),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          //APAGR
          sugestoes.doc(item.id).delete();
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sugestões'),
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      //
      //LISTAR DOCUMENTOS DA COLEÇÃO
      //
      body: StreamBuilder<QuerySnapshot>(
        stream: sugestoes.snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: Text('Não foi possivel conectar'));
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              final dados = snapshot.requireData;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return exibirItemColecao(dados.docs[index]);
                },
                itemCount: dados.docs.length,
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Nova Sugestão'),
                    content: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          TextField(
                            controller: txtTitulo,
                            decoration: const InputDecoration(
                              hintText: 'Título',
                            ),
                          ),
                          TextField(
                            controller: txtAutor,
                            decoration: const InputDecoration(
                              hintText: 'Autor',
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancelar')),
                      TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('sugestoes')
                                .add({
                              'titulo': txtTitulo.text,
                              'autor': txtAutor.text,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sugestão feita com sucesso!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('ok')),
                    ],
                  ));
        },
      ),
    );
  }
}
