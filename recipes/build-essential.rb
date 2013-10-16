node.override['build_essential']['compiletime'] = node['rs-cookbooks_ci']['build_essential']['compiletime']

include_recipe "build-essential"
