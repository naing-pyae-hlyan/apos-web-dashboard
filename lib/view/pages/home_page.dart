import 'package:apos/lib_exp.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  late AuthBloc authBloc;

  void _onItemTapped(SelectedHome selected) {
    if (homeBloc.selectedHomeItems == selected) return;
    homeBloc.add(HomeEventDrawerChanged(selectedPage: selected));
  }

  bool _isSelected(SelectedHome selected) {
    return selected == homeBloc.selectedHomeItems;
  }

  void _logout() {
    authBloc.add(AuthEventLogout());
  }

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    authBloc = context.read<AuthBloc>();
    super.initState();
    doAfterBuild(callback: () {
      homeBloc.add(HomeEventDrawerChanged(
        selectedPage: SelectedHome.dashboard,
      ));
      FFirestoreUtils.listenNewOrder(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Consts.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Consts.scaffoldBackgroundColor,
        surfaceTintColor: Consts.scaffoldBackgroundColor,
        centerTitle: false,
        title: BlocBuilder<HomeBloc, HomeState>(
          builder: (_, state) => switch (state.selectedPage) {
            SelectedHome.dashboard => myTitle(SelectedHome.dashboard.title),
            SelectedHome.category => myTitle(SelectedHome.category.title),
            SelectedHome.product => myTitle(SelectedHome.product.title),
            SelectedHome.order => myTitle(SelectedHome.order.title),
            SelectedHome.customer => myTitle(SelectedHome.customer.title),
            SelectedHome.user => myTitle(SelectedHome.user.title),
          },
        ),
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          },
        ),
        // actions: const [],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (_, state) {
          return switch (state.selectedPage) {
            SelectedHome.dashboard => const DashboardPage(),
            SelectedHome.category => const CategoryPage(),
            SelectedHome.product => const ProductPage(),
            SelectedHome.order => const OrdersPage(),
            SelectedHome.customer => const CustomerPage(),
            SelectedHome.user => const UsersPage(),
          };
        },
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Consts.primaryColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: 64,
                          color: Colors.white,
                        ),
                        verticalHeight8,
                        myText(
                          CacheManager.currentUser?.username,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        myText(
                          CacheManager.currentUser?.email,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: myText("Dashboard"),
                    selected: _isSelected(SelectedHome.dashboard),
                    onTap: () {
                      // Update the state of the app
                      _onItemTapped(SelectedHome.dashboard);
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
                      childrenPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      title: ListTile(
                        leading: const Icon(Icons.category),
                        title: myText("Product Manage"),
                      ),
                      children: [
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: myText("Categories"),
                          selected: _isSelected(SelectedHome.category),
                          onTap: () {
                            // Update the state of the app
                            _onItemTapped(SelectedHome.category);
                            // Then close the drawer
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: myText("Products"),
                          selected: _isSelected(SelectedHome.product),
                          onTap: () {
                            // Update the state of the app
                            _onItemTapped(SelectedHome.product);
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
                    selected: _isSelected(SelectedHome.order),
                    onTap: () {
                      // Update the state of the app
                      _onItemTapped(SelectedHome.order);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.groups_2_outlined),
                    title: myText("Customers"),
                    selected: _isSelected(SelectedHome.customer),
                    onTap: () {
                      // Update the state of the app
                      _onItemTapped(SelectedHome.customer);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.manage_accounts),
                    title: myText("Users"),
                    selected: _isSelected(SelectedHome.user),
                    onTap: () {
                      // Update the state of the app
                      _onItemTapped(SelectedHome.user);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  // Then close the drawer
                  Navigator.pop(context);
                  // Logout
                  _logout();
                },
                label: myText('Logout', color: Consts.primaryColor),
                icon: const Icon(Icons.logout, color: Consts.primaryColor),
              ),
            ),
            const Divider(),
            CommonUtils.versionLabel(),
            myText("Copyright ©2024 aPOS, All rights reserved."),
            verticalHeight8,
          ],
        ),
      ),
    );
  }
}
