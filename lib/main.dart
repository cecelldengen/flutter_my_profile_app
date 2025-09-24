import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chaelse Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C3AED)),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Profile — Chaelse Vania'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String fullName = 'Chaelse Vania Patulak Dengen';
  static const String nim = '2309106003';
  static const String hobby = 'Bermain musik';
  static const String instagramHandle = '@cecelldengen';
  static const String githubHandle = 'cecelldengen';

  final Uri _igUrl = Uri.parse('https://instagram.com/cecelldengen');
  final Uri _ghUrl = Uri.parse('https://github.com/cecelldengen');

  Future<void> _openUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal membuka: $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // AppBar tetap dari template, tapi disesuaikan warna/teks
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      // Body diganti menjadi layout profil
      body: Stack(
        children: [
          // Header gradient
          Container(
            height: 260,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)],
              ),
            ),
          ),

          // Konten
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _HeaderCard(name: fullName),
                  const SizedBox(height: 16),
                  const _GlassCard(
                    child: Column(
                      children: [
                        _InfoRow(label: 'Nama', value: fullName),
                        Divider(height: 24, thickness: .6),
                        _InfoRow(label: 'NIM', value: nim),
                        Divider(height: 24, thickness: .6),
                        _InfoRow(label: 'Hobi', value: hobby),
                        Divider(height: 24, thickness: .6),
                        _InfoRow(label: 'Instagram', value: instagramHandle),
                        Divider(height: 24, thickness: .6),
                        _InfoRow(label: 'GitHub', value: githubHandle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tentang',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Hai Gais ini project pertama aku, agak susah ya buatnya sampe minta bantuan gpt banyak banget gara gara banyak yang ga di pahami. '
                          'Maaf ya kalau kurang bagus.',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            _SocialButton(
                              icon: FontAwesomeIcons.instagram,
                              label: 'Instagram',
                              onTap: () => _openUrl(_igUrl),
                            ),
                            _SocialButton(
                              icon: FontAwesomeIcons.github,
                              label: 'GitHub',
                              onTap: () => _openUrl(_ghUrl),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '© ${DateTime.now().year} $fullName',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // FAB dari template dimanfaatkan untuk aksi cepat: buka Instagram
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openUrl(_igUrl),
        icon: const Icon(FontAwesomeIcons.instagram, size: 18),
        label: const Text('Follow Instagram'),
      ),
    );
  }
}

// ===================== Widget pendukung =====================

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 8),
        Center(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(.2),
                  theme.colorScheme.tertiary.withOpacity(.2),
                ],
              ),
            ),
            child: const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/images/stitch.jpg'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Profile App',
          style: theme.textTheme.labelLarge?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: theme.colorScheme.surface.withOpacity(.6),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withOpacity(.4),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(flex: 3, child: Text(value, style: theme.textTheme.bodyLarge)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: theme.colorScheme.primaryContainer.withOpacity(.85),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
