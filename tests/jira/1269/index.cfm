<cfsetting showdebugoutput="no">
<cfscript>

// first clean all existing records
bookmarks=entityLoad("Bookmark");
len=arrayLen(bookmarks);
for(i=1;i<=len;i++) {
	entityDelete(bookmarks[i]);
}
ormFlush();





// store a bookmark with a tag
bookmark1=entityNew("Bookmark");
bookmark2=entityNew("Bookmark");
tag1=entityNew("Tag");
tag2=entityNew("Tag");
bookmark1.addTags(tag1);
tag1.addBookmarks(bookmark1);
bookmark2.addTags(tag2);
tag2.addBookmarks(bookmark2);

entitySave(bookmark1);
entitySave(tag1);
entitySave(bookmark2);
entitySave(tag2);
ormFlush();
	
// get bookmark and tag
bookmarks=entityLoad("Bookmark");
bookmark1=bookmarks[1];
bookmark2=bookmarks[2];
tags1=bookmark1.getTags();
tags2=bookmark2.getTags();
tag1=tags1[1];
tag2=tags2[1];

</cfscript>
<cf_valueEquals left="#arrayLen(bookmarks)#" right="2">
<cf_valueEquals left="#arrayLen(tags1)#" right="1">
<cf_valueEquals left="#arrayLen(tags2)#" right="1">

<cf_valueEquals left="#bookmark1.hasTags(tag1)#" right="true">
<cf_valueEquals left="#tag1.hasBookmarks(bookmark1)#" right="true">

<cf_valueEquals left="#bookmark2.hasTags(tag2)#" right="true">
<cf_valueEquals left="#tag2.hasBookmarks(bookmark2)#" right="true">

<cf_valueEquals left="#bookmark2.hasTags(tag1)#" right="false">
<cf_valueEquals left="#tag2.hasBookmarks(bookmark1)#" right="false">

<cf_valueEquals left="#bookmark1.hasTags(tag2)#" right="false">
<cf_valueEquals left="#tag1.hasBookmarks(bookmark2)#" right="false">

<cf_valueEquals left="#tag1.hasBookmarks(entityNew("Tag"))#" right="false">
<cf_valueEquals left="#bookmark1.hasTags(entityNew("Bookmark"))#" right="false">










