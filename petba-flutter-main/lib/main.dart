import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petba/constants.dart';
import 'package:petba/providers/adoption/adoptfirst.dart';
import 'package:petba/providers/cart/CartPaymentProvider.dart';
import 'package:petba/providers/cart/CartProvider.dart';
import 'package:petba/providers/cart/CartAddressNewProvider.dart';
import 'package:petba/providers/ecommerce/EcommerceProvider.dart';
import 'package:petba/providers/grooming/GroomingSearchProvider.dart';
import 'package:petba/providers/order/OrderListProvider.dart';
import 'package:petba/providers/veterinarian/VetSearchProvider.dart';
import 'package:petba/screens/adoption/adoption_add_screen.dart';
import 'package:petba/screens/adoption/adoption_screen.dart';
import 'package:petba/screens/adoption/adoption_search_screen.dart';
import 'package:petba/screens/cart/cart_address.dart';
import 'package:petba/screens/cart/cart_list.dart';
import 'package:petba/screens/cart/cart_address_new.dart';
import 'package:petba/screens/cart/cart_order_success_screen.dart';
import 'package:petba/screens/cart/cart_payment.dart';
import 'package:petba/screens/ecommerce/ecommerce_screen.dart';
import 'package:petba/screens/order/order_list_screen.dart';
import 'package:petba/screens/order/placed_order_details_screen.dart';
import 'package:petba/screens/user/login_screen.dart';
import 'package:petba/screens/user/signup_screen.dart';
import 'package:petba/screens/user/otp_screen.dart';
import 'package:petba/screens/dashboard_screen.dart';
import 'package:petba/screens/user/onboard_screen.dart';
import 'package:petba/screens/ecommerce/ecommerce_search_screen.dart';
import 'package:petba/screens/veterinarian/vet_search_screen.dart';
import 'package:petba/screens/ecommerce/filter_screen.dart';
import 'package:petba/screens/grooming/grooming_search_screen.dart';
import 'package:petba/screens/user/user_details.dart';
//import 'package:petba/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:petba/providers/LogProvider.dart';
import 'package:petba/providers/adoption/AdoptionSearchProvider.dart';
import 'package:petba/providers/adoption/AdoptionProvider.dart';
import 'package:petba/providers/DashboardProvider.dart';
import 'package:petba/providers/user/LoginProvider.dart';
import 'package:petba/providers/user/RegistrationProvider.dart';
import 'package:petba/providers/ecommerce/EcommerceSearchProvider.dart';
import 'package:petba/providers/ecommerce/FilterProvider.dart';
import 'package:petba/providers/user/UserDetailsProvider.dart';

void main() {
  runApp(Petba());
}

class Petba extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<LogProvider>.value(value: LogProvider()),
        ChangeNotifierProvider<LoginProvider>.value(value: LoginProvider()),
        ChangeNotifierProvider<RegistrationProvider>.value(value: RegistrationProvider()),
        ChangeNotifierProvider<AdoptionSearchProvider>.value(value: AdoptionSearchProvider()),
        ChangeNotifierProvider<AdoptionProvider>.value(value: AdoptionProvider()),
        ChangeNotifierProvider<DashboardProvider>.value(value: DashboardProvider()),
        ChangeNotifierProvider<EcommerceSearchProvider>.value(value: EcommerceSearchProvider()),
        ChangeNotifierProvider<FilterProvider>.value(value: FilterProvider()),
        ChangeNotifierProvider<EcommerceProvider>.value(value: EcommerceProvider()),
        ChangeNotifierProvider<CartListProvider>.value(value: CartListProvider()),
        ChangeNotifierProvider<CartAddressNewProvider>.value(value: CartAddressNewProvider()),
        ChangeNotifierProvider<VetSearchProvider>.value(value: VetSearchProvider()),
        ChangeNotifierProvider<UserDetailsProvider>.value(value: UserDetailsProvider()),
        ChangeNotifierProvider<CartPaymentProvider>.value(value: CartPaymentProvider()),
        ChangeNotifierProvider<OrderListProvider>.value(value: OrderListProvider()),
        ChangeNotifierProvider<GroomingSearchProvider>.value(value: GroomingSearchProvider()),
      ],
      child: MaterialApp(
        routes: {
          adapt.id: (context) => adapt(),
          //

          LoginPage.id: (context) => LoginPage(),
          SignUpPage.id: (context) => SignUpPage(),
          OtpPage.id: (context) => OtpPage(),
          Onboard.id: (context) => Onboard(),
          HomePage.id: (context) => HomePage(),
          AdoptionPage.id: (context) => AdoptionPage(),
          AdoptionSearchPage.id: (context) => AdoptionSearchPage(),
          AdoptionUploadScreen.id: (context) => AdoptionUploadScreen(),
          EcommerceSearch.id: (context) => EcommerceSearch(),
          CartList.id: (context) => CartList(),
          CartAddress.id: (context) => CartAddress(),
          CartAddressNew.id: (context) => CartAddressNew(),
          CartPayment.id: (context) => CartPayment(),
          VetSearchPage.id: (context) => VetSearchPage(),
          FilterPage.id: (context) => FilterPage(),
          GroomingSearchPage.id: (context) => GroomingSearchPage(),
          EcommerceScreen.id: (context) => EcommerceScreen(),
          UserDetails.id: (context) => UserDetails(),
          PlacedOrderDetails.id: (context) => PlacedOrderDetails(),
          OrderList.id: (context) => OrderList(),
          CartOrderSuccessScreen.id: (context) => CartOrderSuccessScreen(),
        },
        initialRoute: HomePage.id,
        theme: ThemeData(
          //fontFamily: kFont,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: kThemeColour,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kThemeColour),
            bodyText2: TextStyle(color: kThemeColour),
          ),
        ),
      ),
    );
  }
}


//9617234371