<cfsetting showdebugoutput="no">
<cflock scope="APPLICATION" type="EXCLUSIVE" timeout="10" throwontimeout="Yes">
<cfscript>
Application.CountKernel=StructNew();
Application.CountKernel.ScountElement=StructNew();
Application.CountKernel.ScountElement.Items=ArrayNew(1);
Application.CountKernel.ScountElement.ListCode="";
Application.CountKernel.ScountElement.Ident="";
Application.CountKernel.ScountElement.Version="";
Application.CountKernel.ScountElement.GrandTotal="N/A";
Application.CountKernel.ScountElement.Description="";
Application.CountKernel.ScountElement.Note="";
Application.CountKernel.ScountElement.Options="";
Application.CountKernel.ScountElement.ListOptions="";

Application.CountKernel.ItemElement=StructNew();
Application.CountKernel.ItemElement.Name="";
Application.CountKernel.ItemElement.Data=ArrayNew(1);
Application.CountKernel.ItemElement.Type="";
Application.CountKernel.ItemElement.GroupID="0";
Application.CountKernel.ItemElement.OmitFlag="0";
Application.CountKernel.ItemElement.AutoStat="";
Application.CountKernel.ItemElement.ColumnName="";
Application.CountKernel.ItemElement.RangeSeparator="";
Application.CountKernel.ItemElement.Description="";
Application.CountKernel.ItemElement.CheckExpr="";
</cfscript>

<cfset Sleep(1000) />

<cfscript>
Application.CountKernel.DataElement=StructNew();
Application.CountKernel.DataElement.Code="";
Application.CountKernel.DataElement.Text="";
Application.CountKernel.DataElement.Total="N/A";
Application.CountKernel.DataElement.Items=ArrayNew(1);

Application.CountKernel.ResultVar = StructNew();
Application.CountKernel.ResultVar.ErrorCode = 0;
Application.CountKernel.ResultVar.isChanged = false;
Application.CountKernel.ResultVar.Duplicated = ArrayNew(1);
Application.CountKernel.ResultVar.Added = ArrayNew(1);
Application.CountKernel.ResultVar.Deduped = ArrayNew(1);
Application.CountKernel.ResultVar.Skipped = ArrayNew(1);

Application.CountKernelVarsFlag=true;
</cfscript>
</cflock>

<cflock scope="APPLICATION" type="ReadOnly" timeout="10" throwontimeout="Yes">
<cfset strRes = StructCopy(Application.CountKernel.ResultVar)>
<!---<cfdump var="#strRes#">--->
</cflock>