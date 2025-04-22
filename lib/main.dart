import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // এটা CLI দিয়ে জেনারেট হবে নিচে দেখাই

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
