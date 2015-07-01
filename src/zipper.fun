functor Zipper (RoseTree : ROSE_TREE) :> ZIPPER =
struct
  type tree = RoseTree.tree

  datatype path =
      TOP
    | NODE of tree list * path * tree list

  type location = tree * path

  exception InvalidMovement

  fun left (t, p) =
    case p of
         TOP => raise InvalidMovement
       | NODE (l::ls, up, rs) => (l, NODE (ls, up, t::rs))
       | _ => raise InvalidMovement

  fun right (t, p) =
    case p of
         TOP => raise InvalidMovement
       | NODE (ls, up, r::rs) => (r, NODE (t::ls, up, rs))
       | _ => raise InvalidMovement

  fun up (t, p) =
    case p of
         TOP => raise InvalidMovement
       | NODE (ls, up, rs) => (RoseTree.into (RoseTree.NODE (rev ls @ t::rs)) , up)

  fun down (t, p) =
    case RoseTree.out t of
         RoseTree.LEAF _ => raise InvalidMovement
       | RoseTree.NODE (t'::ts) => (t', NODE ([], p, ts))
       | _ => raise InvalidMovement
end
