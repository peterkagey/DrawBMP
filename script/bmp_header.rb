require_relative 'bmp_base'

class BMPHeader < BMPBase

  HEADER = "BM"
  OFFSET = 54

  def file_size
    size_of_bitmap_data + OFFSET
  end

  def byte_structure
    [
      HEADER,
      [file_size, 4],
      [0, 2],
      [0, 2],
      [OFFSET, 4]
    ]
  end

end
