## Pyramid App

The latter can simply be:

    from pyramid.paster import get_app, setup_logging
    from waitress import serve
    setup_logging(configfile)
    application: Router = get_app(configfile, 'main')
    serve(app, host='0.0.0.0', port=8088, threads=50)
    
A file for `mod_wsgi` is the same but without the last line (`application` is a keyword).

The `pyramid.get_app` reads the `configfile` to get the module to load,
`main` is the function within `michelanglo_app` that returns a Router instance.
A Router instance is a callable that accepts an WSGI environment, just like a `flask.Flask` instance,
hence why both have the methods `__call__(environ, start_response) ` and `request_context(environ)` ,
but the two have rather different albeit similar inner workings, but their syntax differ dramatically.
The `get_app` function can also accept an parameter `options` if there are interpolated variables in the ini file
(not in the default ones).

    application = get_app(configfile, 'main', options={'SQL_URL': os.environ['SQL_URL']})

Here is basically a long loop around the config file.
    
    from configparser import ConfigParser
    config = ConfigParser()
    config.read('/Users/matteo/Coding/michelanglo/app/production.ini')
    settings = config['app:main']
    
    import michelanglo_app
    application = michelanglo_app.main({}, **settings)
