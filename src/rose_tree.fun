functor RoseTree (type elem) : ROSE_TREE =
struct
  type elem = elem

  datatype 'a view =
      LEAF of elem
    | NODE of 'a list

  datatype tree = TREE of tree view

  val into = TREE
  fun out (TREE t) = t

  fun map f (LEAF E) = LEAF E
    | map f (NODE xs) = NODE (List.map f xs)
end
