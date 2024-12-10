enum TodoStatus {
  pending,
  completed,
  all;

  String get displayName {
    switch (this) {
      case TodoStatus.pending:
        return 'Pending';
      case TodoStatus.completed:
        return 'Completed';
      case TodoStatus.all:
        return 'All';
    }
  }
}
