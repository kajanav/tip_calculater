import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController billController = TextEditingController();

List<bool> _selected = [true, false, false, false, false];

double billAmount = 0.0;
double totalBillAmount = 0.0;
int tipIndex = 0;
double tipPercent = 0.0;
double tipAmount = 0.0; 

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFD),
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).primaryColor, // Ensure it follows the theme
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 30, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          'Tippy',
          style: GoogleFonts.lobster(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView (
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
          child: Column(
            children: [
              Text(
                'Enter bill amount',
                style: GoogleFonts.roboto(color: Color(0xFF9EA1A1), fontSize: 25),
              ),
              SizedBox(height: 15),
              Container(
                width: 200,
                child: TextFormField(
                  controller: billController,
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '\$100.0',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                   
                    ),
                  ),
                ),
              ),
          
              SizedBox(height: 15),
              Text(
                'Choose tip',
                style: GoogleFonts.roboto(fontSize: 25, color: Color(0xFF9EA1A1)),
              ),
              SizedBox(height: 15),
              Container(
                child: ToggleButtons(
                  isSelected: _selected,
                  fillColor: Color(0xFFE91E63),
                  selectedColor: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  children: [
                    Padding(padding: const EdgeInsets.all(8.0), child: Text('10%')),
                    Padding(padding: const EdgeInsets.all(8.0), child: Text('15%')),
                    Padding(padding: const EdgeInsets.all(8.0), child: Text('20%')),
                    Padding(padding: const EdgeInsets.all(8.0), child: Text('25%')),
                    Padding(padding: const EdgeInsets.all(8.0), child: Text('30%')),
                  ],
                  onPressed: (int selectedIndex) {
                    for (int index = 0; index < _selected.length; index++) {
                      setState(() {
                        _selected[index] = selectedIndex == index;
                      });
                    }
                  },
                ),
              ),
          
              SizedBox(height: 50),
              Container(
                height: 70,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE91E63),
                  ),
          
                  child: Text(
                    'CALCULATE',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    billAmount = double.parse(billController.text.trim()); 
                    tipIndex = _selected.indexWhere((element)=> element);
                    tipPercent = [0.1,0.15,0.2,0.25,0.3][tipIndex];

                    setState(() {
                      tipAmount = double.parse((billAmount * tipPercent).toStringAsFixed(2));
                    totalBillAmount = double.parse((billAmount +tipAmount).toStringAsFixed(2));
                    });
                  },
                ), 
              ),
          
              SizedBox(height: 50),
              Text(
                'Total Bill Amount',
                style: GoogleFonts.roboto(color: Color(0xFF9EA1A1), fontSize: 25),
              ),
              Text(
                '\$$totalBillAmount',
                style: GoogleFonts.roboto(
                  color: Color(0xFFE91E63),
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                ),
              ),
          
              SizedBox(height: 20),
              Text(
                'Tip Amount',
                style: GoogleFonts.roboto(
                  color: Color(0xFF9EA1A1),
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                '\$$tipAmount',
                style: GoogleFonts.roboto(
                  color: Color(0xFFE91E63),
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    ); 
  }
}
