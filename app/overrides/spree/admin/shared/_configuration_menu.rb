Deface::Override.new(
 virtual_path:  'spree/admin/shared/_configuration_menu',
 name:          'add_venue_admin_menu_links',
 insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
 text: "<%= configurations_sidebar_menu_item Spree.t('venue.index'), spree.admin_venues_path %>"
)
