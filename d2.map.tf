variable "force_map" {
  type = map(string)
  default = {
    "luke" = "jedi",
    "yoda" = "jedi"
  }
}
#if you want to add another vm just add a new start war charcter
