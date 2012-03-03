# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

$site_config = {}
$site_config[:root] = ENV['TCS_SITE_ROOT'] || ''
