// lib/pages/news_create_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsCreatePage extends StatefulWidget {
  const NewsCreatePage({super.key});

  @override
  State<NewsCreatePage> createState() => _NewsCreatePageState();
}

class _NewsCreatePageState extends State<NewsCreatePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('news').add({
        'title': _title,
        'content': _content,
        'createdAt': Timestamp.now(),
      });
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('登録に失敗しました: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ新規登録')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'タイトル'),
                onSaved: (v) => _title = v ?? '',
                validator: (v) =>
                    v == null || v.isEmpty ? 'タイトルを入力してください' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: '内容'),
                maxLines: 5,
                onSaved: (v) => _content = v ?? '',
                validator: (v) => v == null || v.isEmpty ? '内容を入力してください' : null,
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(onPressed: _submit, child: const Text('登録')),
            ],
          ),
        ),
      ),
    );
  }
}
