max(Key1,Val1,Key2,Val2,MaxKey,MaxVal) :-
    			(   Key1 >= Key2
               ->  MaxKey is Key1, MaxVal = Val1 ;
               		Key1 < Key2
               ->  MaxKey is Key2 ,MaxVal = Val2 ).

rework([],[]):-!.
rework([(Key,Val)|[]],[(Key,Val,1,nil,nil)]):-!.
rework([(Key,Val)|Seq],[NewV|NewSeq]) :-
    NewV = (Key,Val,1,nil,nil),
    rework(Seq,NewSeq).

sum(FirstOperand,SecondOperand,R) :- R is FirstOperand + SecondOperand .
build_layer([],[]):-!.
build_layer([OnlyEl|[]],[OnlyEl]):-!.
build_layer([(Key1,Val1,Size1,Left1,Right1), (Key2,Val2,Size2,Left2,Right2)|Seq], [NewV|NewSeq]) :-
   max(Key1,Val1,Key2,Val2,MaxKey,MaxVal),
   sum(Size1,Size2,SizeNewV),
   NewV = (MaxKey,MaxVal,SizeNewV,(Key1,Val1,Size1,Left1,Right1), (Key2,Val2,Size2,Left2,Right2)),
   build_layer(Seq,NewSeq).

build([OnlyEl|[]],OnlyEl):-!.
build(Seq, T):-
    build_layer(Seq,NewSeq),
    build(NewSeq,T).

tree_build([], nil):-!.
tree_build(Seq, T) :-  !,
    rework(Seq,NewSeq),
    build(NewSeq,T).

check((Key,Val,Size,Left,Right), K, R):-
    ( 	Key < K	%go right
    ->  R is -1;
    	Key >= K %go left
    ->  R is 1
    ).

map_get((K,Val,Size,Left,Right),K,Val):-!.
map_get((Key,Val,Size,Left,Right),K, Value):- !,
    check(Left, K, Flag),
    (	Flag > 0
    ->  map_get(Left,K,Value);
    	Flag < 0
    ->  map_get(Right,K,Value)
    ).

map_size(nil,0):-!.
map_size((Key,Val,Size,Left,Right),Size):-!.

