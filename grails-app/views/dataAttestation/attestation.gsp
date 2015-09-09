<!--
  tranSMART - translational medicine data mart
  
  Copyright 2008-2012 Janssen Research & Development, LLC.
  
  This product includes software developed at Janssen Research & Development, LLC.
  
  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
  as published by the Free Software  * Foundation, either version 3 of the License, or (at your option) any later version, along with the following terms:
  1.	You may convey a work based on this program in accordance with section 5, provided that you retain the above notices.
  2.	You may convey verbatim copies of this program code as you receive it, in any medium, provided that you retain the above notices.
  
  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS    * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
  
 
-->

<head>
    <meta name='layout' content='main' />
    <title>Neptune Data Attestation Agreement</title>
</head>
<body>
<g:javascript src="tracking/track.js" />
<center>
    <div style="width: 400px; margin: 50px auto 50px auto;">
        <img style="display: block; margin: 12px auto;" src="${resource(dir: 'images', file: grailsApplication.config.com.recomdata.largeLogo)}" alt="Transmart" />
        <center><h1>ATTENTION: Users of ${grailsApplication.config.com.recomdata.searchtool.appTitle}</h1></center>
        <div style="text-align: justify; margin: 18px;">
        <p>
        It is the responsibility of all users to protect the privacy of individuals who are subjects in the data; 
        to not use or disclose the data other than as permitted; and to appropriately secure the data.</p>
        <p>
		By clicking “I agree” below, users agree to the following:
		<ul style="list-style-type: square; list-style-position: outside; padding-left: 18px;">
		<li>No attempt shall be made to link subject data to a NEPTUNE participant.</li>
		<li>Any disclosure of data, analysis, or results  from tranSMART must be in accordance
		with appropriate NEPTUNE policies and procedures.</li>
		<li>Further data analysis on hypotheses generated via tranSMART will be done via 
		existing NEPTUNE policies and procedures.</li>
		<li>Data may not be disclosed, downloaded, or shared unless appropriate 
		Material Transfer Agreements are in place.</li>
		<li>As NEPTUNE data are still being collected and cleaned, there will be periodic, 
		announced updates to the data in tranSMART, with resulting possible changes in analysis results.</li>
		</ul>
		</p>
        </div>
        <center>
            <g:form name="dataAttestation" method="post" id="dataAttestation">
                <g:actionSubmit value="I agree" action="agree" />
                <g:actionSubmit value="I disagree" action="disagree" />
            </g:form>
        </center>
    </div>
</center>
<r:layoutResources/>
</body>
