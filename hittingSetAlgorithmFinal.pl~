hsa(SD, COMP, OBS, HS, List):-
    not(tp(SD, COMP, OBS, HS, _)),
    List = [HS].

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

minimal_hsa(SD, COMP, OBS, HS, Minimal):-
    hsa(SD, COMP, OBS, HS, List),
    lsort(List,AscendingList),
    reverse(AscendingList, DescendingList),
    recursive_min_supersets(DescendingList, Minimal).

recursive_min_supersets([], MinimalList):-
    MinimalList = [].

recursive_min_supersets([A|B], MinimalList):-
    recursive_min_supersets(B, ML2),
    (   not(is_superset(A, ML2)) ->
    append(ML2, [A], MinimalList);
    MinimalList = ML2).

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

is_superset(_, []):-
    false.

is_superset(SuperSet, [A|B]):-
    (   subset(A, SuperSet)->
    true;
    is_superset(SuperSet, B)).










