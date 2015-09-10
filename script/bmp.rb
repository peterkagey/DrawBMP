require_relative 'bmp_header'
require_relative 'dib_header'
require_relative 'pixel_array'

class BMPMaker

  def initialize(red, green, blue, w, h)
    @width = (w || 256).to_i
    @height = (h || 256).to_i

    @pixel_ary = Array.new(@width) { Array.new(@height) }
    @red, @green, @blue = red, green, blue

    print_expressions
    fill_pixel_array
    set_file_info
  end

  def make_bmp
    File.write(@file_name, BMPBase.new(@pixel_ary).raw_file)
    puts "Made file: #{@file_name}"
    `open #{@file_name}`
  end

  private

  attr_reader :width, :height

  def f(x,y)
    [blue(x,y), green(x,y), red(x,y)].map(&:to_i)
  end

  def red(x,y)
    return eval(@red) if @red && @red != ""
    2**0.5 * dist(x - @width, y - @height) * (256.0/@width)
  end

  def green(x,y)
    return eval(@green) if @green && @green != ""
    x + y > @width * 0.8 && x + y < @width * 1.2 ? 0x90 : 0x40
  end

  def blue(x,y)
    return eval(@blue) if @blue && @blue != ""
    2**0.5 * dist(x,y) * (256.0/@width)
  end

  def print_expressions
    puts "Red:   (#{@red})"   if @red   && @red != ""
    puts "Green: (#{@green})" if @green && @green != ""
    puts "Blue:  (#{@blue})"  if @blue  && @blue != ""
  end

  def fill_pixel_array
    (0...@width).each do |x|
      (0...@height).each { |y| @pixel_ary[x][y] = f(x,y) }
    end
  end

  def set_file_info
    @path = File.dirname(File.dirname(__FILE__)) + "/images"
    @file_id = Time.now.to_i
    @file_name = "#{@path}/image_#{@file_id}.bmp"
  end

  # Custom arithmetic

  def dist(x,y)
    Math.sqrt(x**2 + y**2)
  end

  def normalize(value)
    value %= 256
    128 * (Math.cos(2 * 3.1415*value/256) + 1)
  end

end

BMPMaker.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3], ARGV[4]).make_bmp
