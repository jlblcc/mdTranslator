# ISO <<Class>> MD_TaxonCl
# writer output in XML

# History:
# 	Stan Smith 2013-11-19 original script.
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_TaxonCl

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(aTaxonCl)

                        # take first element in array
                        hTaxonCl = aTaxonCl[0]

                        @xml.tag!('gmd:MD_TaxonCl') do

                            # taxon classification - common name
                            s = hTaxonCl[:commonName]
                            if !s.nil?
                                @xml.tag!('gmd:common') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:common')
                            end

                            # taxon classification - taxon rank name - required
                            s = hTaxonCl[:taxRankName]
                            if s.nil?
                                @xml.tag!('gmd:taxonrn', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:taxonrn') do
                                    @xml.tag!('gco:CharacterString', s)
                                end

                            end

                            # taxon classification - taxon rank value - required
                            s = hTaxonCl[:taxRankValue]
                            if s.nil?
                                @xml.tag!('gmd:taxonrv', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:taxonrv') do
                                    @xml.tag!('gco:CharacterString', s)
                                end

                            end

                            # taxon classification - classification - recursive
                            aTaxonCl.slice!(0)
                            unless aTaxonCl.empty?
                                @xml.tag!('gmd:taxonCl') do
                                    writeXML(aTaxonCl)
                                end
                            end

                        end


                    end

                end

            end
        end
    end
end
