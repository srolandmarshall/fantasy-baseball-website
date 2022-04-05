// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const YahooFantasy = require('yahoo-fantasy');
const yf = new YahooFantasy(
  ENV['YAHOO_CLIENT_ID'],
  ENV['YAHOO_CLIENT_SECRET']
);