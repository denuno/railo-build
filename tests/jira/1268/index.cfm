<cfsetting showdebugoutput="no">

<cfset orgContent = "find me">
<cfset replacementString = "New Stuff: \a \b \c \d \e \f \g \h \i \j \k \l \m \n \o \p \q \r \s \t \u \v \w \x \y \z \A \B \C \D \E \F \G \H \I \J \K \L \M \N \O \P \Q \R \S \T \U \V \W \X \Y \Z">

<cf_valueEquals 
	left="#REReplaceNoCase(orgContent,"find me", replacementString)#" 
    right="New Stuff: \a \b \c \d \e \f \g \h \i \j \k  \m \n \o \p \q \r \s \t  \v \w \x \y \z \A \B \C \D  \F \G \H \I \J \K  \m \n \o \p \q \r \s \t  \V \W \X \Y \Z">
<cf_valueEquals 
	left="#REReplace(orgContent,"find me", replacementString)#" 
    right="New Stuff: \a \b \c \d \e \f \g \h \i \j \k  \m \n \o \p \q \r \s \t  \v \w \x \y \z \A \B \C \D  \F \G \H \I \J \K  \m \n \o \p \q \r \s \t  \V \W \X \Y \Z">
