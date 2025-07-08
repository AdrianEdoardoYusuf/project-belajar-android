// UI daftar tugas utama
// TODO: Implementasikan tampilan daftar tugas dan tambah/hapus/edit tugas

import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/todo_model.dart';

class TodoListScreen extends StatelessWidget {
  final _controller = TextEditingController();

  TodoListScreen({super.key});

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Tambah Tugas'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Judul tugas'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _controller.clear();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_controller.text.trim().isNotEmpty) {
                  await FirebaseService.addTodo(_controller.text.trim());
                }
                Navigator.pop(ctx);
                _controller.clear();
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, TodoModel todo) {
    final editController = TextEditingController(text: todo.title);
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Tugas'),
          content: TextField(
            controller: editController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Judul tugas'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (editController.text.trim().isNotEmpty) {
                  await FirebaseService.updateTodo(
                    TodoModel(id: todo.id, title: editController.text.trim(), isDone: todo.isDone),
                  );
                }
                Navigator.pop(ctx);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseService.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: StreamBuilder<List<TodoModel>>(
        stream: FirebaseService.todosStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final todos = snapshot.data ?? [];
          if (todos.isEmpty) {
            return const Center(child: Text('Belum ada tugas'));
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, i) {
              final todo = todos[i];
              return ListTile(
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (val) {
                    FirebaseService.updateTodo(
                      TodoModel(id: todo.id, title: todo.title, isDone: val ?? false),
                    );
                  },
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showEditDialog(context, todo),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => FirebaseService.deleteTodo(todo.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
        tooltip: 'Tambah Tugas',
      ),
    );
  }
} 