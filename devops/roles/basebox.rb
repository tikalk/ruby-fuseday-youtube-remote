name 'basebox'

run_list [
  'recipe[mongodb::10gen_repo]',
  'recipe[tikal-redis]',
  'recipe[tikal-memcache]',
  'recipe[tikal-solr]',
  'recipe[tikal-mongo]'
]
