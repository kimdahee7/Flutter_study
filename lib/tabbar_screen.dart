import 'package:flutter/material.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car, color: Colors.blue)),
              Tab(icon: Icon(Icons.directions_transit, color: Colors.blue)),
              Tab(icon: Icon(Icons.directions_bike, color: Colors.blue)),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: const TabBarView(
          children: [
            MyCustomForm(),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  //버튼 클릭 시 텍스트 필드 포커스
  //1.FocusNode 생성
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //Field 'myFocusNode' has not been initialized 오류 해결하기 위해 위에 선언해줌
    //myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    //Clean up the focus node when the Form is disposed
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(labelText: 'Enter your username'),
            //텍스트 필드가 표시되는 즉시 포커스 설정
            autofocus: true,
          ),
          TextField(
            //2.FocusNode 텍스트 필드로 넘기기
            focusNode: myFocusNode,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')));
                }
              },
              child: const Text('Submit'),
            ),
          ),
          FloatingActionButton(
            onPressed: () => FocusScope.of(context).requestFocus(myFocusNode),
            tooltip: 'Focus Text Field',
            child: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
