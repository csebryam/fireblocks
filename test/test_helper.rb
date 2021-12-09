# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'dotenv'
Dotenv.load('./config/application.yml')

require 'fireblocks'
require 'pry-byebug'

require 'minitest/autorun'
