//check external configuration as described in Config.groovy


dataSource_oauth2 {
    driverClassName = 'org.h2.Driver'
    url = "jdbc:h2:~/.grails/oauth2db;MVCC=TRUE"
    username = 'sa'
    password = ''
    dbCreate = 'update'
    logSql = true
    formatSql = true
}

environments {
    test {
        dataSource {
            driverClassName = 'org.h2.Driver'
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;INIT=RUNSCRIPT FROM './h2_init.sql'"
            username = 'sa'
            password = ''
            dbCreate = 'update'
            logSql = true
            formatSql = true
        }

        dataSource_oauth2 {
            driverClassName = 'org.h2.Driver'
            url = "jdbc:h2:mem:oauth2;MVCC=TRUE"
            username = 'sa'
            password = ''
            dbCreate = 'update'
            logSql = true
            formatSql = true
        }

    }
}

if (hibernate.cache.region.factory_class != 'grails.plugin.cache.ehcache.hibernate.BeanEhcacheRegionFactory') {
    hibernate {
        cache.use_query_cache        = true
        cache.use_second_level_cache = true
        cache.provider_class         = 'org.hibernate.cache.EhCacheProvider'
    }
}
