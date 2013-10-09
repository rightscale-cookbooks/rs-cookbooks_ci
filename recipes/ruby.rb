node.override['languages']['ruby']['default_version'] = node['rs-cookbooks-ci']['languages']['ruby']['default_version']

include_recipe "ruby"
