# unpack phone
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-16 original script
#   Stan Smith 2014-05-14 combine phone service types
#   Stan Smith 2014-12-09 return empty phone object if no phone number
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Phone

                    def self.unpack(hPhone, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        aPhones = Array.new

                        unless hPhone.empty?

                            # phone - name
                            phoneName = nil
                            if hPhone.has_key?('phoneName')
                                phoneName = hPhone['phoneName']
                            end

                            # phone - number
                            # return empty phone array if no phone number is provided
                            if hPhone.has_key?('phoneNumber')
                                phoneNum = hPhone['phoneNumber']
                                if phoneNum == ''
                                    return aPhones
                                end
                            else
                                return aPhones
                            end

                            # phone - service
                            # create a separate phone for each phone service type
                            # if service is missing, default service to 'voice'
                            if hPhone.has_key?('service')
                                aService = hPhone['service']
                            else
                                aService = ['voice']
                            end

                            if aService.empty?
                                aService = ['voice']
                            end

                            # if service is nil, default service to 'voice'
                            aService.each do |phService|
                                intPhone = intMetadataClass.newPhone

                                # phone - service
                                intPhone[:phoneServiceType] = phService
                                intPhone[:phoneName] = phoneName
                                intPhone[:phoneNumber] = phoneNum

                                aPhones << intPhone

                            end

                        end

                        return aPhones

                    end

                end

            end
        end
    end
end
