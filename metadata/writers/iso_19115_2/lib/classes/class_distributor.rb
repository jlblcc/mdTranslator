# ISO <<Class>> MD_Distributor
# writer output in XML

# History:
# 	Stan Smith 2013-09-25 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_responsibleParty'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_standardOrderProcess'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_format'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_digitalTransferOptions'

class MD_Distributor

	def initialize(xml)
		@xml = xml
	end

	def writeXML(distributor)

		# classes used
		rPartyClass = CI_ResponsibleParty.new(@xml)
		sOrderProcClass = MD_StandardOrderProcess.new(@xml)
		rFormatClass = MD_Format.new(@xml)
		dTranOptClass = MD_DigitalTransferOptions.new(@xml)

		@xml.tag!('gmd:MD_Distributor') do

			# distributor - distributor contact - CI_ResponsibleParty - required
			hResParty = distributor[:distContact]
			if hResParty.empty?
				@xml.tag!('gmd:distributorContact', {'gco:nilReason' => 'missing'})
			else
				@xml.tag!('gmd:distributorContact') do
					rPartyClass.writeXML(hResParty)
				end
			end

			# distributor - distribution order process []
			aDistOrderProc = distributor[:distOrderProc]
			if !aDistOrderProc.empty?
				aDistOrderProc.each do |distOrder|
					@xml.tag!('gmd:distributionOrderProcess') do
						sOrderProcClass.writeXML(distOrder)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:distributionOrderProcess')
			end

			# distributor - distributor format []
			aDistFormats = distributor[:distFormat]
			if !aDistFormats.empty?
				aDistFormats.each do |dFormat|
					@xml.tag!('gmd:distributorFormat') do
						rFormatClass.writeXML(dFormat)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:distributorFormat')
			end

			# distributor - distributor transfer options []
			aDistTransOpts = distributor[:distTransOption]
			if !aDistTransOpts.empty?
				aDistTransOpts.each do |dTransOpt|
					@xml.tag!('gmd:distributorTransferOptions') do
						dTranOptClass.writeXML(dTransOpt)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:distributorTransferOptions')
			end


		end

	end

end