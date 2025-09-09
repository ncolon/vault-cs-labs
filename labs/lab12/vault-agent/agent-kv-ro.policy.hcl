# Description: This policy allows read access to the agent kvv2 secret engine
path "agent/data/config" {
    capabilities = ["read", "list"]
}
path "token/lookup-self" {
  capabilities = ["read"]
}