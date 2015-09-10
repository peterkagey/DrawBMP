class BMPBase

  def initialize(array)
    @width = array[0].length
    @height = array.length
    @array = array
  end

  def raw_file
    [
      BMPHeader.new(@array),
      DIBHeader.new(@array),
      PixelArray.new(@array)
    ].map(&:byte_string).join
  end

  def byte_string
    byte_structure.map { |i| make_byte_string(i) }.join
  end

  private

  def row_width
    @width * 3 + (-@width * 3) % 4
  end

  def size_of_bitmap_data
    row_width * @height
  end

  def make_byte_string(value)
    case value
    when Array
      (0...value[1]).to_a.collect do |i|
        value[0] >>= 8 unless i == 0
        (value[0] & 0xFF).chr
      end
    when String
      value
    end
  end

end
