resource "null_resource" "out" {
  triggers = {
    always_run = "${timestamp()}"
  }

}
