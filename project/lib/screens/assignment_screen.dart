import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import '../providers/employee_provider.dart';
import '../services/csv_service.dart';

class ChristmasTheme {
  static const Color primary = Color(0xFFD42426); 
  static const Color secondary = Color(0xFF0F8A5F); 
  static const Color background = Color(0xFFF7F0EB); 
  static const Color surface = Colors.white;
  static const Color gold = Color(0xFFFFD700);
  static const Color darkGreen = Color(0xFF0A5F38);
}

class AssignmentScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends ConsumerState<AssignmentScreen> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    

    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    
  
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
   
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );
    
 
    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController.forward();
      
     
      Future.delayed(const Duration(milliseconds: 700), () {
        _confettiController.play();
        
       
        Future.delayed(const Duration(milliseconds: 400), () {
          setState(() {
            _showContent = true;
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assignments = ref.watch(secretSantaPairsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Secret Santa Assignments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ChristmasTheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      backgroundColor: ChristmasTheme.background,
      body: Stack(
        children: [
      
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/snowflake_bg.png'),
                fit: BoxFit.cover, 
              ),
              color: Colors.white.withOpacity(0.6), 
            ),
          ),
          
          
          AnimatedOpacity(
            opacity: _showContent ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: ListView.builder(
                    itemCount: assignments.entries.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final entry = assignments.entries.elementAt(index);
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: ChristmasTheme.primary.withOpacity(0.3), width: 1),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          leading: Container(
                            decoration: BoxDecoration(
                              color: ChristmasTheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Text(
                              "🎁",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  entry.key.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ChristmasTheme.darkGreen,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: ChristmasTheme.primary,
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  entry.value.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ChristmasTheme.primary,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    entry.key.email,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                Expanded(
                                  child: Text(
                                    entry.value.email,
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
        
          !_showContent ? Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ChristmasTheme.primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]
                    ),
                    child: Stack(
                      children: [
                     
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: ChristmasTheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                  
                        Center(
                          child: Container(
                            width: 20,
                            height: 100,
                            color: ChristmasTheme.gold,
                          ),
                        ),
                  
                        Center(
                          child: Container(
                            width: 100,
                            height: 20,
                            color: ChristmasTheme.gold,
                          ),
                        ),
                       
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: ChristmasTheme.gold,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ) : const SizedBox.shrink(),
          
     
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 30,
              minBlastForce: 15,
              emissionFrequency: 0.03,
              numberOfParticles: 30,
              gravity: 0.3,
              particleDrag: 0.05, 
              colors: const [
                ChristmasTheme.primary,
                ChristmasTheme.secondary,
                ChristmasTheme.gold,
                Colors.white,
                Colors.blue,
              ],
              maximumSize: const Size(12, 12),
              minimumSize: const Size(5, 5),
              createParticlePath: (size) {
                
                final path = Path();
            
                if (Random().nextInt(3) == 0) {
                
                  path.addOval(Rect.fromCircle(center: Offset.zero, radius: size.width / 2));
                } else if (Random().nextInt(2) == 0) {
               
                  path.addPolygon(_createStar(size.width, 5), true);
                } else {
             
                  path.addRect(Rect.fromLTWH(-size.width / 2, -size.height / 2, size.width, size.height));
                }
                return path;
              },
            ),
          ),
          
    
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 0, 
              maxBlastForce: 25,
              minBlastForce: 15,
              emissionFrequency: 0.025,
              numberOfParticles: 25,
              gravity: 0.3,
              shouldLoop: false,
              colors: const [
                ChristmasTheme.primary,
                ChristmasTheme.secondary,
                ChristmasTheme.gold,
                Colors.white,
                Colors.blue,
              ],
            ),
          ),
  
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi, 
              maxBlastForce: 25,
              minBlastForce: 15,
              emissionFrequency: 0.025,
              numberOfParticles: 25,
              gravity: 0.3,
              shouldLoop: false,
              colors: const [
                ChristmasTheme.primary,
                ChristmasTheme.secondary,
                ChristmasTheme.gold,
                Colors.white,
                Colors.blue,
              ],
            ),
          ),
          
         
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -pi / 2, 
              maxBlastForce: 30,
              minBlastForce: 20,
              emissionFrequency: 0.025,
              numberOfParticles: 20,
              gravity: 0.3,
              shouldLoop: false,
              colors: const [
                ChristmasTheme.primary,
                ChristmasTheme.secondary,
                ChristmasTheme.gold,
                Colors.white,
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ChristmasTheme.gold, Color(0xFFE6C200)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ChristmasTheme.gold.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.download,
            color: Colors.white,
          ),
          onPressed: () async {
            try {
              await CsvService.writeAssignmentsCsv("secret_santa_output.csv", assignments);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Secret Santa assignments saved successfully!"),
                    ],
                  ),
                  backgroundColor: ChristmasTheme.secondary,
                  duration: Duration(seconds: 3),
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error saving assignments: ${e.toString()}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }


  List<Offset> _createStar(double size, int points) {
    final List<Offset> offsets = [];
    final double angle = (2 * pi) / points;
    final double radius = size / 2;
    final double halfRadius = radius / 2;

    for (int i = 0; i < points * 2; i++) {
      final double currentRadius = i.isEven ? radius : halfRadius;
      final double currentAngle = i * angle / 2;
      offsets.add(Offset(
        currentRadius * cos(currentAngle),
        currentRadius * sin(currentAngle),
      ));
    }

    return offsets;
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChristmasTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.card_giftcard, color: ChristmasTheme.primary),
              SizedBox(width: 8),
              Text(
                "Secret Santa Assignments",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ChristmasTheme.darkGreen,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.card_giftcard, color: ChristmasTheme.primary),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Here's who's giving gifts to whom! 🎄",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard("Gift Givers", "From"),
              _buildStatCard("Gift Recipients", "To"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String direction) {
    return Expanded(
      child: Card(
        elevation: 2,
        color: ChristmasTheme.primary.withOpacity(0.1),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ChristmasTheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  direction == "From"
                      ? const Icon(Icons.arrow_forward, color: ChristmasTheme.darkGreen, size: 16)
                      : const Icon(Icons.arrow_back, color: ChristmasTheme.darkGreen, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    direction,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ChristmasTheme.darkGreen,
                    ),
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