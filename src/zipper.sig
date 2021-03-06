signature ZIPPER =
sig
  type tree
  type path

  type location = tree * path

  exception InvalidMovement

  val init : tree -> location
  val left : location -> location
  val right : location -> location
  val up : location -> location
  val down : location -> location
end
