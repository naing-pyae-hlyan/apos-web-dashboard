import 'package:apos/lib_exp.dart';
import 'package:apos/view/pages/products/category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final int _indexDashboard = 0;
  final int _indexCategory = 1;
  final int _indexProduct = 2;
  final int _indexOrder = 3;
  final int _indexCustomer = 4;

  final pages = const [
    DashboardPage(),
    CategoryPage(),
    ProductPage(),
    OrdersPage(),
    CustomerPage(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Consts.secondaryColor2,
      appBar: AppBar(
        backgroundColor: Consts.secondaryColor2,
        surfaceTintColor: Consts.secondaryColor2,
        leading: Builder(builder: (ctx) {
          return IconButton(
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            },
            icon: const Icon(Icons.menu),
          );
        }),
      ),
      body: Center(child: pages[_selectedIndex]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Consts.primaryColor,
              ),
              child: myText(
                "Header",
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: myText("Dashboard"),
              selected: _selectedIndex == _indexDashboard,
              onTap: () {
                // Update the state of the app
                _onItemTapped(_indexDashboard);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.only(right: 16),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: ListTile(
                  leading: const Icon(Icons.category),
                  title: myText("Product Manage"),
                ),
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: myText("Categories"),
                    selected: _selectedIndex == _indexCategory,
                    onTap: () {
                      // Update the state of the app
                      _onItemTapped(_indexCategory);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: myText("Products"),
                    selected: _selectedIndex == _indexProduct,
                    onTap: () {
                      // Update the state of the app
                      _onItemTapped(_indexProduct);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: myText("Orders"),
              selected: _selectedIndex == _indexOrder,
              onTap: () {
                // Update the state of the app
                _onItemTapped(_indexOrder);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: myText("Customers"),
              selected: _selectedIndex == _indexCustomer,
              onTap: () {
                // Update the state of the app
                _onItemTapped(_indexCustomer);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
