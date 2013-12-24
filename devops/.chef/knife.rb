require 'librarian/chef/integration/knife'

current_dir = File.dirname(__FILE__)

log_level                :info
log_location             STDOUT
node_name                "avitzurel"
client_key               ENV.fetch('KNIFE_CLIENT_KEY', File.join(current_dir,'admin.pem'))
client_key               "#{current_dir}/avitzurel.pem"
validation_client_name   "tikal-validator"
validation_key           ENV.fetch('KNIFE_CHEF_VALIDATION_KEY', File.join(current_dir,'tikal-validator.pem'))
syntax_check_cache_path  File.join(current_dir,'syntax_check_cache')
chef_server_url          "https://api.opscode.com/organizations/tikal"
cookbook_path            [File.join(current_dir,'..','site-cookbooks'), Librarian::Chef.install_path]
data_bag_path            File.join(current_dir,'..','data_bags')
role_path                File.join(current_dir,'..','roles')

cookbook_copyright      "Tikal-Kenso Ltd."

knife[:use_sudo]              = true