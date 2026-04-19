// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Permission.camera.request();
//   await Permission.microphone.request(); // if you need microphone permission
//   await Permission.phone.request(); // if you need microphone permission
//   await Permission.photos.request();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WebViewScreen(),
//     );
//   }
// }

// class WebViewScreen extends StatefulWidget {
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   InAppWebViewController? controller;
//   double progress = 0;
//   bool isOffline = true;

//   @override
//   void initState() {
//     // TODO: implement initState
//     // openChrome();
//     super.initState();
//   }

//   Future<void> openChrome() async {
//     try {
//       await custom_tabs.launchUrl(
//         Uri.parse('https://adbhutconstruction.com/A/registration'),
//         customTabsOptions: custom_tabs.CustomTabsOptions(
//           colorSchemes: custom_tabs.CustomTabsColorSchemes.defaults(
//             toolbarColor: Colors.red,
//           ),
//           showTitle: false,
//           urlBarHidingEnabled: true, // 🔥 hides on scrol
//         ),
//       );
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   void disableZoom(InAppWebViewController controller) async {
//     await controller.evaluateJavascript(
//       source: """
//     // Block pinch zoom
//       document.addEventListener('touchstart', function(e) {
//         if (e.touches.length > 1) {
//           e.preventDefault();
//         }
//       }, { passive: false });

//       // Block double tap zoom
//       let lastTouchEnd = 0;
//       document.addEventListener('touchend', function (e) {
//         let now = new Date().getTime();
//         if (now - lastTouchEnd <= 300) {
//           e.preventDefault();
//         }
//         lastTouchEnd = now;
//       }, false);

//       // Block gesture events (some devices)
//       ['gesturestart', 'gesturechange', 'gestureend'].forEach(function(event) {
//         document.addEventListener(event, function(e) {
//           e.preventDefault();
//         });
//       });
//     """,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         var currentUrl = await controller!.getUrl();
//         if (controller != null && await controller!.canGoBack()) {
//           if (currentUrl.toString() ==
//               'https://adbhutconstruction.com/UserPanel/Dashboard') {
//             return true;
//           }
//           controller!.goBack();
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         // appBar: AppBar(title: const Text("")),
//         body: Padding(
//           padding: EdgeInsets.only(
//             top: MediaQuery.of(context).padding.top,
//             bottom: MediaQuery.of(context).padding.bottom,
//           ),
//           child: Column(
//             children: [
//               // 🔄 Loader
//               progress < 1.0
//                   ? LinearProgressIndicator(value: progress)
//                   : const SizedBox(),
//               isOffline
//                   ? Expanded(
//                       child: InAppWebView(
//                         initialUrlRequest: URLRequest(
//                           url: WebUri(
//                             "https://adbhutconstruction.com/A/registration",
//                           ),
//                         ),

//                         initialSettings: InAppWebViewSettings(
//                           javaScriptEnabled: true,
//                           useHybridComposition: true,
//                           supportZoom: false,
//                           builtInZoomControls: false,
//                           displayZoomControls: false,
//                           verticalScrollBarEnabled: false,
//                           horizontalScrollBarEnabled: false,
//                           allowFileAccess: true,
//                           allowContentAccess: true,
//                           mediaPlaybackRequiresUserGesture: false,
//                           useWideViewPort: false,
//                           loadWithOverviewMode: false,
//                           cacheEnabled: false,
//                           clearSessionCache: true,
//                         ),

//                         onWebViewCreated: (webController) {
//                           controller = webController;
//                         },

//                         androidOnPermissionRequest:
//                             (controller, origin, resources) async {
//                               return PermissionRequestResponse(
//                                 resources: resources,
//                                 action: PermissionRequestResponseAction.GRANT,
//                               );
//                             },

//                         // 🔄 Progress
//                         onProgressChanged: (ctrl, value) {
//                           setState(() {
//                             progress = value / 100;
//                           });
//                         },

//                         // 🔐 SSL BYPASS (your issue fix)
//                         onReceivedServerTrustAuthRequest:
//                             (controller, challenge) async {
//                               return ServerTrustAuthResponse(
//                                 action: ServerTrustAuthResponseAction.PROCEED,
//                               );
//                             },

//                         // ✅ Handle external apps (WhatsApp, Call, etc.)
//                         shouldOverrideUrlLoading:
//                             (controller, navigationAction) async {
//                               final uri = navigationAction.request.url;
//                               // print('object======' + uri.toString());
//                               if (uri != null) {
//                                 final url = uri.toString();
//                                 if (url.contains("wa.me") ||
//                                     url.contains("whatsapp") ||
//                                     url.startsWith("tel:") ||
//                                     url.startsWith("mailto:") ||
//                                     url.startsWith("intent://")) {
//                                   await launchUrl(
//                                     uri,
//                                     mode: LaunchMode.externalApplication,
//                                   );
//                                   return NavigationActionPolicy.CANCEL;
//                                 }
//                               }
//                               return NavigationActionPolicy.ALLOW;
//                             },

//                         onCreateWindow: (controller, request) async {
//                           final uri = request.request.url;
//                           disableZoom(controller);

//                           // print('objectsss=$uri');
//                           if (uri != null) {
//                             await launchUrl(
//                               uri,
//                               mode: LaunchMode.externalApplication,
//                             );
//                           }

//                           return false;
//                         },
//                         onLoadStart: (controller, url) async {
//                           disableZoom(controller);
//                         },
//                         onLoadStop: (controller, url) async {
//                           disableZoom(controller);
//                         },
//                         onLoadError: (controller, url, code, message) {
//                           disableZoom(controller);
//                           // print("Load Error: $message" + '=' + url.toString());
//                           if (message == 'net::ERR_CACHE_MISS') {
//                             // controller.loadUrl(
//                             //   urlRequest: URLRequest(url: WebUri("$url")),
//                             // );
//                             controller.goBack();
//                             return;
//                           }
//                           setState(() {
//                             isOffline = false;
//                           });
//                           // ❌ No internet / failed load
//                         },
//                       ),
//                     )
//                   : NoInternetWidget(
//                       onRetry: () {
//                         setState(() => isOffline = true);
//                         controller?.reload();
//                       },
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NoInternetWidget extends StatelessWidget {
//   final VoidCallback onRetry;

//   const NoInternetWidget({super.key, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.wifi_off, size: 80, color: Colors.grey),

//             SizedBox(height: 20),

//             Text(
//               "No internet connection or server error!",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),

//             SizedBox(height: 10),

//             Text(
//               "Please check your connection and try again.",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.grey),
//             ),

//             SizedBox(height: 30),

//             ElevatedButton(
//               onPressed: onRetry,
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//               ),
//               child: Text("Retry"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:adbhut/EnquiryForm.dart';
import 'package:adbhut/Utils/CommonFun.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;

      // Dummy check
      if (username == "admin" && password == "1234") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Enquiryform()),
          (route) => false,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login Successful")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // Username
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter username" : null,
                ),
                SizedBox(height: 15),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter password" : null,
                ),
                SizedBox(height: 20),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: login, child: Text("Login")),
                ),

                SizedBox(height: 100),

                InkWell(
                  onTap: () {
                    // Navigate to sign-up page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Create New Account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomUI(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;

      // Dummy check
      if (username.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Enter User Name")));
      } else if (password.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Enter Password")));
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // Username
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter username" : null,
                ),
                SizedBox(height: 15),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter password" : null,
                ),
                SizedBox(height: 20),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => login(context),
                    child: Text("Sign Up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomUI(),
    );
  }
}
