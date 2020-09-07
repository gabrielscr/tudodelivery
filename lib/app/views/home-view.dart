import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tudodelivery/app/widgets/text-widget.dart';

import 'pedidos-view.dart';
import 'perfil-view.dart';

class HomeView extends StatelessWidget {
  final PageController controller = PageController(
    initialPage: 0,
  );

  final GlobalKey<ScaffoldState> menuKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          appBar: renderAppBar(),
          body: renderBody(),
          drawer: renderMenu(),
        );
      },
    );
  }

  Widget renderAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(
        children: [
          TextWidget(
            text: 'Tudo Delivery',
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.orange[300],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Busque por item ou loja',
                  hintStyle: GoogleFonts.muli(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.muli(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      leading: IconButton(
          icon: Icon(Icons.restaurant_menu, color: Colors.white),
          onPressed: () {}),
      actions: [
        FlatButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.new_releases_rounded, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                TextWidget(
                    text: 'Promoções', fontSize: 17, color: Colors.white),
              ],
            )),
        FlatButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Ionicons.ios_log_in, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                TextWidget(text: 'Entrar', fontSize: 17, color: Colors.white),
              ],
            )),
        FlatButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Ionicons.ios_cart, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                TextWidget(
                  text: 'Carrinho',
                  color: Colors.white,
                  fontSize: 17,
                ),
              ],
            ))
      ],
    );
  }

  Widget renderBody() {
    return Container(
      child: PageView(
        controller: controller,
        children: [PedidosView(), PerfilView()],
      ),
    );
  }

  renderMenu() {
    return Drawer();
  }
}
