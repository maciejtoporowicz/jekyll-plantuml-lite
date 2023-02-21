require "zlib"

class Encoder 
    MAPPING_ARRAY = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz|_"
    RAW_DEFLATE = -Zlib::MAX_WBITS
    
    def encode(plantuml_content)
        compressed = Zlib::Deflate.new(Zlib::BEST_COMPRESSION, RAW_DEFLATE).deflate(plantuml_content, Zlib::FINISH)
        bytes = compressed.bytes

        current_index = 0
        result = ""

        while(current_index < bytes.length)
            result += encode_three_bytes(
                bytes[current_index].to_i, 
                bytes[current_index+1].to_i, 
                bytes[current_index+2].to_i
            )
            current_index += 3
        end
        
        return result
    end

    private

    #
    # Three bytes get divided into sextets and their decimal representation is the index
    # of the character in the MAPPING_ARRAY.
    #
    # | Byte            | 77                            | 97                            | 110                           |
    # | Bits            | 0	| 1	| 0 | 0 | 1 | 1 | 0 | 1 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 0 | 1 | 1 | 1 | 0 |
    # | Sextet value    | 19                    | 22                    | 5                     | 46                    |
    # | Mapping array   | J                     | M                     | 5                     | k                     |
    #
    def encode_three_bytes(byte_1, byte_2, byte_3)
        sextet_1 = byte_1 >> 2
        sextet_2 = (((byte_1 & 0b00000011) << 4) | ((byte_2 & 0b11110000) >> 4))
        sextet_3 = ((byte_2 & 0b00001111) << 2) | ((byte_3 & 0b11000000) >> 6)
        sextet_4 = byte_3 & 0b00111111

        result = ""
        result += MAPPING_ARRAY[sextet_1]
        result += MAPPING_ARRAY[sextet_2]
        result += MAPPING_ARRAY[sextet_3]
        result += MAPPING_ARRAY[sextet_4]
        return result
    end
end