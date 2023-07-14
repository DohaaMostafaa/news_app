abstract class NewsState{}
class InitialState extends NewsState{}

class BottomState extends NewsState{}

class ChangeBottomState extends NewsState{}

class BusinessLoadingState extends NewsState{}

class BusinessState extends NewsState{}

class BusinessErrorState extends NewsState{
  final String error;
  BusinessErrorState(this.error);
}
class SportsLoadingState extends NewsState{}

class SportsState extends NewsState{}

class SportsErrorState extends NewsState{
  final String error;
  SportsErrorState(this.error);
}
class ScienceLoadingState extends NewsState{}

class ScienceState extends NewsState{}

class ScienceErrorState extends NewsState{
  final String error;
  ScienceErrorState(this.error);
}

class SearchLoadingState extends NewsState{}

class SearchState extends NewsState{}

class SearchErrorState extends NewsState{
  final String error;
  SearchErrorState(this.error);
}

