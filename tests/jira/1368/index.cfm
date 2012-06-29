<cfsetting showdebugoutput="no">

<cfimage action="read" source="mapa.tiff" name="tiff">
<cfimage action="read" source="mapa.tif" name="tif">


<cfimage action="write" source="#tif#" destination="result-mapa-tif.png" overwrite=true>
<cfimage action="write" source="#tiff#" destination="result-mapa-tiff.png" overwrite=true>
<cfimage action="write" source="#tif#" destination="result-mapa-tif.tif" overwrite=true>
<cfimage action="write" source="#tiff#" destination="result-mapa-tiff.tiff" overwrite=true>


<cfimage action="read" source="circle.pnm" name="pnm">
<cfimage action="write" source="#pnm#" destination="result-circle.pnm.png" overwrite=true>
<cfimage action="write" source="#pnm#" destination="result-circle.pnm.pnm" overwrite=true>

<cf_valueEquals left="" right="">