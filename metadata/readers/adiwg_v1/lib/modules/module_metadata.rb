# unpack metadata
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-22 original script
#   Stan Smith 2013-09-23 added distributor info section
#   Stan Smith 2013-11-26 added metadata maintenance section
#   Stan Smith 2013-11-26 added hierarchy section
#   Stan Smith 2013-11-26 added data quality section
#   Stan Smith 2013-12-27 added parent identifier
#   Stan Smith 2014-04-24 reorganized for json schema 0.3.0
#   Stan Smith 2014-05-02 added associated resources
#   Stan Smith 2014-05-02 added additional documentation

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_metadataInfo'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_resourceInfo'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_distributionInfo'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_associatedResource'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_citation'

module AdiwgV1Metadata

	def self.unpack(hMetadata)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intMetadata = intMetadataClass.newMetadata

		# metadata - metadataInfo
		if hMetadata.has_key?('metadataInfo')
			hMetadataInfo = hMetadata['metadataInfo']
			intMetadata[:metadataInfo] = AdiwgV1MetadataInfo.unpack(hMetadataInfo)
		end

		# metadata - resource identification info
		if hMetadata.has_key?('resourceInfo')
			hResourceInfo = hMetadata['resourceInfo']
			intMetadata[:resourceInfo] = AdiwgV1ResourceInfo.unpack(hResourceInfo)
		end

		# metadata - distribution info
		if hMetadata.has_key?('distributionInfo')
			aDistributors = hMetadata['distributionInfo']
			unless aDistributors.empty?
				aDistributors.each do |hDistributor|
					intMetadata[:distributorInfo] << AdiwgV1DistributionInfo.unpack(hDistributor)
				end
			end
		end

		# metadata - associated resources
		if hMetadata.has_key?('associatedResource')
			aAssocRes = hMetadata['associatedResource']
			unless aAssocRes.empty?
				aAssocRes.each do |hAssocRes|
					intMetadata[:associatedResources] << AdiwgV1AssociatedResource.unpack(hAssocRes)
				end
			end
		end

		# metadata - additional documents
		if hMetadata.has_key?('additionalDocumentation')
			aCitation = hMetadata['additionalDocumentation']
			unless aCitation.empty?
				aCitation.each do |hCitation|
					intMetadata[:additionalDocuments] << AdiwgV1Citation.unpack(hCitation)
				end
			end
		end

		return intMetadata

	end

end