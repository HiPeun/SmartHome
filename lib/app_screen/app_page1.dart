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

  @override
  void initState() {
    super.initState();
    fetchQnAList();
  }

  void fetchQnAList() async {
    try {
      final response = await dio.get('http://your_flask_server_ip:5000/qna');
      setState(() {
        qnaList = List<Map<String, String>>.from(response.data);
      });
    } catch (e) {
      print(e);
    }
  }


  void addQnA(Map<String, String> qna) async {
    try {
      await dio.post('http://your_flask_server_ip:5000/qna/add', data: qna);
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
                children: [
                ],
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
//원래 ServiceTile이 있던 자리 이제는 DB에 내용을 저장해서 꺼내는 식으로 함
              ],
            )
                : QnASection(
              qnaList: qnaList,
              addQnA: addQnA,
              updateQnA: updateQnA,
              deleteQnA: deleteQnA,
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
                Image.asset("assets/images/noteimage.png"),
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
              backgroundColor: isNoticeSelected ? Colors.grey : Color(0xFFE5E5E1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
          ElevatedButton(
            onPressed: () => toggleView(false),
            child: Column(
              children: [
                Image.asset("assets/images/speakerimage.png"),
                Text(
                  "Q&A",
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
              backgroundColor: isNoticeSelected ? Color(0xFFE5E5E1) : Colors.grey,
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

  QnASection({required this.qnaList, required this.addQnA, required this.updateQnA, required this.deleteQnA});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < qnaList.length; i++)
          ListTile(
            title: Text(qnaList[i]['title'] ?? ""),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QnADetailPage(
                    qna: qnaList[i],
                    updateQnA: updateQnA,
                    deleteQnA: deleteQnA,
                    index: i,
                  ),
                ),
              );
            },
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
          child: Text("글쓰기",
            style: TextStyle(fontWeight:FontWeight.bold),),
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
    if (_titleController.text.isEmpty || _authorController.text.isEmpty || _contentController.text.isEmpty) {
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

class QnADetailPage extends StatelessWidget {
  final Map<String, String> qna;
  final Function(int, Map<String, String>) updateQnA;
  final Function(int) deleteQnA;
  final int index;

  QnADetailPage({required this.qna, required this.updateQnA, required this.deleteQnA, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(qna['title'] ?? "상세보기"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("작성자: ${qna['author'] ?? ""}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(qna['content'] ?? "", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditQnAPage(
                          qna: qna,
                          updateQnA: updateQnA,
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Text("수정"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    deleteQnA(index);
                    Navigator.pop(context);
                  },
                  child: Text("삭제"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditQnAPage extends StatefulWidget {
  final Map<String, String> qna;
  final Function(int, Map<String, String>) updateQnA;
  final int index;

  EditQnAPage({required this.qna, required this.updateQnA, required this.index});

  @override
  _EditQnAPageState createState() => _EditQnAPageState();
}

class _EditQnAPageState extends State<EditQnAPage> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.qna['title']);
    _authorController = TextEditingController(text: widget.qna['author']);
    _contentController = TextEditingController(text: widget.qna['content']);
  }

  void _submit() {
    if (_titleController.text.isEmpty || _authorController.text.isEmpty || _contentController.text.isEmpty) {
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
    widget.updateQnA(widget.index, qna);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("글 수정"),
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
              child: Text("수정"),
            ),
          ],
        ),
      ),
    );
  }
}
