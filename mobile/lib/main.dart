import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charlie & Brown',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String serverMessage = "Esperando conexión...";
  bool isLoading = false;

  Future<void> testConnection() async {
    setState(() {
      isLoading = true;
      serverMessage = "Conectando con el cerebro...";
    });

    try {
      // ⚠️ CLAVE: Usamos localhost porque estamos en Web
      final response = await http.get(Uri.parse('http://localhost:8000/'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          serverMessage = "✅ ÉXITO: ${data['message']}";
        });
      } else {
        setState(() {
          serverMessage = "⚠️ Error del servidor: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        serverMessage = "❌ Error de conexión: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Charlie & Brown Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF39C12),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
    
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.pets, size: 80, color: Color(0xFF2C3E50)),
              const SizedBox(height: 20),
              const Text(
                'Panel de Control CPO',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    const Text("Estado del Backend:", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                      serverMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: serverMessage.contains("✅") ? Colors.green : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: isLoading ? null : testConnection,
                icon: isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
                  : const Icon(Icons.wifi_tethering),
                label: Text(isLoading ? "Conectando..." : "PROBAR CONEXIÓN CON PYTHON"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}