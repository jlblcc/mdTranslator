# unpack point
# point is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-07 original script
#   Stan Smith 2014-04-30 reorganized for json schema 0.3.0
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-07-16 moved module_coordinates from mdJson reader to internal

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Point

                    def self.unpack(aCoords, geoType, responseObj)
                        intMetadataClass = InternalMetadata.new
                        intPoint = intMetadataClass.newGeometry

                        intPoint[:geoType] = geoType
                        intPoint[:geometry] = aCoords
                        intPoint[:dimension] = AdiwgCoordinates.getDimension(aCoords)

                        return intPoint
                    end

                end

            end
        end
    end
end
