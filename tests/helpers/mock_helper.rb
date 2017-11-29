# Use so you can run in mock mode from the command line
#
# FOG_MOCK=true fog

Fog.mock! if ENV["FOG_MOCK"] == "true"

# if in mocked mode, fill in some fake credentials for us
if Fog.mock?
  Fog.credentials = {
    :ovirt_url => "http://ovirt:8080/api",
    :ovirt_username                   => "admin@internal",
    :ovirt_password                   => "123123"
  }.merge(Fog.credentials)
end
