% -----------------------------------------------------------------------------
%  minimal_hsa(+SD,+COMP, +OBS, -Minimal)  
%             -  Determines a minimal set of diagnosis for the diagnostic problem
%                (SD,COMP,[],OBS).            
%
%  SD: list of first-order formula, where variables are understood to quantify
%      over elements in COMP
%  COMP: set of all components
%  OBS: set of (ground) facts


minimal_hsa(SD, COMP, OBS, Minimal):-
    hsa(SD, COMP, OBS, [], HSS),
    lsort(HSS,AscendingHSS),
    reverse(AscendingHSS, DescendingHSS),
    remove_supersets(DescendingHSS, Minimal).

%  hsa(+SD,+COMP, +OBS, +HS, -HSS)  
%             -  Determines a set of hitting sets for the diagnostic problem
%                (SD,COMP-HS,OBS).             

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

%  remove_supersets(+List,-MinimalList)  
%             -  Removes all list in List which is a superset of a list 
%             that is previously contained

remove_supersets([], MinimalList):-
    MinimalList = [].

remove_supersets([X|Y], MinimalList):-
    remove_supersets(Y, ML2),
    (   not(has_subset_in_list(X, ML2)) ->
    append(ML2, [X], MinimalList);
    MinimalList = ML2).

%  has_subset_in_list(+Set, +List)  
%             -  Boolean function that returns ture if a passed list
%             is already present in the Set given to the function.

has_subset_in_list(_, []):-
    false.

has_subset_in_list(Set, [X|Y]):-
    (   subset(X, Set)->
    true;
    has_subset_in_list(Set, Y)).

%  Source of function: https://github.com/charlespwd/project-title

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












