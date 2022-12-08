abstract class LoginStates {}

class AppInitialStates extends LoginStates {}

class ShowingAndHidingPassword extends LoginStates {}

class LoginStateLoading extends LoginStates {}

class LoginStateSuccess extends LoginStates {}

class LoginStateError extends LoginStates {}
