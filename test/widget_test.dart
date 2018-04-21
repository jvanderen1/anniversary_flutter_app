/// Flutter Packages
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Personal Packages
import 'package:anniversary/app.dart';

void main() {
  testWidgets('Time is accurately represented', (WidgetTester tester) async {

    // Sets initial [SharedPreferences] for use.
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Testing with anniversary of [now]
    DateTime testingDateTime = DateTime.now();
    prefs.setString('anniversaryDate', testingDateTime.toString());

    await tester.pumpWidget(new AnniversaryApp(title: 'Testing', prefs: prefs));

    // Should not find any #'s in any widgets.
    expect(find.text('#'), findsNothing);

    // TODO: Write Tests where Anniversary Date after DateTime.now()
  });
}
