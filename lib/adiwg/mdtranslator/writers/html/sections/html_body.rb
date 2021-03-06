# HTML writer
# html body

# History:
# 	Stan Smith 2015-03-23 original script
#   Stan Smith 2014-04-10 add open and close buttons
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#   Stan Smith 2015-07-20 moved mdTranslator logo to html_inlineCss.css

require_relative 'html_metadataInfo'
require_relative 'html_resourceInfo'
require_relative 'html_dataDictionary'
require_relative 'html_distributor'
require_relative 'html_associatedResource'
require_relative 'html_additionalDocumentation'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlBody
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(intObj)
                        @html.body do

                            # classes used
                            htmlMetaInfo = MdHtmlMetadataInfo.new(@html)
                            htmlResInfo = MdHtmlResourceInfo.new(@html)
                            htmlDataD = MdHtmlDataDictionary.new(@html)
                            htmlDist = MdHtmlDistributor.new(@html)
                            htmlAssRes = MdHtmlAssociatedResource.new(@html)
                            htmlAddDoc = MdHtmlAdditionalDocumentation.new(@html)

                            # make sections of the internal data store more accessible
                            hMetadata = intObj[:metadata]
                            aDataDict = intObj[:dataDictionary]

                            hMetaInfo = intObj[:metadata][:metadataInfo]
                            aDistributor = intObj[:metadata][:distributorInfo]
                            aAssRes = intObj[:metadata][:associatedResources]
                            aAddDocs = intObj[:metadata][:additionalDocuments]

                            # set page title and logo
                            # side navigation
                            @html.div('id'=>'sideNav') do
                            # add top anchor and button
                              @html.a(' Top', {'href'=>'#', 'class'=>'btn icon-caret-up'})

                              # add open and close buttons
                              @html.span(' Open',{'id'=>'openAllDetails', 'class'=>'btn icon-caret-down', 'onclick'=>'openAllDetails();'})
                              @html.span(' Close',{'class'=>'btn icon-caret-right', 'onclick'=>'closeAllDetails();'})
                            end

                            # main header
                            @html.h2('id'=>'mainHeader') do
                                # added blank to span tag to force builder to create closing tag
                                @html.span('','id'=>'logo')
                                @html.span('Metadata Report')
                                @html.span('HTML','class'=>'version')
                            end

                            # report title
                            @html.h1('mdTranslator Metadata Report', 'id'=>'mdtranslator-metadata-report')

                            # section index
                            @html.section(:class=>'block') do
                                @html.h3('Page Index')
                                @html.a('Metadata Information Section','href'=>'#metadataInfo')
                                @html.section(:class=>'block') do
                                    if !hMetaInfo.empty?
                                        unless hMetaInfo[:metadataId].empty?
                                            @html.a('Metadata Identifier', 'href'=>'#metadata-identifier')
                                            @html.br
                                        end
                                        @html.a('Metadata Record Information', 'href'=>'#metadata-recordInfo')
                                        unless hMetaInfo[:parentMetadata].empty?
                                            @html.br
                                            @html.a('Parent Metadata Citation', 'href'=>'#metadata-parentInfo')
                                        end
                                    end
                                end
                                @html.a('Resource Information Section','href'=>'#resourceInfo')
                                @html.section(:class=>'block') do
                                    @html.a('Resource Identification', 'href'=>'#resourceInfo-general')
                                    @html.br
                                    @html.a('Contacts', 'href'=>'#resourceInfo-contacts')
                                    unless hMetadata[:resourceInfo][:descriptiveKeywords].empty?
                                        @html.br
                                        @html.a('Keywords', 'href'=>'#resourceInfo-keywords')
                                    end
                                    unless hMetadata[:resourceInfo][:taxonomy].empty?
                                        @html.br
                                        @html.a('Taxonomy', 'href'=>'#resourceInfo-taxonomy')
                                    end
                                    unless hMetadata[:resourceInfo][:spatialReferenceSystem].empty? &&
                                        hMetadata[:resourceInfo][:spatialRepresentationTypes].empty? &&
                                        hMetadata[:resourceInfo][:spatialResolutions].empty?
                                        @html.br
                                        @html.a('Spatial Reference', 'href'=>'#resourceInfo-spatialRef')
                                    end
                                    unless hMetadata[:resourceInfo][:extents].empty?
                                        @html.br
                                        @html.a('Extents (Geographic, Temporal, & Vertical Space)', 'href'=>'#resourceInfo-extents')
                                    end
                                    unless hMetadata[:resourceInfo][:gridInfo].empty?
                                        @html.br
                                        @html.a('Grid Information', 'href'=>'#resourceInfo-gridInfo')
                                    end
                                    unless hMetadata[:resourceInfo][:coverageInfo].empty?
                                        @html.br
                                        @html.a('Coverage Information', 'href'=>'#resourceInfo-coverageInfo')
                                    end
                                    unless hMetadata[:resourceInfo][:dataQualityInfo].empty?
                                        @html.br
                                        @html.a('Data Quality', 'href'=>'#resourceInfo-dataQuality')
                                    end
                                    unless hMetadata[:resourceInfo][:useConstraints].empty? &&
                                        hMetadata[:resourceInfo][:legalConstraints].empty? &&
                                        hMetadata[:resourceInfo][:securityConstraints].empty?
                                        @html.br
                                        @html.a('Constraints', 'href'=>'#resourceInfo-constraints')
                                    end
                                    unless hMetadata[:resourceInfo][:resourceMaint].empty?
                                        @html.br
                                        @html.a('Maintenance Information', 'href'=>'#resourceInfo-maintInfo')
                                    end
                                    @html.br
                                    @html.a('Other Resource Information', 'href'=>'#resourceInfo-other')
                                end
                                @html.a('Data Dictionary Section','href'=>'#dataDictionary')
                                @html.br
                                @html.a('Resource Distribution Section','href'=>'#resourceDistribution')
                                @html.br
                                @html.a('Associated Resources Section','href'=>'#associatedResource')
                                @html.br
                                @html.a('Additional Documentation Section','href'=>'#additionalDocuments')
                            end
                            @html.hr

                            # metadata source
                            @html.h2('Metadata Source', 'id'=>'metadata-source')
                            @html.section(:class=>'block') do
                                @html.em('Metadata schema:')
                                @html.text!(intObj[:schema][:name])
                                @html.br

                                @html.em('Schema version:')
                                @html.text!(intObj[:schema][:version])
                            end
                            @html.hr

                            # metadata information section
                            @html.h2('Metadata Information', 'id'=>'metadataInfo')
                            if !hMetaInfo.empty?
                                @html.section(:class=>'block') do
                                   htmlMetaInfo.writeHtml(hMetaInfo)
                                end
                            end
                            @html.hr

                            # resource information section
                            @html.h2('Resource Information', 'id'=>'resourceInfo')
                            @html.section(:class=>'block') do
                                htmlResInfo.writeHtml(hMetadata[:resourceInfo])
                            end
                            @html.hr

                            # data dictionary section
                            @html.h2('Data Dictionary', 'id'=>'dataDictionary')
                            aDataDict.each do |hDictionary|
                                @html.section(:class=>'block') do

                                    # get dictionary title from the citation
                                    sTitle = hDictionary[:dictionaryInfo][:dictCitation][:citTitle]
                                    @html.details do
                                        @html.summary(sTitle, {'class'=>'h3'})
                                        @html.section(:class=>'block') do
                                            htmlDataD.writeHtml(hDictionary)
                                        end
                                    end

                                end
                            end
                            @html.hr

                            # resource distribution section
                            @html.h2('Resource Distribution', 'id'=>'resourceDistribution')
                            aDistributor.each do |hDistributor|
                                @html.section(:class=>'block') do

                                    # get distributor name from contact orgName
                                    contId = hDistributor[:distContact][:contactId]
                                    hCont = ADIWG::Mdtranslator::Writers::Html::MdHtmlWriter.getContact(contId)
                                    distName = hCont[:orgName]
                                    if distName.nil?
                                        distName = 'Other'
                                    end
                                    @html.details do
                                        @html.summary(distName, {'class'=>'h3'})
                                        @html.section(:class=>'block') do
                                            htmlDist.writeHtml(hDistributor)
                                        end
                                    end

                                end
                            end
                            @html.hr

                            # associated resource section
                            @html.h2('Associated Resources', 'id'=>'associatedResource')
                            aAssRes.each do |hAssRes|
                                @html.section(:class=>'block') do

                                    # get document title from the citation
                                    hCitation = hAssRes[:resourceCitation]
                                    if !hCitation.empty?
                                        sTitle = hCitation[:citTitle]
                                    else
                                        sTitle = 'Resource'
                                    end

                                    @html.details do
                                        @html.summary(sTitle, {'class'=>'h4'})
                                        @html.section(:class=>'block') do
                                            htmlAssRes.writeHtml(hAssRes)
                                        end
                                    end

                                end
                            end
                            @html.hr

                            # additional documentation section
                            @html.h2('Additional Documentation', 'id'=>'additionalDocuments')
                            aAddDocs.each do |hAddDoc|
                                @html.section(:class=>'block') do

                                    # get document title from the citation
                                    sTitle = hAddDoc[:citation][:citTitle]
                                    @html.details do
                                        @html.summary(sTitle, {'class'=>'h4'})
                                        @html.section(:class=>'block') do
                                            htmlAddDoc.writeHtml(hAddDoc)
                                        end
                                    end

                                end
                            end
                            @html.hr

                            #Load leaflet
                            @html.link( :rel => 'stylesheet', :href => 'http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css')
                            @html.script('', :src => 'http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js')

                            # add inline javascript
                            # read javascript from file
                            path = File.join(File.dirname(__FILE__), 'html_bodyScript.js')
                            file = File.open(path, 'r')
                            js = file.read
                            file.close

                            @html.script('type'=>'text/javascript') do
                                @html << js
                            end

                        end # body
                    end # def writeHtml
                end # class

            end
        end
    end
end
