import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool showNotices = true;
  List<Map<String, String>> qnaList = [];
  bool isNoticeSelected = true;
  final Dio dio = Dio();
  int currentPage = 1;
  final int pageSize = 10; // 한 페이지에 표시할 QnA 개수

  @override
  void initState() {
    super.initState();
    fetchQnAList();
  }

  void fetchQnAList() async {
    try {
      final response = await dio.get("http://192.168.0.177:9090/board/read?pno=$currentPage");
      setState(() {
        qnaList = List<Map<String, String>>.from(response.data);
      });
    } catch (e) {
      print(e);
    }
  }

  void addQnA(Map<String, String> qna) async {
    try {
      await dio.post("http://192.168.0.177:9090/board/insert", data: qna);
      fetchQnAList(); // Add QnA 후 리스트를 다시 불러옵니다
    } catch (e) {
      print(e);
    }
  }

  void updateQnA(int index, Map<String, String> qna) {
    setState(() {
      qnaList[index] = qna;
    });
  }

  void deleteQnA(int index) {
    setState(() {
      qnaList.removeAt(index);
    });
  }

  void toggleView(bool showNotices) {
    setState(() {
      this.showNotices = showNotices;
      isNoticeSelected = showNotices;
    });
  }

  void changePage(int page) {
    setState(() {
      currentPage = page;
      fetchQnAList(); // 페이지 변경 후 리스트를 다시 불러옵니다
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Conven",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomService(
              toggleView: toggleView,
              isNoticeSelected: isNoticeSelected,
            ),
            Container(
              width: 400,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [],
              ),
            ),
            Container(
              width: double.infinity,
              height: 10,
              color: Color(0xFFE5E5E1),
            ),
            showNotices
                ? Column(
              children: [
                // 공지사항 관련 위젯
              ],
            )
                : QnASection(
              qnaList: qnaList,
              addQnA: addQnA,
              updateQnA: updateQnA,
              deleteQnA: deleteQnA,
              currentPage: currentPage,
              changePage: changePage,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomService extends StatelessWidget {
  final Function(bool) toggleView;
  final bool isNoticeSelected;

  CustomService({required this.toggleView, required this.isNoticeSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => toggleView(true),
            child: Column(
              children: [
                Image.asset("assets/images/speakerimage.png"),
                Text(
                  "공지사항",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150, 150),
              backgroundColor:
              isNoticeSelected ? Colors.grey : Color(0xFFE5E5E1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
          ElevatedButton(
            onPressed: () => toggleView(false),
            child: Column(
              children: [
                Image.asset("assets/images/noteimage.png"),
                Text(
                  "고객센터",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150, 150),
              backgroundColor:
              isNoticeSelected ? Color(0xFFE5E5E1) : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QnASection extends StatelessWidget {
  final List<Map<String, String>> qnaList;
  final Function(Map<String, String>) addQnA;
  final Function(int, Map<String, String>) updateQnA;
  final Function(int) deleteQnA;
  final int currentPage;
  final Function(int) changePage;

  QnASection({
    required this.qnaList,
    required this.addQnA,
    required this.updateQnA,
    required this.deleteQnA,
    required this.currentPage,
    required this.changePage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < qnaList.length; i++)
          ExpansionTile(
            title: Text(qnaList[i]['title'] ?? ""),
            children: [
              ListTile(
                title: Text(qnaList[i]['content'] ?? ""),
                subtitle: Text("작성자: ${qnaList[i]['author'] ?? ""}"),
              ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
                (index) => IconButton(
              icon: Icon(Icons.circle, size: 10),
              onPressed: () => changePage(index + 1),
              color: currentPage == index + 1 ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddQnAPage(addQnA: addQnA),
              ),
            );
          },
          child: Text(
            "글쓰기",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class AddQnAPage extends StatefulWidget {
  final Function(Map<String, String>) addQnA;

  AddQnAPage({required this.addQnA});

  @override
  _AddQnAPageState createState() => _AddQnAPageState();
}

class _AddQnAPageState extends State<AddQnAPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submit() {
    if (_titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        _contentController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("오류"),
          content: Text("작성자, 제목, 내용을 모두 입력하세요."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("확인"),
            ),
          ],
        ),
      );
      return;
    }

    final qna = {
      'title': _titleController.text,
      'author': _authorController.text,
      'content': _contentController.text,
    };
    widget.addQnA(qna);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("글 등록"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "제목"),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: "작성자"),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: "내용"),
              maxLines: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text("글 등록"),
            ),
          ],
        ),
      ),
    );
  }
}
