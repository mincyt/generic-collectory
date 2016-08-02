<g:set var="orgNameLong" value="${grailsApplication.config.skin.orgNameLong}"/>
<g:set var="orgNameShort" value="${grailsApplication.config.skin.orgNameShort}"/>
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <meta name="app.version" content="${g.meta(name:'app.version')}"/>
   <meta name="app.build" content="${g.meta(name:'app.build')}"/>
   <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
   <g:if test="${instance}">
        <meta name="description" content="${orgNameLong} description of the ${instance?.name}. ${instance?.makeAbstract(200)}"/>
   </g:if>
   <g:else>
        <meta name="description" content="Explore ${orgNameLong}'s Natural History Collections."/>
   </g:else>
   <title><g:layoutTitle /> | ${orgNameLong}</title>
   <g:render template="/layouts/global"/>
   <r:require modules="jquery, jquery_migration, bootstrap, application, collectory, generic" />
   <r:script disposition='head'>
        // initialise plugins
        jQuery(function(){
            // autocomplete on navbar search input
            jQuery("form#search-form-2011 input#search-2011, form#search-inpage input#search, input#search-2013").autocomplete('http://bie.ala.org.au/search/auto.jsonp', {
                extraParams: {limit: 100},
                dataType: 'jsonp',
                parse: function(data) {
                    var rows = new Array();
                    data = data.autoCompleteList;
                    for(var i=0; i<data.length; i++) {
                        rows[i] = {
                            data:data[i],
                            value: data[i].matchedNames[0],
                            result: data[i].matchedNames[0]
                        };
                    }
                    return rows;
                },
                matchSubset: false,
                formatItem: function(row, i, n) {
                    return row.matchedNames[0];
                },
                cacheLength: 10,
                minChars: 3,
                scroll: false,
                max: 10,
                selectFirst: false
            });

            // Mobile/desktop toggle
            // TODO: set a cookie so user's choice is remembered across pages
            var responsiveCssFile = $("#responsiveCss").attr("href"); // remember set href
            $(".toggleResponsive").click(function(e) {
                e.preventDefault();
                $(this).find("i").toggleClass("icon-resize-small icon-resize-full");
                var currentHref = $("#responsiveCss").attr("href");
                if (currentHref) {
                    $("#responsiveCss").attr("href", ""); // set to desktop (fixed)
                    $(this).find("span").html("Mobile");
                } else {
                    $("#responsiveCss").attr("href", responsiveCssFile); // set to mobile (responsive)
                    $(this).find("span").html("Desktop");
                }
            });

            $('.helphover').popover({animation: true, trigger:'hover'});
        });
    </r:script>
    <r:layoutResources/>
    <g:layoutHead />
</head>
<body class="${pageProperty(name:'body.class')?:'nav-collections'}" id="${pageProperty(name:'body.id')}" onload="${pageProperty(name:'body.onload')}">

<div class="container">
	<div class="row" >
		<div class="span2">&nbsp;</div>
		<div class="span4">
		
		  <a href="#"><g:img dir="images" file="logo_portal.png"  alt="Portal del SNDB" /></a>
		</div>
		<div class="span4">
		  <a href="#" class="pull-right"><g:img dir="images" file="logo_datos_biologicos.png" alt="Sistemas Nacionales - Datos Biológicos" /></a>
		</div>
		<div class="span2">&nbsp;</div>
	</div>
</div>
<div class="navbar navbar-inverse" >
	  <div class="navbar-inner" style="padding:0;">
		<ul class="nav" >
			<li><a href="/">INICIO</a></li>
			<li><a href="/generic-hub/occurrences/search?q=*%3A*#tab_mapView">DATOS GEOREFERENCIADOS</a></li>
			<li><a href="/collectory/datasets">SETS DE DATOS</a></li>
			<li><a href="/collectory">COLECCIONES</a></li>
		</ul>
	  </div>
</div>

    <div class="container" id="main-content">
        <g:layoutBody />
    </div><!--/.container-->

	<div id="footer">
		<div id="footer_logos" class="container-fluid" >
			<div class="container text-center" style="padding-top:20px;">
				  <a href="#"><g:img dir="images" file="logo_mincyt.png" alt="Ministerio de Ciencia, Tecnología e Innovación Productiva" /></a>
				  <a href="#"><g:img dir="images" file="logo_crowdin.png" alt="Crowdin" /></a>
				  <a href="#"><g:img dir="images" file="logo_australia.png" alt="Atlas of living australia" /></a>
				  <a href="#"><g:img dir="images" file="logo_gbif.png" alt="GBIF.org" /></a>
				</div>
			</div>
		</div>
		<div id="footer_nav">
			<div class="container text-center row">
				<div class="span3" id="disclaimer-box">
				  <p>Estamos ajustando algunas funcionalidades del portal. Disculpe las molestias que esto pueda ocasionar.</p>
				  <p>Si observa cualquier incidencia agradeceríamos que nos la comunicase mediante mensaje a sndb@mincyt.gob.ar</p>
				</div>
				<div class="span3" id="contact-box">
				 <p>
					Godoy Cruz 2320, 2° piso (C1425FQD)<br/>
					Ciudad Autónoma de Buenos Aires<br/>
					República Argentina<br/>
					Tel/Fax.: (54-11) 4899-5000 Int. 2182<br/>
                                 </p>
				</div>
				<div class="span3" id="navigation-box">
					<ul class="white" >
						<li><a href="./">INICIO</a></li>
						<li><a href="/generic-hub/occurrences/search?q=*%3A*#tab_mapView">DATOS GEOREFERENCIADOS</a></li>
						<li><a href="/collectory/datasets">SETS DE DATOS</a></li>
						<li><a href="/collectory">COLECCIONES</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

<!-- JS resources-->
<r:layoutResources/>
</body>
</html>
