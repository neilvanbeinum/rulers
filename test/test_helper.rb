# "promote" the local gem over anything else (e.g. system installation of this gem)
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "rulers"
require "rack/test"
require "minitest/autorun"
