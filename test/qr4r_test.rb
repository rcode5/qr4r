require 'test/unit'
require File::expand_path(File::join(File::dirname(__FILE__), '..', 'init'))

class Qr4rTest < Test::Unit::TestCase

  def test_image_management
    # do something
    Qr4r::encode('whatever yo', 'qr.png')
    # assert that it worked
    assert File.exists?('qr.png')
  end

end
