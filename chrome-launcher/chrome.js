#!/usr/bin/env node

var child_process = require('child_process');
var nomnom = require('nomnom');
var path = require('path');

var opts = nomnom
    .script('chrome')
    .options({
        dataDir: {
            string: '-d DATADIR, --data-dir=DATADIR',
            help: 'Name of a "virtual Chrome installation" to use.  Will set Chrome\'s data-dir option.'
        },
        appUrl: {
            string: '-a APPURL, --app-url=APPURL',
            help: 'URL to launch in a chrome-less window, like an app.'
        }
    }).parse();

var chromePath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
var args = [];

if(opts.dataDir) {
    args.push('--user-data-dir=' + path.join(process.env['HOME'], 'chromes', opts.dataDir));
}

if(opts.appUrl) {
    args.push('--app=' + opts.appUrl);
}

child_process.spawn(chromePath, args, {
    stdio: 'ignore',
    detached: true
});
process.exit(0);

