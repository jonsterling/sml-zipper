functor FanZipper (Fan : FAN) :> ZIPPER where type tree = Fan.t =
struct
  type tree = Fan.t
  type forest = tree list

  type path =
    {lefts : forest,
     rights : forest,
     parents : (forest * Fan.elem * forest) list}

  type location = tree * path

  exception InvalidMovement

  fun init t = (t, {lefts = [], rights = [], parents = []})

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
           (Fan.into (Fan.NODE (a, (rev lefts @ t::rights))),
            {lefts = ls, rights = rs, parents = ps})

  fun down (t, {lefts,rights,parents}) =
    case Fan.out t of
         Fan.NODE (_, []) => raise InvalidMovement
       | Fan.NODE (a, t'::ts) =>
           (t', {lefts = [],
                 rights = ts,
                 parents = (lefts, a, rights) :: parents})
end
