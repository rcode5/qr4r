# QR Encoding via Ruby - with PNG output

Leveraging [rqrcode](http://whomwah.github.com/rqrcode/) and [mojo_magick](http://github.com/2rye/mojo_magick), we've built a very thin gem that generates QR codes in a png file

# Include in your project

In your 'Gemfile', add

    gem 'qr4r'

In your code, add
    
    require 'qr4r'

NOTE: you'll need to have ImageMagick installed wherever you plan to run this.  The gem depends on [mojo_magick](http://github.com/2rye/mojo_magick) which uses ImageMagick commandline operations to build the final PNG image.

To use it:

    Qr4r::encode(input_string, output_file_path, options)

*input_string* and *output_file_path* should be strings.  Options should a list of hash options keyed by symbols.  Possible options are:
 
 * :pixel_size  - specify the size of each 'black' dot in the qrcode.  Default = 3
 * :border - specify the number of pixels to use for a white border around the outside.  Default = 0
 * :size  - used by the qr code generation.  A lower number means a smaller overall image.  But it also means that you can encode fewer characters.  This is computeed for you by default based on the input string size.  You should not need to adjust it.

To encode the string 'qr codes are the new hotness' like this:

    require 'qr4r'
    s = 'qr codes are the new hotness'
    fname = s.gsub(/\s+/,"_") + ".qr.png"
    Qr4r::encode(s, fname)

Make a bigger QRCode

    s = 'big qr codes are the new hotness'
    fname = s.gsub(/\s+/,"_") + ".qr.png"
    Qr4r::encode(s, fname, :pixel_size => 5)

Add a fat border

    s = 'big qr codes are the new hotness with a border'
    fname = s.gsub(/\s+/,"_") + ".qr.png"
    Qr4r::encode(s, fname, :border => 20)


## Authors

Original author: [Jon Rogers](http://github.com/bunnymatic) [at 2rye](http://2rye.com)

Thanks to [Duncan Robertson](http://whomwah.github.com/rqrcode/) for writing rQRCode

## Contributing
* Fork the project
* Write a test for your new feature/method
* Send a pull request
* Don't bump the version or modify the gemspec. I'll do that when I merge in your mods and release a new version.

## Copyright

MIT Licence (http://www.opensource.org/licenses/mit-license.html)
