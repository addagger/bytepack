# Bytepack

### Tool for byte-serialization of various Ruby data structures

#### Packing & unpacking various Ruby data to/from a byte string, incl. arrays, hashes and custom data structures

## Compatibility

Compatible with Ruby **MRI 2.4**> & **JRuby 9.2**>

## Installation

    $ gem install bytepack

## Basic usage

Require Gem

    require 'bytepack'
    
Packing specific datatype returns a byteset:
    
    Bytepack::String.pack("test") # One argument as source value
    => "\x03\x04test"
     
Unpacking specific datatype returns an Array consists of Ruby object and resulted bytes offset as integer:

    bytes = Bytepack::String.pack("test")
    => "\x03\x04test"
    Bytepack::String.unpack(bytes) # Two arguments: byteset & offset as integer (optional)
    => ["test", 6]
    
Testing unpacking authenticity *(pack & unpack)*:

    Bytepack::String.testpacking("test")
    => ["test", 6]

## Ruby Standard Library basic datatypes

### Byte Integer

8-bit Integer in range [-127..127]

    Bytepack::Byte.pack(34)
    => "\""
    
    Bytepack::Byte.unpack("\"".b)
    => [34, 1]
    
8-bit Unsigned Integer in range [1..127]

    Bytepack::UByte.pack(34)
    => "\""

    Bytepack::UByte.unpack("\"".b)
    => [34, 1]
    
### Short Integer

16-bit Integer in range [-32767..32767]

    Bytepack::Short.pack(23423)
    => "[\x7F"
    
    Bytepack::Short.unpack("[\x7F".b)
    => [23423, 2]

16-bit Unsigned Integer in range [1..32767]

    Bytepack::UShort.pack(23423)
    => "[\x7F"
    
    Bytepack::UShort.unpack("[\x7F".b)
    => [23423, 2]       

### Integer

32-bit Integer in range [-2147483647..2147483647]

    Bytepack::Integer.pack(12323423)
    => "\x00\xBC\n_"
    
    Bytepack::Integer.unpack("\x00\xBC\n_".b)
    => [12323423, 4]
    
32-bit Unsigned Integer in range [1..2147483647]

    Bytepack::UInteger.pack(12323423)
    => "\x00\xBC\n_"
    
    Bytepack::UInteger.unpack("\x00\xBC\n_".b)
    => [12323423, 4]
    
### Long Integer

64-bit Integer in range [-9223372036854775807..9223372036854775807]

    Bytepack::Long.pack(98712323423)
    => "\x00\x00\x00\x16\xFB\xB6\x85_"
    
    Bytepack::Long.unpack("\x00\x00\x00\x16\xFB\xB6\x85_".b)
    => [98712323423, 8]
    
64-bit Unsigned Integer in range [1..9223372036854775807]

    Bytepack::ULong.pack(98712323423)
    => "\x00\x00\x00\x16\xFB\xB6\x85_"
    
    Bytepack::ULong.unpack("\x00\x00\x00\x16\xFB\xB6\x85_".b)
    => [98712323423, 8] 

### Various length Integer

128-bit Long Long signed Integer

    Bytepack::Basic.intToBytes(16, 2345980343453498712323423) # Two arguments: bytesize & value
    => "\x00\x00\x00\x00\x00\x01\xF0\xC7\xD9hbd>\f\xF5_"
    
    Bytepack::Basic.bytesToInt(16, "\x00\x00\x00\x00\x00\x01\xF0\xC7\xD9hbd>\f\xF5_".b) # Three arguments: bytesize, byteset, offset as integer (optional)
    => [2345980343453498712323423, 8]

### The shortest length Integer

Use universal **Bytepack::AnyType** class for that

    Bytepack::AnyType.pack(8934)
    => "\x04\"\xE6" # Packed as 1 meta-byte & 16-bit short Integer (total 3 bytes)
    
    Bytepack::AnyType.unpack("\x04\"\xE6".b)
    => [8934, 3]
    
### Float

    Bytepack::Float.pack(3.1415926)
    => "@\t!\xFBM\x12\xD8J"
    
    Bytepack::Float.unpack("@\t!\xFBM\x12\xD8J".b)
    => [3.1415926, 8]
  
### BigDecimal

    value = BigDecimal('3.1415926')
    => 0.31415926e1

    Bytepack::Decimal.pack(value)
    => "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\xDBu\x82\xCD\xC0"
    
    Bytepack::Decimal.unpack("\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\xDBu\x82\xCD\xC0".b)
    => [0.31415926e1, 16]

### NilClass

    Bytepack::Null.pack(nil)
    => "\x80"
    
    Bytepack::Null.unpack("\x80".b)
    => [nil, 1]

### String ASCII-8BIT encoded (Binary data)

Pack ASCII-8BIT encoded string:

    value = "\x04v\x1A\xE8wev\xD6".b

    Bytepack::Varbinary.pack(value)
    => "\x03\b\x04v\x1A\xE8wev\xD6" # includes 1 meta-byte, 1-8 bytes of value's length integer and a byteset of value
    
    Bytepack::Varbinary.unpack("\x03\b\x04v\x1A\xE8wev\xD6".b)
    => ["\x04v\x1A\xE8wev\xD6", 10]

By default, value's length serialized by *Byteset::AnyType* as a shortest integer possible (Byte, Short, Int or Long) and allways 2 bytes or more. You can override length datatype globally and make it static:

    Bytepack::Varbinary.config(:LENGTH_TYPE, Bytepack::Integer)
    value = "\x04v\x1A\xE8wev\xD6".b
    Bytepack::Varbinary.pack(value)
    => "\x00\x00\x00\b\x04v\x1A\xE8wev\xD6" # includes 1 meta-byte, 4 bytes of value's length and a byteset of value
    
Byteset size now is *2 bytes more*, but allways **4 bytes (32-bit)**. That's useful in cases where byteset length make sense in the current project.

### String UTF-8 encoded (Regular string)

Pack UTF-8 encoded string:

    Bytepack::String.pack("Words like violence")
    => "\x03\x13Words like violence" # includes 1 meta-byte, 1-8 bytes of value's length integer and a byteset of value
    
    Bytepack::String.unpack("\x03\x13Words like violence".b)
    => ["Words like violence", 21]

By default, value's length serialized the same way as *Bytepack::Varbinary*, but you can specify length datatype and make it static:

    Bytepack::String.config(:LENGTH_TYPE, Bytepack::Integer)
    Bytepack::String.pack("Words like violence")
    => "\x00\x00\x00\x13Words like violence" # includes 1 meta-byte, 4 bytes of value's length and a byteset of value

### Symbol

Works almost the same way as String serialization do:

    Bytepack::Symbol.pack(:key_this_value)
    => "\x03\x0Ekey_this_value" # includes 1 meta-byte, 1-8 bytes of value's length integer and a byteset of value
    
    Bytepack::Symbol.unpack("\x03\x0Ekey_this_value".b)
    => [:key_this_value, 18]

By default, value's length serialized the same way as *Bytepack::Varbinary*, but you can specify length datatype and make it static:

    Bytepack::Symbol.config(:LENGTH_TYPE, Bytepack::Integer)
    Bytepack::Symbol.pack(:key_this_value)
    => "\x00\x00\x00\x0Ekey_this_value" # includes 1 meta-byte, 4 bytes of value's length and a byteset of value

### Time

All objects are represented as *Bytepack::Long* values (64-bit). The signed integer represents the number of microseconds before or after Unix epoch (Jan. 1 1970 00:00:00 GMT).

    Bytepack::Timestamp.pack(Time.now)
    => "\x00\x05\x89\x02H\xF8\xDA\x9B"
    
    Bytepack::Timestamp.unpack("\x00\x05\x89\x02H\xF8\xDA\x9B".b)
    => [2019-05-16 17:43:10 +0300, 8]

## Arrays and hashes

Arrays can be serialized in two modes:

### Single Type Array

Arrays consists of elements belongs to one datatype:

    array = [1,2,3,4,5,6,4,3,2,123,3223,-23,0,12,89,100] # All elements are integers
    
You can pass specific datatype as the first array's element:

    byteset = Bytepack::SingleTypeArray.pack([Bytepack::Short, *array])
    => "\x04\x03\x10\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x04\x00\x03\x00\x02\x00{\f\x97\xFF\xE9\x00\x00\x00\f\x00Y\x00d"
    
    Bytepack::SingleTypeArray.unpack(byteset)
    => [[1, 2, 3, 4, 5, 6, 4, 3, 2, 123, 3223, -23, 0, 12, 89, 100], 35]
    
Or you wouldn't do it, it recognizes automatically by the longest integer:

    byteset = Bytepack::SingleTypeArray.pack(array)
    => "\x04\x03\x10\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x04\x00\x03\x00\x02\x00{\f\x97\xFF\xE9\x00\x00\x00\f\x00Y\x00d"
    
    Bytepack::SingleTypeArray.unpack(byteset)
    => [[1, 2, 3, 4, 5, 6, 4, 3, 2, 123, 3223, -23, 0, 12, 89, 100], 35]
  
By default, array's size serialized by *Byteset::AnyType* as a shortest integer possible (Byte, Short, Int or Long), you can override length datatype globally and make it static:

    Bytepack::SingleTypeArray.config(:LENGTH_TYPE, Bytepack::Byte)
    byteset = Bytepack::SingleTypeArray.pack(array)
    Bytepack::SingleTypeArray.unpack(byteset)
    => [[1, 2, 3, 4, 5, 6, 4, 3, 2, 123, 3223, -23, 0, 12, 89, 100], 34]

Byteset size now is **34** instead of **35**. Why, because in previous example length packed as *2-bytes Byteset::AnyType, including 1 meta-byte and 1 byte integer itself*. Setting explicitly the length type as *Byteset::Byte*, it just 1 byte. That's useful in cases where byteset length make sense in the current project.

### Various Type Array (Regular array)

Arrays consists of elements belongs to different datatypes:

    array = [1,2,"3",4,:"five",6,[7,8,9],10,123,3223,-23,0,12,89,100] # Chaos array
    
    byteset = Bytepack::Array.pack(array)
    => "\x03\x0F\x03\x01\x03\x02\t\x03\x013\x03\x04\n\x03\x04five\x03\x06\x9E\x03\x03\a\b\t\x03\n\x03{\x04\f\x97\x03\xE9\x03\x00\x03\f\x03Y\x03d"
    
    Bytepack::Array.unpack(byteset)
    => [[1, 2, "3", 4, :five, 6, [7, 8, 9], 10, 123, 3223, -23, 0, 12, 89, 100], 44]
  
By default, array's size serialized by *Byteset::AnyType* as a shortest integer possible (Byte, Short, Int or Long), you can override length datatype globally and make it static:

    Bytepack::Array.config(:LENGTH_TYPE, Bytepack::Byte)
    byteset = Bytepack::Array.pack(array)
    Bytepack::Array.unpack(byteset)
    => [[1, 2, "3", 4, :five, 6, [7, 8, 9], 10, 123, 3223, -23, 0, 12, 89, 100], 43]

Byteset size now is **43** instead of **44**.

### Hash

Technically Hash serialized as two arrays: keys and values. Serialization uses length types of current *Array and SingleTypeArray* settings. Let's say we have mashed hash.

    hash = {:key1 => 1, :key2 => "2", "key3" => "key3", :key4 => 4, :key5 => :key5, :array => [1,2,3,"text",:sym, {:nil => nil, :foo => "bar"}]}
    byteset = Bytepack::Hash.pack(hash)
    => "\x9D\x06\n\x03\x04key1\n\x03\x04key2\t\x03\x04key3\n\x03\x04key4\n\x03\x04key5\n\x03\x05array\x9D\x06\x03\x01\t\x03\x012\t\x03\x04key3\x03\x04\n\x03\x04key5\x9D\x06\x03\x01\x03\x02\x03\x03\t\x03\x04text\n\x03\x03sym\xA7\x9E\n\x02\x03\x03nil\x03\x03foo\x9D\x02\x01\x80\t\x03\x03bar"

Hash serialized into 114 bytes. Not, recover it:
    
    Bytepack::Hash.unpack(byteset)
    => [{:key1=>1, :key2=>"2", "key3"=>"key3", :key4=>4, :key5=>:key5, :array=>[1, 2, 3, "text", :sym, {:nil=>nil, :foo=>"bar"}]}, 114]

## Custom datatypes

Of course, not all available data structures are implemented out of the box. You can serialize any type of data and do it in a shorter way than *Marshal* does. For these purposes, use **Bytepack::CustomData**.

1) Create class inherited from **Bytepack::CustomData** class.
2) Class must include constant **TYPE_CODE** as a Byte integer [-127..127]. Value must be unique and not in the list of *Bytepack::TypeInfo.codes.keys* (reserved by Gem itselt)
3) Class must include constant **RUBY_TYPE** as a class in available namespace.
4) Like all OOB structures class must include the class method **pack()** which accepts one required argument as input value. Method returns the byteset as a result of serialization.
5) Like all OOB structures class must include the class method **unpack()** which accepts one required and one optional arguments:
- byteset as a *String* object;
- offset as an *Integer* object (optional, default=0).
The **unpack()** method returns two element array, where the first element is deserialized Ruby object and the second one is resulted offset. The return offset must be correct! For what every Gem's structures returns the same dataset when unpacking.

Example of serialization of **ActiveSupport::Duration** objects:

    class DurationBytePack < Bytepack::CustomData
      TYPE_CODE = 26
      RUBY_TYPE = ActiveSupport::Duration
      
      DIRECTIVE = 'cl>'  
      DURATION_PARTS = [:years, :months, :weeks, :days, :hours, :minutes, :seconds] # see ActiveSupport::Duration

      class << self
        def pack(val)
          parts = val.parts
          format = DIRECTIVE * parts.size
          Bytepack::Byte.pack(parts.size) + parts.map {|part| [DURATION_PARTS.find_index(part[0]), part[1]]}.flatten.pack(format)
        end
    
        def unpack(bytes, offset = 0)
          length, offset = *Bytepack::Byte.unpack(bytes, offset)
          unpacked = bytes.unpack("@#{offset}#{"cl>"*length}").each_slice(2).sum do |idx, value|
            offset += 5
            value.send(DURATION_PARTS[idx])
          end
          [unpacked, offset]
        end

      end
    end
    
Try it now in the Rails console:

    DurationBytePack.pack(3.days)
    => "\x01\x03\x00\x00\x00\x03"
    
    DurationBytePack.unpack("\x01\x03\x00\x00\x00\x03".b)
    => [3 days, 6]
    
    Bytepack::Array.pack([1,2,3,4,5.days])
    => "\x00\x05\x03\x01\x03\x02\x03\x03\x03\x04\x1A\x01\x03\x00\x00\x00\x05"
    
    Bytepack::Array.unpack("\x00\x05\x03\x01\x03\x02\x03\x03\x03\x04\x1A\x01\x03\x00\x00\x00\x05".b)
    => [[1, 2, 3, 4, 5 days], 17]
