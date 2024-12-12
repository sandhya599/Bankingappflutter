import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Banking',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF800000), // Maroon color
        ),
      ),
      home: SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomeScreen();
  }

  _navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 150,  // Set the width for the image
          height: 150, // Set the height for the image
          child: Image.asset(
            'assets/image.png',  // The splash image
            fit: BoxFit.contain, // Ensure the image fits within the container
          ),
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text("CIBC Bank")),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bank.jpg', // The path to your image file
              width: 350, // Set the width of the image
              height: 250, // Set the height of the image
              fit: BoxFit.contain, // Adjust the image to fit within the specified size
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome to CIBC Bank",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Today's Date: $todayDate", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String correctUsername = 'sandhya59';
  final String correctPassword = '123456';

  void _login() {
    if (_usernameController.text == correctUsername && _passwordController.text == correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AccountListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid username or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// App Drawer (Hamburger Menu)
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 159, 12, 12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'CIBC Bank',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Account List Screen
class AccountListScreen extends StatelessWidget {
  final String chequingData = '''
  {
    "accountNumber": "001234567890",
    "balance": 1250.75,
    "currency": "USD"
  }
  ''';

  final String savingsData = '''
  {
    "accountNumber": "009876543210",
    "balance": 4890.5,
    "currency": "USD"
  }
  ''';

  final List chequingTransactions = [
    {"date": "2024-08-01", "description": "Grocery Store", "amount": -45.67},
    {"date": "2024-08-02", "description": "Salary", "amount": 1500},
    {"date": "2024-08-03", "description": "Coffee Shop", "amount": -3.25},
    {"date": "2024-08-04", "description": "Electricity Bill", "amount": -120},
    {"date": "2024-08-05", "description": "Transfer to Savings", "amount": -300},
    {"date": "2024-08-06", "description": "Restaurant", "amount": -75.5},
    {"date": "2024-08-07", "description": "Gas Station", "amount": -40},
    {"date": "2024-08-08", "description": "Internet Bill", "amount": -60},
    {"date": "2024-08-09", "description": "Movie Tickets", "amount": -25},
    {"date": "2024-08-10", "description": "Gym Membership", "amount": -50}
  ];

  final List savingsTransactions = [
    {"date": "2024-08-01", "description": "Interest Earned", "amount": 5.25},
    {"date": "2024-08-02", "description": "Transfer from Chequing", "amount": 300},
    {"date": "2024-08-03", "description": "Deposit", "amount": 100},
    {"date": "2024-08-04", "description": "Transfer from Chequing", "amount": 200},
    {"date": "2024-08-05", "description": "Interest Earned", "amount": 4.75},
    {"date": "2024-08-06", "description": "Deposit", "amount": 150},
    {"date": "2024-08-07", "description": "Transfer from Chequing", "amount": 250},
    {"date": "2024-08-08", "description": "Interest Earned", "amount": 3.5},
    {"date": "2024-08-09", "description": "Deposit", "amount": 200},
    {"date": "2024-08-10", "description": "Transfer from Chequing", "amount": 400}
  ];

  @override
  Widget build(BuildContext context) {
    final chequing = jsonDecode(chequingData);
    final savings = jsonDecode(savingsData);

    return Scaffold(
      appBar: AppBar(title: const Text("Accounts")),
      drawer: AppDrawer(),
      body: Row(
        children: [
          // Left side: Account List
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                AccountCard(account: chequing, transactions: chequingTransactions),
                AccountCard(account: savings, transactions: savingsTransactions),
              ],
            ),
          ),
          // Right side: Transaction History
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Transaction History",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: chequingTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = chequingTransactions[index];
                        return ListTile(
                          title: Text(transaction["description"]),
                          subtitle: Text(transaction["date"]),
                          trailing: Text(
                            '\$${transaction["amount"].toStringAsFixed(2)}',
                            style: TextStyle(
                              color: transaction["amount"] < 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Account Card
class AccountCard extends StatelessWidget {
  final Map account;
  final List transactions;

  AccountCard({required this.account, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      child: ListTile(
        title: Text('Account: ${account["accountNumber"]}'),
        subtitle: Text('Balance: \$${account["balance"].toStringAsFixed(2)} ${account["currency"]}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionHistoryScreen(transactions: transactions),
            ),
          );
        },
      ),
    );
  }
}

// Transaction History Screen
class TransactionHistoryScreen extends StatelessWidget {
  final List transactions;

  TransactionHistoryScreen({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transaction History")),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text(transaction["description"]),
            subtitle: Text(transaction["date"]),
            trailing: Text(
              '\$${transaction["amount"].toStringAsFixed(2)}',
              style: TextStyle(
                color: transaction["amount"] < 0 ? Colors.red : Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}