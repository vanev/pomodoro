'use strict';
require('./index.html')
require('./index.scss')

var Elm = require('./Main.elm')
var mountNode = document.getElementById('app')

var app = Elm.Main.embed(mountNode)
