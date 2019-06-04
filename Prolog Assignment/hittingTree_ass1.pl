/*Base case*/
hsa(SD, COMP, OBS, HS, List):-
    not(tp(SD, COMP, OBS, HS, _)),
    List = [HS].

/*Check if there are children*/
hsa(SD, COMP, OBS, HS, List):-
    tp(SD, COMP, OBS, HS, CS),
    forall_hsa(SD, COMP, OBS, HS, List, CS).

forall_hsa(_, _, _, _, List, []):-
    List = [].

forall_hsa(SD, COMP, OBS, HS, List, [X|Y]):-
    append(HS, [X], NewHS),
    hsa(SD, COMP, OBS, NewHS, List1),
    forall_hsa(SD, COMP, OBS, HS, List2, Y),
    append(List1, List2, List).

/*gets the list and checks which list in there is smallest*/

/*copied from https://github.com/Rootex/99-prolog-problems/blob/master/lists.prolog*/
lsort([], []).
lsort([H|T],[H|R]) :-
        length(H, Lh),
        forall(member(M, T),
               (length(M, Lm),
                Lh =< Lm)),
        lsort(T, R), !.
lsort([F,S|T], R) :-
        append(T,[F],X),
        lsort([S|X], R). 

superSets([], []).	
superSets([H|T], sub, minList):-
	subset(sub, H),
	append(minList, sub),
	sub is H,
	superSets(T, minList),


/*Ella remove superset code*/

minimal_hsa(SD, COMP, OBS, HS, Minimal):-
    hsa(SD, COMP, OBS, HS, List),
    lsort(List, SortedList),
    minimal_supersets(SortedList, [], Minimal).

minimal_supersets([], Test, MinimalList):-
    MinimalList = Test.

minimal_supersets([A|B], Test, MinimalList):-
    (   not(supersets(A, Test
                     ))->
    append(Test, [A], Test2),
    minimal_supersets(B, Test2, MinimalList)).

minimal_supersets([_|B], Test, MinimalList):-
    minimal_supersets(B, Test, MinimalList).

recursive_min_supersets([], MinimalList):-
    MinimalList = [].

recursive_min_supersets([A|B], MinimalList):-
    recursive_min_supersets(B, ML2),
    (   not(supersets(A, ML2)) ->
    append(ML2, [A], MinimalList);
    MinimalList = ML2).

supersets(_, []):-
    false.

supersets(SuperSet, [A|B]):-
    (   subset(A, SuperSet)->
    true;
    supersets(SuperSet, B)).

