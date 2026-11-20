import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon CV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

// ==================== PAGE 1 : CONNEXION ====================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // Pour cet exercice, n'importe quel identifiant/mot de passe fonctionne.
    // Dans une vraie app, vérifiez les identifiants.
    if (_idController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 80, color: Colors.blue),
            const SizedBox(height: 30),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Identifiant',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true, // Masque le mot de passe
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== PAGE 2 : ACCUEIL / CV ====================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo et Nom
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  // Remplacez par votre propre image (AssetImage ou NetworkImage)
                  backgroundImage: const AssetImage('yakin.jpg'),
                ),
                const SizedBox(height: 10),
                const Text('SEBUGAYA YAKIN PIERROT', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('Développeur Mobile Flutter', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Formation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const ListTile(
            leading: Icon(Icons.school),
            title: Text('Licence en Informatique'),
            subtitle: Text('ISIG-GOMA - 2026'),
          ),
          const Divider(),
          const Text('Expériences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const ListTile(
            leading: Icon(Icons.work),
            title: Text('Stage en developpement mobile'),
            subtitle: Text('Entreprise X - 2025'),
          ),
          const ListTile(
            leading: Icon(Icons.code),
            title: Text('Projet Personnel'),
            subtitle: Text('Application de gestion de tâches - 2025'),
          ),
          const Divider(),
          const Text('Compétences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Wrap(
            spacing: 8.0,
            children: [
              Chip(label: Text('Programmation web')),
              Chip(label: Text('Python')),
              Chip(label: Text('Firebase')),
              Chip(label: Text('Git')),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Langues', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const ListTile(leading: Icon(Icons.language), title: Text('Français (Natif)')),
          const ListTile(leading: Icon(Icons.language), title: Text('Anglais (Courant)')),
          const Divider(),
          const Text('Centres d\'intérêt', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const ListTile(leading: Icon(Icons.sports), title: Text('Basketball')),
          const ListTile(leading: Icon(Icons.music_note), title: Text('Musique & dance')),
        ],
      ),
    );
  }
}

// ==================== PAGE 3 : FAMILLE ====================
class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des membres de la famille (données en dur pour l'exemple)
    final List<Map<String, String>> familyMembers = [
      {
        'name': 'SHEMA NTSINZI Paul',
        'relation': 'Père',
        'job': 'Pasteur',
        'image': 'https://via.placeholder.com/150'
      },
      {
        'name': 'HOSANNA Deborah',
        'relation': 'Mère',
        'job': 'Pasteure',
        'image': 'https://via.placeholder.com/150'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: familyMembers.length,
      itemBuilder: (context, index) {
        final member = familyMembers[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(member['image']!),
            ),
            title: Text(member['name']!),
            subtitle: Text('${member['relation']} - ${member['job']}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}

// ==================== PAGE 4 : CONTACT ====================
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  // Fonction pour lancer un appel ou un lien
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Impossible de lancer $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ListTile(
          leading: const Icon(Icons.phone, color: Colors.blue),
          title: const Text('Téléphone'),
          subtitle: const Text('+243 979 130 409'),
          onTap: () => _launchUrl('tel:+243979130409'), // Lance l'appel
        ),
        ListTile(
          leading: const Icon(Icons.email, color: Colors.red),
          title: const Text('E-mail'),
          subtitle: const Text('shemayakin@gmail.com'),
          onTap: () => _launchUrl('mailto:shemayakin@gmail.com'), // Lance l'email
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.green),
          title: const Text('Adresse'),
          subtitle: const Text('rue des aviateurs, Goma'),
          onTap: () {
            // Ouvre Google Maps avec l'adresse
            _launchUrl('https://www.google.com/maps/search/?api=1&query=Goma');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.link, color: Colors.blueAccent),
          title: const Text('LinkedIn'),
          subtitle: const Text('linkedin.com/in/yakin-shema-718900450'),
          onTap: () => _launchUrl('https://www.linkedin.com/in/yakin-shema-718900450'),
        ),
        ListTile(
          leading: const Icon(Icons.code, color: Colors.black),
          title: const Text('GitHub'),
          subtitle: const Text('github.com/Yakin-Shema'),
          onTap: () => _launchUrl('https://github.com/Yakin-Shema'),
        ),
      ],
    );
  }
}

// ==================== NAVIGATION PRINCIPALE ====================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FamilyPage(),
    const ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Application CV'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          )
        ],
      ),
      body: _pages[_currentIndex], // Affiche la page sélectionnée
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'CV'),
          BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: 'Famille'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Contact'),
        ],
      ),
    );
  }
}