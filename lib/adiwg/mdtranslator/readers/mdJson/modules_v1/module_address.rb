# unpack address
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-10-21 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-19 prevented passing blank deliveryPoints and
#   ... electronicMailAddresses into internal object
#   Stan Smith 2014-12-30 refactored
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Address

                    def self.unpack(hConAddress, responseObj)

                        # return nil object if input is empty
                        intAdd = nil
                        return if hConAddress.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAdd = intMetadataClass.newAddress

                        # address - delivery point
                        if hConAddress.has_key?('deliveryPoint')
                            aDevPoint = hConAddress['deliveryPoint']
                            aDevPoint.each do |addLine|
                                if addLine != ''
                                    intAdd[:deliveryPoints] << addLine
                                end
                            end
                        end

                        # address - city
                        if hConAddress.has_key?('city')
                            s = hConAddress['city']
                            if s != ''
                                intAdd[:city] = s
                            end
                        end

                        # address - admin area
                        if hConAddress.has_key?('administrativeArea')
                            s = hConAddress['administrativeArea']
                            if s != ''
                                intAdd[:adminArea] = s
                            end
                        end

                        # address - postal code
                        if hConAddress.has_key?('postalCode')
                            s = hConAddress['postalCode']
                            if s != ''
                                intAdd[:postalCode] = s
                            end
                        end

                        # address - country
                        if hConAddress.has_key?('country')
                            s = hConAddress['country']
                            if s != ''
                                intAdd[:country] = s
                            end
                        end

                        # address - email
                        if hConAddress.has_key?('electronicMailAddress')
                            eMailList = hConAddress['electronicMailAddress']
                            eMailList.each do |email|
                                if email != ''
                                    intAdd[:eMailList] << email
                                end
                            end
                        end

                        return intAdd
                    end

                end

            end
        end
    end
end

