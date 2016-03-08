LUA_GZ="10.1.18.123 10.1.18.124"
LUA_BJ="10.1.80.231 10.1.80.232"
LUA_BJ_TEST="10.1.80.232"
LUA_GZ_TEST="10.1.18.124"
LUA_ALL="10.1.80.231 10.1.80.232 10.1.18.123 10.1.18.124"
    
LUA_IPS=$(LUA_ALL)
BACK_IPS="10.1.1.4"
UPDATE_IP="10.1.19.83 10.1.16.36 10.1.16.37"
#UPDATE_IP="10.1.19.83"
UPDATE_BAC_IP="10.1.17.119"
	
install:
	@echo "are you really want to install? env is $(LUA_IPS) [yes|no]";
	@read continue; \
	if [ $$continue != "yes" ]; then \
		echo "install quit"; exit 1; \
	fi

ly:
	chown -R root.root lyric
	chown -R www.www lyric/application/logs

lyric_local_dry: ly
	./rsync local_dry lyric/application

lyric_local_install: ly install
	./rsync local_install lyric/application

lyric_dry: ly
	./rsync dry lyric/application /data1/ngx_lua/application $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"'

lyric_diff: ly
	./rsync diff lyric/application /data1/ngx_lua/application $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"' .lua

lyric_install: ly install
	./rsync install lyric/application /data1/ngx_lua/application $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"'

m40:
	chown -R root.root mobile4.0
	chown -R www.www mobile4.0/src/mobileservice/logs

m40_local_dry: m40
	./rsync local_dry mobile4.0/src/mobileservice

m40_local_install: m40 install
	./rsync local_install mobile4.0/src/mobileservice

m40_dry: m40
	./rsync dry mobile4.0/src/mobileservice /data1/ngx_lua/mobileservice $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"'

m40_diff: m40
	./rsync diff mobile4.0/src/mobileservice /data1/ngx_lua/mobileservice $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"' .lua

m40_install: m40 install
	./rsync install mobile4.0/src/mobileservice /data1/ngx_lua/mobileservice $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"'

st:
	chown -R root.root store
	chown -R www.www store/src/musicstore/logs

store_local_dry: st
	./rsync local_dry store/src/musicstore

store_local_install: st install
	./rsync local_install store/src/musicstore

store_dry: st
	./rsync dry store/src/musicstore /data1/ngx_lua/musicstore $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"'

store_diff: st
	./rsync diff store/src/musicstore /data1/ngx_lua/musicstore $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"' .lua

store_install: st install
	./rsync install store/src/musicstore /data1/ngx_lua/musicstore $(LUA_IPS) ' --exclude "*_test.lua" --exclude "*_gz.lua"'


#sms backgrond
sms:
	chown -R www.www sms3.0/admin
	chmod -R 755 sms3.0/admin
sms_dry: sms
	./rsync dry sms3.0/admin /data1/webroot/kgmedit.kugou.com/sms/v3 $(BACK_IPS) '--exclude "sendtest.php" --exclude ".htaccess" --exclude "data/*"'

sms_diff: sms
	./rsync diff sms3.0/admin /data1/webroot/kgmedit.kugou.com/sms/v3 $(BACK_IPS) '--exclude "sendtest.php" --exclude ".htaccess" --exclude "data/*"' .php

sms_install: sms install
	./rsync install sms3.0/admin /data1/webroot/kgmedit.kugou.com/sms/v3 $(BACK_IPS) '--exclude "sendtest.php" --exclude ".htaccess" --exclude "data/*"'

#mobile4.0 background
m40_bac:
	chown -R www.www mobile4.0/src/admin
	chmod -R 755 mobile4.0/src/admin
m40_bac_dry: m40_bac
	./rsync dry mobile4.0/src/admin /data1/webroot/kgmedit.kugou.com/mobileservice_v4 $(BACK_IPS) ' --exclude ".htaccess"'

m40_bac_diff: m40_bac
	./rsync diff mobile4.0/src/admin /data1/webroot/kgmedit.kugou.com/mobileservice_v4 $(BACK_IPS) ' --exclude ".htaccess"' .php

m40_bac_install: m40_bac install
	./rsync install mobile4.0/src/admin /data1/webroot/kgmedit.kugou.com/mobileservice_v4 $(BACK_IPS) ' --exclude ".htaccess"'

#update
update:
	chown -R www.www updateservice2.0/lua_src
	chmod -R 755 updateservice2.0/lua_src
update_dry: update
	./rsync dry updateservice2.0/lua_src/application/updateservice /data1/ngx_lua/application/updateservice $(UPDATE_IP) ' --exclude "*_test.lua" --exclude "*_gz.lua" --exclude "*.conf"'

update_diff: update
	./rsync diff updateservice2.0/lua_src/application/updateservice /data1/ngx_lua/application/updateservice $(UPDATE_IP) ' --exclude "*_test.lua" --exclude "*_gz.lua" --exclude "*.conf"' .lua

update_install: update install
	./rsync install updateservice2.0/lua_src/application/updateservice /data1/ngx_lua/application/updateservice $(UPDATE_IP) ' --exclude "*_test.lua" --exclude "*_gz.lua" --exclude "*.conf"'

#updatephp
updatephp:
	chown -R www.www updateservice2.0/src
	chmod -R 755 updateservice2.0/src
update_dryphp: updatephp
	./rsync dry updateservice2.0/src /data1/htdocs/update.mobile.kugou.com $(UPDATE_IP) '--exclude "testupdate.php" --exclude ".htaccess" --exclude "data/*" --exclude "test/*"'

update_diffphp: updatephp
	./rsync diff updateservice2.0/src /data1/htdocs/update.mobile.kugou.com $(UPDATE_IP) '--exclude "testupdate.php" --exclude ".htaccess" --exclude "data/*" --exclude "test/*"' .php

update_installphp: updatephp install
	./rsync install updateservice2.0/src /data1/htdocs/update.mobile.kugou.com $(UPDATE_IP) '--exclude "testupdate.php" --exclude ".htaccess" --exclude "data/*" --exclude "test/*"'

#update backgrond
update_bac:
	chown -R www.www updateservice2.0_admin/src
	chmod -R 755 updateservice2.0_admin/src
update_bac_dry: update_bac
	./rsync dry updateservice2.0_admin/src /data1/htdocs/admin.mobile.kugou.com/updateservice $(UPDATE_BAC_IP) '' '--exclude "testupdate.php" --exclude "data/*" --exclude "doc/*" --exclude ".htaccess"'

update_bac_diff: update_bac
	./rsync diff updateservice2.0_admin/src /data1/htdocs/admin.mobile.kugou.com/updateservice $(UPDATE_BAC_IP) '' '--exclude "testupdate.php" --exclude "data/*" --exclude "doc/*" --exclude ".htaccess"' .php

update_bac_install: update_bac install
	./rsync install updateservice2.0_admin/src /data1/htdocs/admin.mobile.kugou.com/updateservice $(UPDATE_BAC_IP) '' '--exclude "testupdate.php" --exclude "data/*" --exclude "doc/*" --exclude ".htaccess"'
