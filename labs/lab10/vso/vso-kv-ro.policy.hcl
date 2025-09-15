# Description: This policy allows read access to the vso kvv2 secret engine
path "vso/data/config" {
  capabilities = ["read", "list"]
}
path "token/lookup-self" {
  capabilities = ["read"]
}