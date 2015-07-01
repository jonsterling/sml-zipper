functor FixView (type 'a view) =
struct
  datatype t = T of t view
  val into = T
  fun out (T t) = t
end

functor RoseTree (type elem) :> ROSE_TREE =
struct
  type elem = elem

  datatype 'a view =
      LEAF of elem
    | NODE of 'a list

  structure FixView = FixView (type 'a view = 'a view)
  type tree = FixView.t
  open FixView

  fun map f (LEAF E) = LEAF E
    | map f (NODE xs) = NODE (List.map f xs)
end
