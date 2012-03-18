require 'rqrcode'
require 'mojo_magick'
module Qr4r

  # params we pass to QRCode include :size and :level
  #   size   - the size of the qrcode (default 4)
  #   level  - the error correction level, can be:
  #      * Level :l 7%  of code can be restored
  #      * Level :m 15% of code can be restored
  #      * Level :q 25% of code can be restored
  #      * Level :h 30% of code can be restored
  # note: if size is not included and 4 appears to be too small for the included string, we'll make it bigger
  #       if you include size, we'll use it, which may lead to an error if the string is too long
  # Limitations are as follows:
  #   size = 1, max string length = 7
  #   size = 2, max string length = 14
  #   size = 3, max string length = 24
  #   size = 4, max string length = 34
  #   size = 5, max string length = 44
  #   size = 6, max string length = 58
  #   size = 7, max string length = 64
  #   size = 8, max string length = 84
  #   size = 9, max string length = 98
  #   size = 10, max string length = 119

  def self.encode(str, outfile, *rest)
    opts = rest[0] if rest && rest.length > 0
    if !opts || (opts && !opts[:size])
      opts = {}.merge(opts || {}).merge({:size => compute_size(str)})
    end
    qr = RQRCode::QRCode.new(str, opts)
    data = []
    qr.modules.each_index do |x|
      qr.modules.each_index do |y|
        if qr.dark?(x,y)
          3.times { data << 0 }
        else
          3.times { data << 255 }
        end
      end
    end
    MojoMagick::convert do |c|
      d = data.pack 'C'*data.size
      c.blob(d, :format => :rgb, :depth => 8, :size => ("%dx%d" % [qr.modules.size, qr.modules.size]))
      c.file outfile
    end
  end

  private
  SIZE_RESTRICTIONS = [0, 7, 14, 24, 34, 44, 58, 64, 84, 98, 119] 

  def self.compute_size(str)
    slen = str.size
    size = 4
    ii = 0
    while ii < SIZE_RESTRICTIONS.length do
      if slen < SIZE_RESTRICTIONS[ii]
        break
      end
      ii+=1
    end
    if ii > 10
      raise "Your string is too big for this encoder.  It should be less than #{SIZE_RESTRICTIONS.last} characters"
    end
    return ii
  end
end
