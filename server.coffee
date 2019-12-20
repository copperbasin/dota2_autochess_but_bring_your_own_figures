#!/usr/bin/env iced
### !pragma coverage-skip-block ###
argv = require('minimist')(process.argv.slice(2))
argv.port ?= 1337
argv.ws_port ?= argv.port+10000
{
  master_registry
  Webcom_bundle
} = require 'webcom/lib/client_configurator'
require 'webcom-client-plugin-base/src/hotreload'
require 'webcom-client-plugin-base/src/react'
require 'webcom-client-plugin-base/src/keyboard'
delivery = require 'webcom'


bundle = new Webcom_bundle master_registry
bundle.plugin_add 'Webcom hotreload'
bundle.plugin_add 'Webcom react'
bundle.plugin_add 'keyboard scheme'
bundle.feature_hash.hotreload = true

delivery.start {
  htdocs : 'htdocs'
  hotreload  : !!argv.watch
  title : "Dota2 autochess but bring your own figures"
  bundle
  port    : argv.port
  ws_port : argv.ws_port
  watch_root  : true
  allow_hard_stop : true
  engine : {
    HACK_remove_module_exports : true
  }
  vendor : 'react_min'
  gz : true
}
