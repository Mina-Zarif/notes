abstract class SignupStates {}

class SignupInitialStates extends SignupStates {}

class ShowingAndHidingPassword extends SignupStates {}

class SignupProcessLoading extends SignupStates {}

class SignupProcessSuccess extends SignupStates {}

class SignupProcessError extends SignupStates {}

class StoreDataSuccess extends SignupStates {}

class StoreDataError extends SignupStates {}
