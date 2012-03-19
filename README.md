# QR Encoding via Ruby - with PNG output

Leveraging [rqrcode](http://whomwah.github.com/rqrcode/) and [mojo_magick](http://github.com/2rye/mojo_magick), we've built a very thin gem that generates QR codes in a png file

# Include in your project

In your 'Gemfile', add

    gem 'qr4r'

In your code, add
    
    require 'qr4r'

To use it:

    Qr4r::encode(input_string, output_file_path, options)

*input_string* and *output_file_path* should be strings.  Options should a list of hash options keyed by symbols.  Possible options are:
 
 * :pixel_size  - this is used to specify the size of each 'black' dot in the qrcode.  Default = 3
 * :size  - this is used by the qr code generation.  A lower number means a smaller overall image.  But it also means that you can encode fewer characters.  This is computeed for you by default based on the input string size.  You should not need to adjust it.

To encode the string 'qr codes are the new hotness' like this:
  
    string_to_encode = 'qr codes are the new hotness'
    Qr4r::encode(string_to_encode, 'qrcode.out.png')  

Not happy with the default size (99px x 99px)? Adjust the size with the 3rd argument to encode

    # the following produces an image who's size is 165px x 165px
    string_to_encode = 'big qr codes are the new hotness'
    Qr4r::encode(string_to_encode, 'qrcode.out.png', :pixel_size => 5)  



