<!DOCTYPE html>
<html>
    <head>
        <!-- Force Internet Explorer 8 to override compatibility mode -->
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" >
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
        <title>${grailsApplication.config.com.recomdata.searchtool.appTitle}</title>
        
        <!-- jQuery CSS for cupertino theme -->
        <link rel="stylesheet" href="${resource(dir:'css/jquery/ui', file:'jquery-ui-1.9.1.custom.css')}"></link>        
        <link rel="stylesheet" href="${resource(dir:'css/jquery/skin', file:'ui.dynatree.css')}"></link>        
        
        <!-- Our CSS -->
        <link rel="stylesheet" href="${resource(dir:'css', file:'jquery.loadmask.css')}"></link>
        <link rel="stylesheet" href="${resource(dir:'css', file:'main.css')}"></link>        
        <link rel="stylesheet" href="${resource(dir:'css', file:'rwg.css')}"></link>
        <link rel="stylesheet" href="${resource(dir:'css', file:'colorbox.css')}"></link>
        <link rel="stylesheet" href="${resource(dir:'css', file:'jquery/simpleModal.css')}"></link>
        <link rel="stylesheet" href="${resource(dir:'css', file:'jquery/multiselect/ui.multiselect.css')}"></link>
        <link rel="stylesheet" href="${resource(dir:'css', file:'jquery/multiselect/common.css')}"></link>
        <link rel="stylesheet" href="${resource(dir:'css', file:'jquery/jqueryDatatable.css')}"></link>
                                
        <!-- jQuery JS libraries -->
        <script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.min.js')}"></script>   
	    <script>jQuery.noConflict();</script> 
        
        <script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery-ui-1.9.1.custom.min.js')}"></script>
        
        <script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.cookie.js')}"></script>   
        <script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.dynatree.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.paging.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.loadmask.min.js')}"></script>   
 		<script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.ajaxmanager.js')}"></script>  
  		<script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.numeric.js')}"></script>
  		<script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.colorbox-min.js')}"></script>  
  		<script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.simplemodal.min.js')}"></script>  
  		<script type="text/javascript" src="${resource(dir:'js', file:'jQuery/jquery.dataTables.js')}"></script>
  		<script type="text/javascript" src="${resource(dir:'js', file:'facetedSearch/facetedSearchBrowse.js')}"></script>
  		<script type="text/javascript" src="${resource(dir:'js', file:'jQuery/ui.multiselect.js')}"></script>  
  		  
  		        
  		<!--Datatable styling and scripts-->
        <script type="text/javascript" src="${resource(dir:'js/', file:'jquery.dataTables.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/', file:'ColVis.min.js')}"></script> 
        <script type="text/javascript" src="${resource(dir:'js/', file:'ColReorderWithResize.js')}"></script>
  		        
  		<!--  SVG Export -->
  		<%--<script type="text/javascript" src="${resource(dir:'js', file:'svgExport/rgbcolor.js')}"></script>  --%>
  		  
	
        <g:javascript library="prototype" /> 
        <script type="text/javascript">
            var $j = jQuery.noConflict();
        </script>
        
        <!-- Our JS -->        
        <script type="text/javascript" src="${resource(dir:'js', file:'rwg.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js', file:'rwgsearch.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js', file:'maintabpanel.js')}"></script>
        
        <!-- Protovis Visualization library and IE plugin (for lack of SVG support in IE8 -->
        <%-- <script type="text/javascript" src="${resource(dir:'js/protovis', file:'protovis-r3.2.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/protovis', file:'protovis-msie.min.js')}"></script> --%>

		<tmpl:/RWG/urls />
		<script type="text/javascript" charset="utf-8">
	        var mouse_inside_options_div = false;
	        var sessionSearch = "${rwgSearchFilter}";
	        var searchPage = "RWG";

	        jQuery(document).ready(function() {

		        addToggleButton();

		        jQuery("#xtButton").colorbox({opacity:.75, inline:true, width:"95%", height:"95%"});
      
		        jQuery("#searchResultOptions_btn").click(function(){
		        	jQuery("#searchResultOptions").toggle();
		        });
		        
		        //used to hide the options div when the mouse is clicked outside of it

	            jQuery('#searchResultOptions_holder').hover(function(){ 
	            	mouse_inside_options_div=true; 
	            }, function(){ 
	            	mouse_inside_options_div=false; 
	            });

	            jQuery("body").mouseup(function(){ 
		            //top menu options
	                if(! mouse_inside_options_div ){
		                jQuery('#searchResultOptions').hide();
	                }

	                var analysisID = jQuery('body').data('heatmapControlsID');

	                if(analysisID > 1){
	            		jQuery('#heatmapControls_' +analysisID).hide();
		             }

	            });
	            
	            jQuery("#editMetadataOverlay").on('click', '#cancelmetadatabutton', function(){ 
	            	if (!confirm('Are you sure you want to cancel your changes?')) {return false;}
	            	jQuery('#editMetadataOverlay').fadeOut();
	            });
	            
	            jQuery("#editMetadataOverlay").on('click', '#savemetadatabutton', function() {
	            	var protoForm = $('editMetadataForm');
		            var serializedForm = Form.serialize(protoForm);
            		jQuery.ajax({
						url:saveFolderURL + "?" + serializedForm,	
						success: function(response) {
							jQuery('#editMetadataOverlay').fadeOut();
							showDetailDialog('/transmartApp/fmFolder/folderDetail/' + response.id);
						},
						error: function(xhr) {
						alert(xhr);
						}
					});
	            });
	            
	            
	            
	        	resizeAccordion();
                 
	        	jQuery('#sidebar').resizable({
                    handles: 'e',
                    maxWidth: 800,
                    minWidth: 150,
                    resize: function(event, ui){
                        var currentWidth = ui.size.width;
                        
                        // this accounts for padding in the panels + 
                        // borders, you could calculate this using jQuery
                        var padding = 12; 
                        
                        // this accounts for some lag in the ui.size value, if you take this away 
                        // you'll get some unstable behaviour
                        jQuery(this).width(currentWidth);
                        
                        jQuery('#box-search').width(currentWidth - 20)
                        jQuery('#program-explorer').width(currentWidth - 20)
                        // jQuery('#results-div').width(currentWidth -20)
                        // set the content panel width
                        jQuery('#main').width(jQuery('body').width() - currentWidth - padding);
                        jQuery('#filter-browser').css('left', jQuery('#box-search').width() + 50);
                    }
              });

	        	var xpos = jQuery('#menuLinks').offset()['right'];

	        });

	        jQuery(window).resize(function() {
				resizeAccordion();
			});
	        
			function resizeAccordion() {
				
				var windowHeight = jQuery(window).height();
	        	jQuery('#sidebar').height(jQuery(window).height()-30);
	        	jQuery('#main').height(jQuery(window).height()-30);
				var ypos = jQuery('#program-explorer').offset()['top'];
	        	
	        	var targetHeight = windowHeight - ypos - 90;
	        	jQuery('#results-div').height(targetHeight);
	        	jQuery('#welcome').height(windowHeight - 90);
	        	jQuery('#main').width(jQuery('body').width() - jQuery('#sidebar').width() - 12);
	        	jQuery('#box-search').width(jQuery('#program-explorer').width());
			}

			function updateExportCount() {
				var checkboxes = jQuery('#exporttable input:checked');
				
				if (checkboxes.size() == 0) {
					jQuery('#exportbutton').text('No files to export').addClass('disabled');
				}
				else {
					jQuery('#exportbutton').removeClass('disabled').text('Export selected files (' + checkboxes.size() + ')');
				}
			}

    function dataTableWrapper (containerId, tableId, title)
            {

                var data;
                var gridPanelHeaderTips;
                
                function setupWrapper()
                {
                    var gridContainer =  $j('#' + containerId);
                    gridContainer.html('<table id=\'' + tableId + '\'></table></div>');
                }

                function overrideSort() {

                    $j.fn.dataTableExt.oSort['numeric-pre']  = function(a) {
                        
                        var floatA = parseFloat(a);
                        var returnValue;
                        
                        if (isNaN(floatA))
                            returnValue = Number.MAX_VALUE * -1;    //Emptys will go to top for -1, bottom for +1   
                            else
                                returnValue = floatA;
                        
                            return returnValue;
                        };

                };

                this.loadData = function(dataIn) {


                    setupWrapper();
                    
                    data = dataIn;
                    setupGridData(data);
                    gridPanelHeaderTips = data.headerToolTips.slice(0);

                    //Add the callback for when the grid is redrawn
                    data.fnDrawCallback = function( oSettings ) {

                        //Add the tooltips to the header. This must happen every redraw because the datatables code destroys the html
                        $j(".dataTables_scrollHeadInner > table > thead > tr > th").each( function (index) {
                            
                            var titleAttr = $j(this).attr("title");
                            
                            if (titleAttr == null && gridPanelHeaderTips != null)
                            {
                                $j(this).attr("title", gridPanelHeaderTips[index]);            
                            }
                            
                        });

                    };

                    $j('#' + tableId).dataTable(data);

                    $j(window).bind('resize', function () {
                        $j('#' + tableId).dataTable().fnAdjustColumnSizing()
                      } );
                    
                     $j("#" + containerId + " div.gridTitle").html(data.iTitle);                  

                };
                

                function setupGridData(data)
                {
                    data.bAutoWidth = true;
                    data.bScrollAutoCss = true;
//                    data.sScrollY = 400;
                    data.sScrollX = "100%";
                    data.bDestroy = true;
                    data.bProcessing = true;
                    data.bLengthChange = false;
                    data.bScrollCollapse = false;
                    data.iDisplayLength = 100;
                    data.sDom = "<\"top\"<\"gridTitle\">p>Rrt<\"clear\">";    //This controls the grid layout and included functionality
                }
            }
		
//		var panel = createOntPanel()
//		jQuery('#metadata-viewer').empty()
 //           jQuery('#metadata-viewer').add(panel);
        </script>
          
        <script type="text/javascript">		
			jQuery(function ($) {
				// Load dialog on click of Save link
				$('#save-modal .basic').click(openSaveSearchDialog);
			});
		</script>
                  
       <r:layoutResources/>          
    </head>
    <body>
    
        <div id="header-div" class="header-div">        
            <g:render template="/layouts/commonheader" model="['app':'rwg', 'utilitiesMenu':'true']" />
        </div>
        
		<div id="sidebar" style="border-right:5px solid;border-color:#EDEEF6">
	       
	        <tmpl:/RWG/boxSearch />
			
				<div id="program-explorer" style="width: 290px">
		        <div id="title-program-div" class="ui-widget-header boxtitle">
			         <h2 style="float:left" class="title">Program Explorer</h2>
			    </div>
			    <div id="results-div" class="boxcontent" style="overflow: auto;">
			      	Results appear here
			    </div>
		    </div>
		    
		    <div id="filter-div" style="display: none;"></div>
			
		</div>
		 
		<div id="main">		     	
                <div id="folder-viewer">
                <div id="welcome-viewer">
                    <tmpl:welcome />
                </div>
                <div id="metadata-viewer">
				</div>
				<div id="subfolder-viewer">
                </div>
                </div>
				
				<div id="subject-view-div" style="display: none;" >
				
				</div>
				<div id="export-div" style="display: none;">
				
				</div>
		</div>

		<div id="hiddenItems" style="display:none">
		        <!-- For image export -->
		        <canvas id="canvas" width="1000px" height="600px"></canvas>  

		</div>
	
		<!--  This is the DIV we stuff the browse windows into. -->
		<div id="exportOverlay" class="overlay" style="display: none;">&nbsp;</div>
		<tmpl:editMetadataOverlay />
		<div id="divBrowsePopups" style="width:800px; display: none;">
			
		</div>
		
		<!--  Another DIV for the manhattan plot options. -->
		<div id="divPlotOptions" style="width:300px; display: none;">
			<table class="columndetail">
				<tr>
					<td class="columnname">SNP Annotation Source</td>
					<td>
						<select id="plotSnpSource" style="width: 220px">
							<option value="19">Human Genome 19</option>
							<option value="18">Human Genome 18</option>
						</select>
					</td>
				</tr>
				<%--<tr>
					<td class="columnname">Gene Annotation Source</td>
					<td>
						<select id="plotGeneSource" style="width: 220px">
							<option id="GRCh37">Human Gene data from NCBI</option>
						</select>
					</td>
				</tr>--%>
				<tr>
					<td class="columnname">P-value cutoff</td>
					<td>
						<input id="plotPvalueCutoff" style="width: 210px">
					</td>
				</tr>
			</table>
		</div>
		
		<!-- Everything for the across trial function goes here and is displayed using colorbox -->
		<div style="display:none">
			<div id="xtHolder">
				<div id="xtTopbar">
					<p>Cross Trial Analysis</p>
					<ul id="xtMenu">
						<li>Summary</li>
						<li>Heatmap</li>
						<li>Boxplot</li>
					</ul>
					<p>close</p>
				</div>
				<div id="xtSummary"><!-- Summary Tab Content --></div>
				<div id="xtHeatmap"><!-- Heatmap Tab Content --></div>
				<div id="xtBoxplot"><!-- Boxplot Tab Content --></div>
			</div>
		</div>

		<%-- Elements that are in fixed positions on the page --%>
		<div id="sidebartoggle">&nbsp;</div>
		<tmpl:/RWG/filterBrowser />
        	
       <!--  Used to measure the width of a text element (in svg plots) -->
       <span id="ruler" style="visibility: hidden; white-space: nowrap;"></span> 
	 <r:layoutResources/>
	 <g:overlayDiv divId="${overlayExportDiv}" />
	 </body>
</html>