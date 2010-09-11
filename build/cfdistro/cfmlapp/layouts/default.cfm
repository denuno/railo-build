<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html;
			charset=UTF-8">
		<link rel="stylesheet" type="text/css"
			href="<cfoutput>#resp.encodeURL('/assets/css/styles.css')#</cfoutput>"
			media="screen">
		<title>
			cfdistro
		</title>
		<!--[if IE 6]>
			<script type="text/javascript" src="js/ie6-transparency.js"></script>
			<script>
			    DD_belatedPNG.fix('#header h1, #header #header-img img, #header #header-img, #content .section .experience, #content .section .expertise, #content .section .education, #content .section .training, #content .section img');
			</script>
			<link rel="stylesheet" type="text/css" href="ie6.css" />
			<![endif]-->
		<!--[if IE 7]>
			<link rel="stylesheet" type="text/css" href="ie7.css" />
			<![endif]-->
		<!--[if IE 8]>
			<link rel="stylesheet" type="text/css" href="ie8.css" />
			<![endif]-->
	</head>
	<body>
		<div id="wrap">
			<div id="header-top">
			</div>
			<div id="header">
				<div id="header-content">
					<div style="float:right">
						<h4>
							Recent Test Results
						</h4>
						<ul>
							<li>
								<a href="index.html">
									consequat molestie
								</a>
							</li>
						</ul>
						<h4>
							Recent Builds
						</h4>
						<ul>
							<li>
								<a href="index.html">
									consequat molestie
								</a>
							</li>
						</ul>
					</div>
					<h1>
						cfdistro
					</h1>
					<!--end contact-details-->
					<div id="about-me">
						<h2>
							cfdistro
						</h2>
						<p>
							Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin a nibh mauris. Mauris interdum, dolor in vulputate tincidunt, mauris lorem feugiat augue, id tristique lacus est ac purus. Aenean nunc urna, vestibulum non viverra.
						</p>
					</div>
					<!--end about-me-->
				</div>
				<!--end header-content-->
				<div id="header-img" style="padding-left:20px">
					<h4>Distros</h4>
					<ul>
						<cfoutput>
							<li>
								<a href="#resp.encodeURL('index.cfm?action=distro.list')#" title="View the list of distros">
									List
								</a>
							</li>
							<li>
								<a href="#resp.encodeURL('index.cfm?action=distro.form')#" title="Fill out form to add new distro">
									Add New
								</a>
							</li>
						</cfoutput>
					</ul>
				<h3>cfdistro</h3>
				<ul>
					<cfoutput>
						<li>
							<a href="#resp.encodeURL("index.cfm?action=distro.loadpersisted")#" title="Loads any saved distros">
								Load Persisted Distros
							</a>
						</li>
						<li>
							<a href="#resp.encodeURL('index.cfm?action=distro.persist')#" title="Saves distros to disk">
								Persist All Distros
							</a>
						</li>
						<li>
							<a href="#resp.encodeURL('/index.cfm??action=distro.default&init=true')#" title="Resets framework cache">
								Reload App
							</a>
						</li>
					</cfoutput>
				</ul>
				</div>
				<!--end header-img-->
			</div>
			<!--end header-->
			<div class="line">
			</div>
			<div id="content">
				<div class="section">
				<cfoutput>
					#body#
				</cfoutput>
				</div>
			</div>
			<!--end content-->
			<div id="footer">
			</div>
		</div>
		<!--end wrap-->
	</body>
</html>
<cfabort />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
	"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=iso-8859-1"/>
		<meta name="description" content="description"/>
		<meta name="keywords" content="keywords"/>
		<meta name="author" content="author"/>
		<cfoutput>
			<link rel="stylesheet" type="text/css" href="#resp.encodeURL('/assets/css/styles.css')#" media="screen"/>
		</cfoutput>
		<title>
			cfdistro
		</title>
	</head>
	<body>
		<div class="container">
			<div class="main">
				<cfoutput>
					#body#
				</cfoutput>
			</div>
			<div class="navigation">
				<a href="index.cfm">
					<cfoutput>
						<img src="#resp.encodeURL('/assets/images/cfdistro.png')#" border="0">
					</cfoutput>
				</a>
				<h1>
					Distros
				</h1>
				<ul>
					<cfoutput>
						<li>
							<a href="#resp.encodeURL('index.cfm?action=distro.list')#" title="View the list of distros">
								List
							</a>
						</li>
						<li>
							<a href="#resp.encodeURL('index.cfm?action=distro.form')#" title="Fill out form to add new distro">
								Add New
							</a>
						</li>
					</cfoutput>
				</ul>
				<h1>
					Recent Test Results
				</h1>
				<ul>
					<li>
						<a href="index.html">
							consequat molestie
						</a>
					</li>
				</ul>
				<h1>
					Recent Builds
				</h1>
				<ul>
					<li>
						<a href="index.html">
							consequat molestie
						</a>
					</li>
				</ul>
				<h1>
					cfdistro
				</h1>
				<ul>
					<cfoutput>
						<li>
							<a href="#resp.encodeURL("index.cfm?action=distro.loadpersisted")#" title="Loads any saved distros">
								Load Persisted Distros
							</a>
						</li>
						<li>
							<a href="#resp.encodeURL('index.cfm?action=distro.persist')#" title="Saves distros to disk">
								Persist All Distros
							</a>
						</li>
						<li>
							<a href="#resp.encodeURL('/index.cfm??action=distro.default&init=true')#" title="Resets framework cache">
								Reload App
							</a>
						</li>
					</cfoutput>
				</ul>
			</div>
			<div class="clearer">
				<span>
				</span>
			</div>
			<cfoutput>
				<div class="footer">
					&copy; 2006
					<a href="#resp.encodeURL('/')#">
						cfdistro
					</a>
					. Valid
					<a href="http://jigsaw.w3.org/css-validator/check/referer">
						CSS
					</a>
					&amp;
					<a href="http://validator.w3.org/check?uri=referer">
						XHTML
					</a>
					. Template design by
					<a href="http://templates.arcsin.se">
						Arcsin
					</a>
			</cfoutput>
			</div>
		</div>
	</body>
</html>
