# ISO <<Class>> MD_Keyword
# writer output in XML

# History:
# 	Stan Smith 2013-09-18 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-08-21 removed keyword thesaurus link; use citation onlineResource
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_codelist'
require_relative 'class_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Keywords

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hDKeyword)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)
                        citationClass = CI_Citation.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_Keywords') do

                            # keywords - keyword - required
                            aKeywords = hDKeyword[:keyword]
                            if aKeywords.empty?
                                @xml.tag!('gmd:keyword', {'gco:nilReason' => 'missing'})
                            else
                                aKeywords.each do |keyword|
                                    @xml.tag!('gmd:keyword') do
                                        @xml.tag!('gco:CharacterString', keyword)
                                    end
                                end
                            end

                            # keywords - type - MD_KeywordTypeCode
                            s = hDKeyword[:keywordType]
                            if !s.nil?
                                @xml.tag!('gmd:type') do
                                    codelistClass.writeXML('iso_keywordType',s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:type')
                            end

                            hKeyCitation = hDKeyword[:keyTheCitation]
                            if !hKeyCitation.empty?
                                @xml.tag!('gmd:thesaurusName') do
                                    citationClass.writeXML(hKeyCitation)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:thesaurusName')
                            end

                        end

                    end

                end

            end
        end
    end
end
