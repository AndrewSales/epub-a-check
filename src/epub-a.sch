<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns uri="http://www.w3.org/1999/xhtml" prefix="xh"/>
    <!--
Possible EPUB/A restriction	RELAX NG	Schematron	Difficulty	Notes

Prohibit inline scripting	○	◎	Low	Also check event attributes such as onclick
Prohibit specified media types	◎	◎	Low	Check media-type on OPF manifest items
Restrict media types to an EPUB/A whitelist	◎	◎	Low	Suitable for archival-format restrictions
Restrict use of fallbacks	○	◎	Low	Check relationships among OPF attributes
Prohibit bindings	◎	◎	Very low	Depending on the EPUB version targeted
Restrict particular uses of collections	○	◎	Low	Based on OPF structure
Restrict encryption.xml	○	◎	Low–Medium	E.g., permit only specified encryption mechanisms
Prohibit DRM or other encryption	△	○	Medium	Cross-checking container resources may require code
Require additional package metadata	◎	◎	Very low	E.g., EPUB/A-specific identification
Require EPUB/A version/profile metadata	◎	◎	Very low	Especially easy if EPUB/A defines a profile declaration
Restrict values of particular metadata properties	◎	◎	Low	Datatype or pattern restrictions
Restrict date formats such as dc:date	◎	◎	Low	Can use datatype/pattern constraints
Restrict identifier syntax	◎	◎	Low	Depending on EPUB/A requirements
Require particular navigation types in nav	○	◎	Low	E.g., landmarks
Require or prohibit particular epub:type values	○	◎	Low	Convenient with XPath
Prohibit particular XHTML elements	◎	◎	Very low	A natural use of RELAX NG
Prohibit particular XHTML attributes	◎	◎	Very low	Same as above
Restrict use of SVG features	◎	◎	Low–Medium	More involved if SVG content itself must be inspected
Restrict use of MathML features	◎	◎	Low–Medium	Same consideration as SVG        
        -->
    
    <!-- Prohibit external URIs:
Prohibit external URIs in audio/@src	◎	◎	Low	Can be checked from the URI value
Prohibit external URIs in video/@src	◎	◎	Low	Same as above
Prohibit external URIs in source/@src	◎	◎	Low	For audio/video sources
Prohibit external URIs in track/@src	◎	◎	Low	E.g., WebVTT tracks
Prohibit external URIs in img/@src	◎	◎	Low	If EPUB/A prohibits remote images
Prohibit external URIs in object/@data	◎	◎	Low	If object is permitted
Prohibit external URIs in iframe/@src	◎	◎	Low	Prohibiting iframe entirely may be simpler
Prohibit external URIs in script/@src	◎	◎	Low	External JavaScript
Prohibit external URIs in link/@href	○	◎	Low	Stylesheets and other linked resources
Prohibit remote resources in general	△	◎	Low–Medium	Explicitly enumerating relevant attributes may be safer-->        
    <pattern id="external-uris" abstract="true">
        <rule context="$element">
            <report test="matches($attribute, '^[a-z]+:/+')">element <name/> should not have a <name path="$attribute"/> containing an external URI: <value-of select="$attribute"/></report>
        </rule>
    </pattern>
    
    <pattern is-a="external-uris" id="external-uris-src">
        <param name="element" value="xh:audio | xh:video | xh:source | xh:track | xh:img | xh:iframe | xh:script"/>
        <param name="attribute" value="@src"/>
    </pattern>
    
    <pattern is-a="external-uris" id="external-uris-data">
        <param name="element" value="xh:object"/>
        <param name="attribute" value="@data"/>
    </pattern>
    
    <pattern is-a="external-uris" id="external-uris-href">
        <param name="element" value="xh:link"/>
        <param name="attribute" value="@href"/>
    </pattern>
    
    <!-- Prohibit certain elements:
Prohibit iframe	◎	◎	Very low	Can simply be excluded from the grammar
Prohibit object	◎	◎	Very low	Same as above
Prohibit scripting	◎	◎	Low	Straightforward for script elements-->
    
    <pattern id="disallowed" abstract="true">
        <rule context="$element">
            <report test=".">element <name/> is not allowed</report>
        </rule>
    </pattern>
    
    <pattern id="disallowed-elements" is-a="disallowed">
        <param name="element" value="xh:iframe | xh:object | xh:script"/>
    </pattern>
</schema>