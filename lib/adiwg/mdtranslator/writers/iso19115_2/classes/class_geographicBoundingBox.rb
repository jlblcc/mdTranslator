# ISO <<Class>> EX_GeographicBoundingBox
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script
#   Stan Smith 2014-05-30 hElement attributes changed for version 0.5.0
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class EX_GeographicBoundingBox

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hElement)

                        extentType = hElement[:elementIncludeData]
                        hBBox = hElement[:elementGeometry][:geometry]

                        @xml.tag!('gmd:EX_GeographicBoundingBox') do

                            # bounding box - extent type - required
                            if extentType.nil?
                                @xml.tag!('gmd:extentTypeCode', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:extentTypeCode') do
                                    @xml.tag!('gco:Boolean', extentType)
                                end
                            end

                            # bounding box - west longitude - required
                            s = hBBox[:westLong]
                            if s.nil?
                                @xml.tag!('gmd:westBoundLongitude', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:westBoundLongitude') do
                                    @xml.tag!('gco:Decimal', s)
                                end
                            end

                            # bounding box - east longitude - required
                            s = hBBox[:eastLong]
                            if s.nil?
                                @xml.tag!('gmd:eastBoundLongitude', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:eastBoundLongitude') do
                                    @xml.tag!('gco:Decimal', s)
                                end
                            end

                            # bounding box - south latitude - required
                            s = hBBox[:southLat]
                            if s.nil?
                                @xml.tag!('gmd:southBoundLatitude', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:southBoundLatitude') do
                                    @xml.tag!('gco:Decimal', s)
                                end
                            end

                            # bounding box - north latitude - required
                            s = hBBox[:northLat]
                            if s.nil?
                                @xml.tag!('gmd:northBoundLatitude', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:northBoundLatitude') do
                                    @xml.tag!('gco:Decimal', s)
                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
