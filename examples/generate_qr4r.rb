#!/usr/bin/env ruby

require "qr4r"
require "optparse"
require "ostruct"

class CmdlineOpts
  @opts = nil

  ALLOWED_FORMATS = %w[jpg jpeg gif tif tiff png].freeze

  attr_reader :options

  def initialize(args)
    @options = OpenStruct.new
    @options.format = "gif"
    @options.border = 0
    @options.pixel_size = 10
    @options.verbose = false

    @opts = setup_options

    @opts.parse!(args)
  end

  # rubocop:disable Metrics/MethodLength
  def setup_options
    OptionParser.new do |opts|
      opts.banner = "Usage: $0 [options] outfile the stuff to encode"

      opts.separator ""

      # Mandatory argument.
      opts.on("-f",
              "--format FILE_FORMAT",
              ALLOWED_FORMATS,
              "Output qrcode image format (default: gif)",
              " (#{ALLOWED_FORMATS.join ", "})") do |fmt|
        @options.format = fmt
      end
      opts.on("-b", "--border N",
              "Render with a border of this size") do |border|
        @options.border = border.to_i
      end
      opts.on("-p", "--pixelsize N",
              "Size for each qrcode pixel") do |px|
        @options.pixel_size = px.to_i
      end
      opts.on("-v", "--[no-]verbose", "Be verbose") do |_v|
        @options.verbose = V
      end

      # No argument, shows at tail.  This will print an options summary.
      # Try it and see!
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
      opts
    end
    # rubocop:enable Metrics/MethodLength
  end

  def help
    puts @opts
  end
end

cmd_options = CmdlineOpts.new(ARGV)

if ARGV.length < 2
  cmd_options.help
else
  outfile = ARGV.shift
  to_encode = ARGV.join " "
  options = cmd_options.options

  if options.verbose
    print "Encoding \"#{to_encode}\" to file #{outfile}"
    print " with border #{options.border}"  if options.border.positive?
    print " and pixel_size #{options.pixel_size}"
    puts " and format #{options.format}"
  end

  Qr4r.encode(to_encode, outfile, cmd_options.options.marshal_dump)
end
