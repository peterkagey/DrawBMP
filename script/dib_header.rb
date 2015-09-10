require_relative 'bmp_base'

class DIBHeader < BMPBase

  LENGTH = 40
  PLANES = 1
  BITS_PER_PIXEL = 24
  PIXEL_COMPRESSION = 0
  PRINT_RESOLUTION = 0
  NUMBER_OF_COLORS = 0
  IMPORTANT_COLORS = 0

  def byte_structure
    [
      [LENGTH, 4],
      [@width, 4],
      [@height, 4],
      [PLANES, 2],
      [BITS_PER_PIXEL, 2],
      [PIXEL_COMPRESSION, 4],
      [size_of_bitmap_data, 4],
      [PRINT_RESOLUTION, 4],
      [PRINT_RESOLUTION, 4],
      [NUMBER_OF_COLORS, 4],
      [IMPORTANT_COLORS, 4],
    ]
  end

end
