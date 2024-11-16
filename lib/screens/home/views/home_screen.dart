import 'package:budget_buddy/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:budget_buddy/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:budget_buddy/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:budget_buddy/screens/add_expense/views/add_expense.dart';
import 'package:budget_buddy/screens/home/views/main_screen.dart';
import 'package:budget_buddy/screens/stats/stats.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(45)),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: const Color.fromARGB(255, 1, 65, 117),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
              const TextStyle(color: Color.fromARGB(255, 1, 65, 117)),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          elevation: 3,
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(SFSymbols.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(SFSymbols.chart_bar_alt_fill),
              label: 'Insights',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        CreateCategoryBloc(FirebaseExpenseRepo()),
                  ),
                  BlocProvider(
                    create: (context) => GetCategoriesBloc(FirebaseExpenseRepo())..add(GetCategories()),
                  ),
                  BlocProvider(
                    create: (context) =>
                        CreateExpenseBloc(FirebaseExpenseRepo()),
                  ),
                ],
                child: const AddExpense(),
              ),
            ),
          );
        },
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary,
              ],
            ),
          ),
          child: const Icon(SFSymbols.plus),
        ),
      ),
      body: index == 0 ? const MainScreen() : const StatScreen(),
    );
  }
}
