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

	<div id="mincyt_header">
		<g:img dir="images" file="banner_SNDB.jpg" alt="banner Sistema Nacional de Datos Biologicos" width="990" height="180" border="0" usemap="#Map" />
		<map name="Map" id="Map">
		  <area shape="rect" coords="40,51,253,128" href="http://www.mincyt.gob.ar" target="_blank" alt="Ir a Ministerio de Ciencia, Tecnologia e Innovación Productiva">
		</map>
	</div>

    <div class="container" id="main-content">
        <g:layoutBody />
    </div><!--/.container-->

	<div id="pie"></div><!--/#footer -->

<!-- JS resources-->
<r:layoutResources/>
</body>
</html>
