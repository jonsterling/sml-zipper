functor Zipper (RoseTree : ROSE_TREE) :> ZIPPER =
struct
  type tree = RoseTree.tree
  type forest = tree list

  type path =
    {lefts : forest,
     rights : forest,
     parents : (forest * RoseTree.elem * forest) list}


  type location = tree * path

  exception InvalidMovement

  fun left (t, {lefts,rights,parents}) =
    case lefts of
         [] => raise InvalidMovement
       | l::ls => (l, {lefts = ls, rights = t::rights, parents = parents})

  fun right (t, {lefts,rights,parents}) =
    case rights of
         [] => raise InvalidMovement
       | r::rs => (r, {lefts = t::lefts, rights = rs, parents = parents})

  fun up (t, {lefts,rights,parents}) =
    case parents of
         [] => raise InvalidMovement
       | (ls, a, rs) :: ps =>
           (RoseTree.into (RoseTree.NODE (a, (rev lefts @ t::rights))),
            {lefts = ls, rights = rs, parents = ps})

  fun down (t, {lefts,rights,parents}) =
    case RoseTree.out t of
         RoseTree.NODE (_, []) => raise InvalidMovement
       | RoseTree.NODE (a, t'::ts) =>
           (t', {lefts = [],
                 rights = ts,
                 parents = (lefts, a, rights) :: parents})
end
