require_relative 'bmp_base'

class PixelRow
  def initialize(pixel_row)
    @pixel_row = pixel_row # ex: [[1,2,3],[255, 254, 253]...]
    @row_length = pixel_row.length
  end

  def pixel_to_string(pixel)
    pixel.map { |i| (i % 256).chr }.join
  end

  def byte_string
    buffer_size = (-@row_length * 3) % 4
    buffer = 0.chr * buffer_size
    @pixel_row.map { |pixel| pixel_to_string(pixel) }.join + buffer
  end
end

class PixelArray < BMPBase

  def row_to_byte_string(pixel_row)
    pixel_row.map(&:byte_string) + 0.chr * buffer
  end

  def byte_string
    x = @array.map do |row|
      PixelRow.new(row).byte_string
    end
    x.join
  end

end
