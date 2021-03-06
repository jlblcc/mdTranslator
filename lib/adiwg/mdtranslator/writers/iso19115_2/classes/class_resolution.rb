# ISO <<Class>> MD_Resolution
# writer output in XML

# History:
# 	Stan Smith 2013-11-19 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Resolution

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hResolution)

                        @xml.tag!('gmd:MD_Resolution') do

                            # resolution - specific equivalent scale
                            # resolution - distance
                            # one or the other is required, but not both
                            scale = hResolution[:equivalentScale]
                            distance = hResolution[:distance]
                            uom = hResolution[:distanceUOM]
                            if !scale.nil?
                                @xml.tag!('gmd:equivalentScale') do
                                    @xml.tag!('gmd:MD_RepresentativeFraction') do
                                        @xml.tag!('gmd:denominator') do
                                            @xml.tag!('gco:Integer', scale)
                                        end
                                    end
                                end
                            elsif !distance.nil?
                                @xml.tag!('gmd:distance') do
                                    attributes = {}
                                    attributes['uom'] = uom if uom
                                    @xml.tag!('gco:Distance', attributes, distance)
                                end
                            else
                                @xml.tag!('gmd:equivalentScale', {'gco:nilReason' => 'missing'})
                                @xml.tag!('gmd:distance', {'gco:nilReason' => 'missing'})
                            end

                        end

                    end

                end

            end
        end
    end
end
