:- include('KB.pl').
goal(S):-
    /*Pass the expected final state to backtrack it*/
    booth(NEOX,NEOY),
    grid(X,Y),
    capacity(C),
    path(NEOX,NEOY,NEOX,NEOY,X,Y,[],C,0,S).

/*Successor state axiom*/
path(NEOX,NEOY,TBX,TBY,GRIDX,GRIDY,LHOS,C,CAR,result(A,S)):-
    (A=carry, CAR =< C, NEWCAR is CAR - 1,path(NEOX,NEOY,TBX,TBY,GRIDX,GRIDY,[[NEOX,NEOY]|LHOS],C,NEWCAR,S));
    (A=drop, NEOX is TBX, NEOY is TBY, NEWCAR is CAR + 1,path(NEOX,NEOY,TBX,TBY,GRIDX,GRIDY,LHOS,C,NEWCAR,S));
    (A=right, NEOY1 is NEOY - 1, NEOY1>=0, path(NEOX,NEOY1,TBX,TBY,GRIDX,GRIDY,LHOS,C,CAR,S));
    (A=left, NEOY1 is NEOY + 1, NEOY1<GRIDY, path(NEOX,NEOY1,TBX,TBY,GRIDX,GRIDY,LHOS,C,CAR,S));
    (A=down, NEOX1 is NEOX - 1, NEOX1<GRIDX, path(NEOX1,NEOY,TBX,TBY,GRIDX,GRIDY,LHOS,C,CAR,S));
    (A=up, NEOX1 is NEOX + 1, NEOX1>=0, path(NEOX1,NEOY,TBX,TBY,GRIDX,GRIDY,LHOS,C,CAR,S)).

/*We check if the finalt state is equivelant to the state in the knowledge base*/
path(NEOX,NEOY,_,_,_,_,LHOS,_,CAR,s0):-   
    neo_loc(NEOX,NEOY),
    hostages_loc(LHOS),
    CAR is 0.
    

