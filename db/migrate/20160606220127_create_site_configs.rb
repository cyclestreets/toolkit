class CreateSiteConfigs < ActiveRecord::Migration
  def change
    create_table :site_configs do |t|
      t.string :logo_uuid
      t.string :application_name, null: false
      t.string :domain, null: false
      t.string :funder_image_footer1_uuid
      t.string :funder_image_footer2_uuid
      t.string :funder_image_footer3_uuid
      t.string :funder_image_footer4_uuid
      t.string :funder_image_footer5_uuid
      t.string :funder_image_footer6_uuid
      t.string :funder_name_footer1
      t.string :funder_name_footer2
      t.string :funder_name_footer3
      t.string :funder_name_footer4
      t.string :funder_name_footer5
      t.string :funder_name_footer6
      t.string :funder_url_footer1
      t.string :funder_url_footer2
      t.string :funder_url_footer3
      t.string :funder_url_footer4
      t.string :funder_url_footer5
      t.string :funder_url_footer6
      t.geometry :nowhere_location, srid: 4326, null: false
      t.string :tile_server1_name, null: false
      t.string :tile_server2_name
      t.string :tile_server3_name
      t.string :tile_server4_url
      t.string :tile_server1_url, null: false
      t.string :tile_server2_url
      t.string :tile_server3_url
      t.string :tile_server4_url
      t.string :facebook_link
      t.string :twitter_link
      t.text :footer_links_html, null: false
      t.text :header_html, null: false
      t.string :default_locale, null: false
      t.string :timezone, null: false
      t.string :ga_account_id
      t.string :ga_base_domain
      t.string :default_email
      t.string :devise_email
      t.string :geocoder_url, null: false
      t.string :geocoder_key

      t.timestamps null: false
    end

    execute "INSERT INTO site_configs (application_name, domain, nowhere_location,
                                      tile_server1_name, tile_server1_url,
                                      facebook_link, twitter_link,
                                      footer_links_html, header_html, default_locale,
                                      timezone, geocoder_url,
                                      ga_account_id, ga_base_domain,
                                      updated_at, created_at)
    VALUES ('Cyclescape', 'default', ST_GeomFromText('POINT(0.1275 51.5032)', 4326),
    'OpenCycleMap', 'http://[a|b|c].tile.cyclestreets.net/opencyclemap/${z}/${x}/${y}@2x.png',
    'https://www.facebook.com/CycleStreets', 'https://twitter.com/cyclescape',
    '<li><small><a href=\"http://blog.cyclescape.org/\">Cyclescape blog</a></small>
</li>
<li>
<small><a href=\"http://blog.cyclescape.org/guide/\">User guide</a></small>
</li>
<li>
<small><a href=\"/pages/privacypolicy\">Privacy Policy</a></small>
</li>
<li>',
    '<li><a href=\"http://blog.cyclescape.org/about/\">About</a></li><li><a href=\"http://blog.cyclescape.org/guide/\">User guide</a></li>',
    'en-GB', 'London', 'https://api.cyclestreets.net/v2/geocoder',
    'UA-28721275-1', 'cyclescape.org', now(), now());"
  end
end