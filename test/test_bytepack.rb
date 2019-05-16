require 'minitest/autorun'
require 'bytepack'

class TestBytepack < Minitest::Test
  
  # Packing: ANY TYPE DATA STRUCTURES
  
  def test_packing_anytype
    data = [1, 2, 3.14, "4", 5, BigDecimal('6'), 7, 8, 9, 32000]
    assert_equal data, Bytepack::AnyType.testpacking(data)[0]
  end
  
  # Packing: FIXED SIZE DATA STRUCTURES
  
  def test_packing_byte
    assert_equal (-1), Bytepack::Byte.testpacking(-1)[0]
    assert_nil Bytepack::Byte.testpacking(nil)[0]
  end
  
  def test_packing_short
    assert_equal (-1), Bytepack::Short.testpacking(-1)[0]
    assert_nil Bytepack::Short.testpacking(nil)[0]
  end
  
  def test_packing_integer
    assert_equal (-1), Bytepack::Integer.testpacking(-1)[0]
    assert_nil Bytepack::Integer.testpacking(nil)[0]
  end
  
  def test_packing_long
    assert_equal (-1), Bytepack::Long.testpacking(-1)[0]
    assert_nil Bytepack::Long.testpacking(nil)[0]
  end
  
  def test_packing_ubyte
    assert_equal 1, Bytepack::UByte.testpacking(1)[0]
    assert_nil Bytepack::UByte.testpacking(nil)[0]
  end
  
  def test_packing_ushort
    assert_equal 1, Bytepack::UShort.testpacking(1)[0]
    assert_nil Bytepack::UShort.testpacking(nil)[0]
  end
  
  def test_packing_uinteger
    assert_equal 1, Bytepack::UInteger.testpacking(1)[0]
    assert_nil Bytepack::UInteger.testpacking(nil)[0]
  end
  
  def test_packing_ulong
    assert_equal 1, Bytepack::ULong.testpacking(1)[0]
    assert_nil Bytepack::ULong.testpacking(nil)[0]
  end
  
  def test_packing_float
    assert_equal 3.14, Bytepack::Float.testpacking(3.14)[0]
    assert_nil Bytepack::Float.testpacking(nil)[0]
  end
  
  def test_packing_decimal
    assert_equal BigDecimal("-1234.56789"), Bytepack::Decimal.testpacking("-1234.56789")[0]
    assert_nil Bytepack::Decimal.testpacking(nil)[0]
  end
  
  def test_packing_null
    assert_nil Bytepack::Null.testpacking(nil)[0]
  end
  
  def test_packing_timestamp
    time = Time.now
    assert_equal time.to_i, Bytepack::Timestamp.testpacking(time)[0].to_i
    assert_nil Bytepack::Timestamp.testpacking(nil)[0]
  end
  
  # Packing: VARIABLE SIZE DATA STRUCTURES
  
  def test_packing_varbinary
    assert_equal "Test string".b, Bytepack::Varbinary.testpacking("Test string")[0]
    assert_equal "".b, Bytepack::Varbinary.testpacking("")[0]
    assert_nil Bytepack::Varbinary.testpacking(nil)[0]
  end
  
  def test_packing_string
    assert_equal "Test string", Bytepack::String.testpacking("Test string")[0]
    assert_equal "", Bytepack::String.testpacking("")[0]
    assert_nil Bytepack::String.testpacking(nil)[0]
  end
  
  def test_packing_symbol
    assert_equal :"Test_symbol", Bytepack::Symbol.testpacking(:"Test_symbol")[0]
    assert_nil Bytepack::Symbol.testpacking(nil)[0]
  end
  
  # Packing: COMPOUND (SINGLE TYPE ARRAY) DATA STRUCTURE
  
  def test_packing_single_type_array
    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 32000]
    assert_equal array, Bytepack::SingleTypeArray.testpacking(array)[0]
  end
  
  # Packing: COMPLEX DATA STRUCTURE
  
  def test_packing_array
    array = [1, :two, 3, "four", 5, "6", 7, 8, 9, 32000]
    assert_equal array, Bytepack::Array.testpacking(array)[0]
  end
  
  def test_packing_hash
    hash = {:key1 => 1, :key2 => "2", :key3 => "key3", :key4 => 4, :key5 => :key5}
    assert_equal hash, Bytepack::Hash.testpacking(hash)[0]
  end
  
end