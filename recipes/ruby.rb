node.override['languages']['ruby']['default_version'] = node['rs-cookbooks_ci']['languages']['ruby']['default_version']

include_recipe "ruby"
