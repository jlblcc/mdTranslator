# MdTranslator - minitest of
# reader / mdJson / module_medium

# History:
# Stan Smith 2015-08-24 original script

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.2.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_medium'

class TestReaderMdJsonMedium_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Medium
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'distributor.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]['distributorTransferOptions'][0]['offline']

    def test_complete_medium_object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:mediumType],   'name1'
        assert_equal metadata[:mediumFormat], 'mediumFormat1'
        assert_equal metadata[:mediumNote],   'mediumNote1'
    end

    def test_empty_medium_elements
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['name'] = ''
        hIn['mediumFormat'] = ''
        hIn['mediumNote'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:mediumType]
        assert_nil metadata[:mediumFormat]
        assert_nil metadata[:mediumNote]
    end

    def test_missing_medium_elements_a
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('name')
        hIn.delete('mediumFormat')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:mediumType]
        assert_nil metadata[:mediumFormat]
    end

    def test_missing_medium_elements_b
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('mediumNote')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:mediumNote]
    end

    def test_empty_medium_object
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
    end

end
