sites = %{
	mblz
	integrated-internet
	virtual-office-manager
	healingawareness
	naturalskincaresa
	naturalwaysa
	sunshine-landscape
	thecasesgrp
	heartwoodtreesa
	alamotreesystems
	vudmaska
	maximumaltitude
	cynthiamoseleylmt
	price-less-glass
	mag-realestate
}.strip.split

sites.each do |site|
	puts %Q{

server {
  listen 80;
  server_name www.#{site}.com;
  root /home/deployer/apps/cms/current/public;
  passenger_enabled on;

}
server {
  listen 80;
  server_name #{site}.com;
  return 301 http://www.#{site}.com$request_uri;
}

}.strip
end
