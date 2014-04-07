/ Candle for LIFX
@shoerust - 2014/

require 'bundler'
Bundler.require

label = ARGV.first
lifx = LIFX::Client.lan
lifx.discover! do
  label ? lifx.lights.with_label(label) : lifx.lights.first
end

light = label ? lifx.lights.with_label(label) : lifx.lights.first

puts "Light detected, starting Candle."

thread = Thread.new do
  candle = LIFX::Color.rgb(255, 197, 143)
  candle.saturation = 0.1
  candle.kelvin = 1900
  loop do
    candle.brightness = rand(0.0..0.6)
    light.set_color(candle)
  end
end

thread.join