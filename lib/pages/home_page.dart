import 'package:flutter/material.dart';
import 'package:gerador_validador/defaults/defaults_export.dart';
import 'package:gerador_validador/pages/home_loading_page.dart';
import 'package:gerador_validador/service/admob_service.dart';

import 'app_drawer.dart';
import 'cpf/gerador_cpf_page.dart';
import 'cpf/validador_cpf_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
    AdMobService.startBanner();
    AdMobService.displayBanner();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            FocusScope.of(context).unfocus();
            break;
          case 1:
          default:
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom == 0
                ? AdMobService.bannerPadding(context)
                : 0),
        child: Scaffold(
          drawer: Drawer(
            child: AppDrawer(),
          ),
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  icon: Icon(Icons.library_add),
                  text: "Gerar",
                ),
                Tab(
                  icon: Icon(Icons.check),
                  text: "Validar",
                ),
              ],
            ),
            title: Text(Strings.appName),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              GeradorCPFPage(),
              ValidadorCPFPage(),
            ],
          ),
        ),
      ),
    );
  }
}
