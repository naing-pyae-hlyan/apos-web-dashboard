sealed class CategoryChangeState {}

class CategoryChangeStateInitial extends CategoryChangeState {}

// Add colors & sizes
class CategoryChangeStateSelectedCategory extends CategoryChangeState {}

class CategoryChangeStateHasSizes extends CategoryChangeState {}

class CategoryChangeStateHasColors extends CategoryChangeState {}
