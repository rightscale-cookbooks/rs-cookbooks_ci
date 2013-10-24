# Compiletime attribute for build-essential needs to be set to true so that the BCrypt gem used by the user
# recipe can buld
default['rs-cookbooks_ci']['build_essential']['compiletime'] = true
