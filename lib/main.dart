import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EventoApp());
}

class EventoApp extends StatelessWidget {
  const EventoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evento teste',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: const Color(0xFF00FFC6),
          onPrimary: Colors.black,
          secondary: const Color(0xFF1A1A40),
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.black,
          background: const Color(0xFF181824),
          onBackground: Colors.white,
          surface: const Color(0xFF23233A),
          onSurface: Colors.white,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF181824),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF23233A),
          elevation: 8,
          shadowColor: Color(0xFF00FFC6),
          titleTextStyle: TextStyle(
            color: Color(0xFF00FFC6),
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF23233A),
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          shadowColor: const Color(0xFF00FFC6),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF00FFC6),
          foregroundColor: Colors.black,
        ),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color(0xFF7F00FF),
          onPrimary: Colors.white,
          secondary: const Color(0xFF00FFC6),
          onSecondary: Colors.black,
          error: Colors.redAccent,
          onError: Colors.white,
          background: const Color(0xFFF5F6FA),
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7F00FF),
          elevation: 8,
          shadowColor: Color(0xFF00FFC6),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          shadowColor: const Color(0xFF7F00FF),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF7F00FF),
          foregroundColor: Colors.white,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool isTheme = false;
  ThemeMode theme = ThemeMode.dark;

  final List<Widget> _screens = [
    HomeScreen(),
    FotosScreen(),
    InformacoesScreen(),
    AgendaScreen(),
    OpcoesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTheme() {
    setState(() {
      theme = theme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Color(0xFF00FFC6), Color(0xFF7F00FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'Evento App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 8,
        shadowColor: theme.appBarTheme.shadowColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTheme,
        child: const Icon(CupertinoIcons.moon_stars),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_alt_fill),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.photo_camera_solid),
                label: 'Fotos',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.info),
                label: 'Informações',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.time),
                label: 'Agenda',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.gear_solid),
                label: 'Opções',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.5),
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }
}

// Home Screen - Interação: Botão para dar boas-vindas
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: const LinearGradient(
            colors: [Color(0xFF23233A), Color(0xFF181824)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.18),
              blurRadius: 32,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'asset/images/logo.jpg',
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Color(0xFF00FFC6), Color(0xFF7F00FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: const Text(
                  'astronoeme',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '2025',
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.primary.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Cosmo Noeme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.primary,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 32),
              _FuturisticButton(
                label: 'nossa sala',
                icon: CupertinoIcons.person_2_fill,
                color: theme.colorScheme.primary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Bem-vindo à nossa sala!')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _FuturisticButton(
                label: 'jogo',
                icon: CupertinoIcons.game_controller_solid,
                color: const Color(0xFF00FFC6),
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Vamos jogar!')));
                },
              ),
              const SizedBox(height: 16),
              _FuturisticButton(
                label: 'jornada atronomica',
                icon: CupertinoIcons.rocket_fill,
                color: const Color(0xFF7F00FF),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Explorando a jornada astronômica!'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _FuturisticButton(
                label: 'agradecimentos',
                icon: CupertinoIcons.heart_fill,
                color: Colors.amber,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Agradecemos sua presença!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FuturisticButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  const _FuturisticButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white, size: 26),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 10,
          shadowColor: color.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

// Fotos Screen - Interação: Galeria de imagens (mock)
class FotosScreen extends StatelessWidget {
  final List<String> _imageUrls = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: _imageUrls.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          _imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                child: Image.network(_imageUrls[index], fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Informações Screen - Interação: Card com informações do evento
class InformacoesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Informações do Evento',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Data: 20 de Julho de 2025'),
              Text('Local: Centro de Convenções'),
              Text('Horário: 09:00 - 18:00'),
            ],
          ),
        ),
      ),
    );
  }
}

// Agenda Screen - Interação: Lista de atividades
class AgendaScreen extends StatelessWidget {
  final List<Map<String, String>> _atividades = [
    {'hora': '09:00', 'titulo': 'Abertura'},
    {'hora': '10:00', 'titulo': 'Palestra: Inovação'},
    {'hora': '12:00', 'titulo': 'Almoço'},
    {'hora': '14:00', 'titulo': 'Workshop: Tecnologia'},
    {'hora': '16:00', 'titulo': 'Painel de Discussão'},
    {'hora': '17:30', 'titulo': 'Encerramento'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: _atividades.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(16),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(
                  _atividades[index]['hora']!,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              title: Text(
                _atividades[index]['titulo']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Opções Screen - Interação: Switch para modo escuro
class OpcoesScreen extends StatefulWidget {
  @override
  State<OpcoesScreen> createState() => _OpcoesScreenState();
}

class _OpcoesScreenState extends State<OpcoesScreen> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Opções',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Modo Escuro'),
                  Switch(
                    value: _darkMode,
                    activeColor: Colors.deepPurple,
                    onChanged: (val) {
                      setState(() {
                        _darkMode = val;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            val
                                ? 'Modo escuro ativado!'
                                : 'Modo escuro desativado!',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
