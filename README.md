# QR Encoding via Ruby - with PNG output

Leveraging RQRCode and mojo_magick, we've built a very thin gem that generates QR codes in a png file

# Include in your project

In your 'Gemfile', add

    gem 'qr4r'

In your code, add
    
    require 'qr4r'

To use it
   
    string_to_encode = 'qr codes are the new hotness'
    Qr4r::encode(string_to_encode, 'qrcode.out.png')  


