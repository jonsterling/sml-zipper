signature ROSE_TREE =
sig
  type elem
  type tree

  datatype 'a view =
      LEAF of elem
    | NODE of 'a list

  val into : tree view -> tree
  val out : tree -> tree view
  val map : ('a -> 'b) -> 'a view -> 'b view
end
