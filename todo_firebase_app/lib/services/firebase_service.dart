import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo_model.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  // Auth
  static Future<User?> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  static Future<User?> register(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static User? get currentUser => _auth.currentUser;

  // CRUD To-Do
  static Stream<List<TodoModel>> todosStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('todos')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => TodoModel.fromFirestore(doc)).toList());
  }

  static Future<void> addTodo(String title) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    await _firestore.collection('users').doc(uid).collection('todos').add({
      'title': title,
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateTodo(TodoModel todo) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    await _firestore.collection('users').doc(uid).collection('todos').doc(todo.id).update({
      'title': todo.title,
      'isDone': todo.isDone,
    });
  }

  static Future<void> deleteTodo(String id) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    await _firestore.collection('users').doc(uid).collection('todos').doc(id).delete();
  }
} 