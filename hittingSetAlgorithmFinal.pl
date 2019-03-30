hsa(SD, COMP, OBS, HS, HSS):-
    not(tp(SD, COMP, OBS, HS, _)),
    HSS = [HS].

hsa(SD, COMP, OBS, HS, HSS):-
    tp(SD, COMP, OBS, HS, CS),
    forall_hsa(SD, COMP, OBS, HS, CS, HSS).

forall_hsa(_, _, _, _, [], HSS):-
    HSS = [].

forall_hsa(SD, COMP, OBS, HS, [X|Y], HSS):-
    append(HS, [X], NewHS),
    hsa(SD, COMP, OBS, NewHS, HSS1),
    forall_hsa(SD, COMP, OBS, HS, Y, HSS2),
    append(HSS1, HSS2, HSS).

minimal_hsa(SD, COMP, OBS, HS, Minimal):-
    hsa(SD, COMP, OBS, HS, List),
    lsort(List,AscendingList),
    reverse(AscendingList, DescendingList),
    remove_supersets(DescendingList, Minimal).

remove_supersets([], MinimalList):-
    MinimalList = [].

remove_supersets([X|Y], MinimalList):-
    remove_supersets(Y, ML2),
    (   not(has_subset_in_list(X, ML2)) ->
    append(ML2, [X], MinimalList);
    MinimalList = ML2).

has_subset_in_list(_, []):-
    false.

has_subset_in_list(Set, [X|Y]):-
    (   subset(X, Set)->
    true;
    has_subset_in_list(Set, Y)).

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












