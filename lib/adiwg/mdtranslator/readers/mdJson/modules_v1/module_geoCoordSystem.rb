# unpack GeoJSON properties
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-04-30 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeoCoordSystem

                    def self.unpack(hGeoCrs, intElement, responseObj)

                        intMetadataClass = InternalMetadata.new
                        intSRS = intMetadataClass.newSRS

                        # get coordinate reference system
                        # null crs will default to CRS84 in writer
                        if hGeoCrs.has_key?('properties')
                            hCRSProp = hGeoCrs['properties']

                            if hCRSProp.has_key?('name')
                                s = hCRSProp['name']
                                if s != ''
                                    intSRS[:srsName] = s
                                end
                            end

                            if hCRSProp.has_key?('href')
                                s = hCRSProp['href']
                                if s != ''
                                    intSRS[:srsHref] = s
                                end
                            end

                            if hCRSProp.has_key?('type')
                                s = hCRSProp['type']
                                if s != ''
                                    intSRS[:srsType] = s
                                end
                            end

                            intElement[:elementSrs] = intSRS

                        end

                    end

                end

            end
        end
    end
end
